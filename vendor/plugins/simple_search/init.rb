require 'active_record'
require 'simple_search'
ActiveRecord::Base.send(:extend, SearchPlugin::SimpleSearch)