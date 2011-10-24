class SolrUpdate
  @queue = :solr
  
  def self.perform(klass, id)
    puts "updating '#{id}' "
    o = klass.constantize.find(id)
    o.solr_index
  end
  
end