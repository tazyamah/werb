# -*- coding: utf-8 -*-
require "#{File.dirname(__FILE__)}/werb/version"
require 'rack/request'
require 'rack/response'
require 'erb'

module Werb
  class << self
    def app
      Werb::Dispatcher.new
    end
  end

  class View
    include ERB::Util
    attr_accessor :request, :status_code, :content_types, :content_body

    def initialize(request)
      @status_code = 200
      @request = request
      @content_types = {}
    end

    def render
      self.content_body = result # ERB#def_class's method
    end
  end

  class Dispatcher
    def call(env)
#      begin
        req = Rack::Request.new(env)
        path = route_to_path(req.fullpath)

        if ( erb = requested_erb(path) )
          view_clazz = ERB.new(read_file(erb)).def_class(Werb::View)
          view = view_clazz.new(req)
          view.render
          create_response view
        else
          static_response path
        end
#      rescue => e
#        create_response 500, e.message
#      end
    end

    private

    def create_response(view)
      res = Rack::Response.new do |r|
        r.status = view.status_code
        view.content_types.each do |k,v|
          r[k] = v
        end
        r.write view.content_body
      end
      res.finish
    end

    def requested_erb(path)
      suffixes = path[-1] == "/" ?  ["index.html.erb"] : ["/index.html.erb"]
      suffixes += [".html.erb"]

      suffixes.each do |e|
        return path+e unless Dir[path+e].empty?
      end
      nil
    end

    def static_response(path)
      return not_found_response unless Dir[path].empty?
      res = Rack::Response.new do |r|
        r.status = 200
        r['Content-Type'] = MIME::Types.type_for(path)[0].to_s
        r.write read_file(path)
      end
      res.finish
    end

    def not_found_response
      Rack::Response.new([], 404).finish
    end

    def route_to_path(route)
      raise Werb::DirectoryTraversalError if route.include? ".."
      File.join(WERB_DOCUMENT_ROOT, route)
    end

    def read_file(path)
      open(path){|io|io.read}
    end
  end

  class DirectoryTraversalError < Exception; end
end
