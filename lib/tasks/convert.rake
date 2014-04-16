require 'nokogiri'

namespace :convert do

  desc 'Reset and import everything'
  task :reset => ['db:reset', :all]

  def process_people
    @doc.xpath('/TEI.2/teiHeader/profileDesc/textClass/keywords[@scheme="LCSH"]')
  end

  def parse_file
    @doc = Nokogiri::XML(File.open('./lib/assets/BoySalCombined.xml'))
  end

  task :people => :environment do
    parse_file
    names = process_people

    names.children.each do |name|
      puts "#{name.attr('id')} #{name.text}" unless name.attr('id').nil?
    end
  end

  task :all => [:environment, :people] do
    
  end
end
