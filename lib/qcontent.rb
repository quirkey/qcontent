$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Qcontent
  VERSION = '0.0.1'
  
  def content_type
    self.class.to_s.tableize
  end
  
end

require 'rubygems'
require 'money'

%w{
  extensions
  pricing
  assets
  dimension
  published
}.each {|lib| require "qcontent/#{lib}" }