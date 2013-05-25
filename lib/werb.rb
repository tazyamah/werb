# -*- coding: utf-8 -*-
require "#{File.dirname(__FILE__)}/werb/version"
require "#{File.dirname(__FILE__)}/werb/core"

module Werb
  class << self
    def app
      Werb::Core.new
    end
  end
end
