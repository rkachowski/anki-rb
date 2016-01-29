Dir.glob(File.join(__FILE__, '*/**/*.rb')).map{|m| m.pathmap '%X' }.each do |file|
  require file
end

module Anki

end
