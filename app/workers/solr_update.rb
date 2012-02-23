class SolrUpdate
  @queue = :solr
  
  def self.perform(klass, id)
    o = klass.constantize.find(id)
    if o.nil? 
      puts "#{klass} -> '#{id}' => nil"
    else
      puts "updating #{klass} -> '#{id}' "
    end
    o.solr_index!
  end
  
end