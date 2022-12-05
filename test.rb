Dir.glob("test/*.rb").each do |test|
    require_relative test
end
