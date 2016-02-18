$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ankirb'

def unzip_file zipfile
  Zip::File.open(zipfile) do |zip_file|
    zip_file.each {|file| file.extract(file.name)}
  end
end

require 'minitest/autorun'
