require 'yaml'
require 'fileutils'
require 'logger'
require 'selenium-webdriver'

require_relative 'config/config'
require_relative 'logging'
require_relative 'config/web_driver_manager'

require_relative 'pages/page'
require_relative 'pages/collection_space_pages'
require_relative 'pages/homepages'
require_relative 'pages/core/core_homepage'
