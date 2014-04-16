require 'nokogiri'

namespace :convert do

  desc 'Reset and import everything'
  task :reset => ['db:reset', :all]

  def process_people
    @doc.xpath('/TEI.2/teiHeader/profileDesc/textClass/keywords[@scheme="LCSH"]')
  end

  def get_docs
    @doc.xpath('/TEI.2/text/group/text//div1[@type="case"]')
  end

  def parse_file
    @doc ||= Nokogiri::XML(File.open('./lib/assets/BoySalCombined.xml'))
  end

  task :documents => :environment do 
    parse_file

    court_docs = get_docs

    court_docs.each do |court_doc|
      puts court_doc.attr('id')
    end

  end

  task :people => :environment do
    parse_file
    names = process_people

    names.children.each do |name|

      Name.create(
        key: name.attr('id'),
        name: name.text
      ) unless name.attr('id').nil?

    end
  end

  task :all => [:environment, :people] do

  end
end
