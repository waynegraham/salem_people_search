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

  def find_person(key)
    Name.find_by_key(key)
  end

  task :people_documents => :environment do
    parse_file

    court_docs = get_docs

    court_docs.each do |court_doc|

      court_doc.xpath('./div2').each do |doc|
        doc_id = doc.attr('id')

        c = Case.find_by doc_id:  doc_id

        court_doc.xpath('.//name[@type="person"]').each do |name|
           key = name.attr('key')
           n = Name.find_by_key key
           Mention.create(
              case_id: c.id,
              name_id: n.id
           ) unless n.nil?
           "adding mention for #{c.doc_id}"
           #puts "#{c.id} | #{n.id}" unless n.nil?
        end
      end

    end


  end

  task :documents => :environment do
    parse_file

    court_docs = get_docs

    court_docs.each do |court_doc|
       case_id = court_doc.attr('id')

       court_doc.xpath('./div2').each do |doc|

         Case.create(
          case_id: case_id,
          doc_id: doc.attr('id'),
          doc_type: doc.attr('type'),
          content: doc
         )
        puts "Adding document #{doc.attr('id')}"
       end
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

  task :all => [:environment, :people, :documents, :people_documents] do

  end
end
