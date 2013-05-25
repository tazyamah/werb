# -*- coding: utf-8 -*-
require 'rack/request'
require 'rack/response'
require 'erb'

module Werb
  class Core
    def call(env)
      req = Rack::Request.new(env)

      begin
        create_response 200, load_erb(req.fullpath)
      rescue => e
        create_response 404, e.message
      end
    end

    private

    def create_response(status, body, options={})
      res = Rack::Response.new do |r|
        r.status = status
        r['Content-Type'] = 'text/html;charset=utf-8'
        r.write body
      end
      res.finish
    end

    def load_erb(path)
      file = requested_file(path)
      content = open(file){|io|io.read}
      ERB.new(content).result
    end

    def requested_file(path)
      fpath = File.join(WERB_DOCUMENT_ROOT, path)

      ["/index.html.erb", "/index.html", ".html.erb", ".html", ".rb"].each do |e|
        return fpath+e unless Dir[fpath+e].empty?
      end
    end
  end
end
