$stdout.sync = $stderr.sync = true
ENV['RACK_ENV'] ||= 'development'
require 'bundler'
Bundler.require :default, ENV.fetch('RACK_ENV')
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '../app')
require 'soul_owner'