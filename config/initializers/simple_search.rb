require 'active_record'
require Rails.root.to_s +  "/lib/simple_search/simple_search"
ActiveRecord::Base.send(:extend, SearchPlugin::SimpleSearch)