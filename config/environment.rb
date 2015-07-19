# Load the Rails application.
require File.expand_path('../application', __FILE__)

#loading CarrierWave after loading your ORM
require 'carrierwave/orm/activerecord'

# Initialize the Rails application.
Rails.application.initialize!
