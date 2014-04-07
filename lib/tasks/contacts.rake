require './lib/load_contacts_from_file'
namespace :contacts do
  desc "Load contacts from a file"
  task :load => :environment do
    contacts = LoadContactsFromFile.load(ARGV[1])
    if contacts.count > 0
      puts "Errors while importing: "
      p contacts
    else
      puts "Contacts imported."
    end
  end
end
