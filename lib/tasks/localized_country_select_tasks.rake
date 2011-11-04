require 'rubygems'
require 'open-uri'

require File.expand_path("../../../config/environment", __FILE__)

# Rake task for importing country names from Unicode.org's CLDR repository
# (http://www.unicode.org/cldr/data/charts/summary/root.html).
# 
# It parses a HTML file from Unicode.org for given locale and saves the 
# Rails' I18n hash in the plugin +locale+ directory
# 
# Don't forget to restart the application when you add new locale to load it into Rails!
# 
# == Example
#   rake import:country_select 'de'
# 
# The code is deliberately procedural and simple, so it's easily
# understandable by beginners as an introduction to Rake tasks power.
# See http://github.com/joshmh/cldr/tree/master/converter.rb for much more robust solution

namespace :import do

  desc "Import country codes and names for various languages from the Unicode.org CLDR archive. Depends on Hpricot gem."
  task :country do
    begin
      require 'hpricot'
    rescue LoadError
      puts "Error: Hpricot library required to use this task (import:country_select)"
      exit
    end
    
    # TODO : Implement locale import chooser from CLDR root via Highline
    
    # Setup variables
    locale = ARGV[1]
    unless locale
      puts "\n[!] Usage: rake import:country_select de\n\n"
      exit 0
    end

    # ----- Get the CLDR HTML     --------------------------------------------------
    begin
      puts "... getting the HTML file for locale '#{locale}'"
      doc = Hpricot( open("http://www.unicode.org/cldr/data/charts/summary/#{locale}.html") )
    rescue => e
      puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
      exit 0
    end


    # ----- Parse the HTML with Hpricot     ----------------------------------------
    puts "... parsing the HTML file"
    countries = []
    doc.search("//tr").each do |row|
      if row.search("td[@class='n']") && 
         row.search("td[@class='n']").inner_html =~ /^namesterritory$/ && 
         row.search("td[@class='g']").inner_html =~ /^[A-Z]{2}/
        code   = row.search("td[@class='g']").inner_text
        code   = code[-code.size, 2]
        name   = row.search("td[@class='v']").inner_text
        countries << { :code => code.to_s, :name => name.to_s }
        
      end
    end

    I18n.with_locale(locale.to_sym) do

      countries.each do |country|
        puts "processing.... #{country[:name]}"
        
        country_entry = Country.where(:code => country[:code]).first
        
        if country_entry.nil? == true
          country_entry = Country.new
          country_entry.code = country[:code]
        end
        country_entry.name = country[:name]
  	    country_entry.save
      end
      
    end
  end
end
