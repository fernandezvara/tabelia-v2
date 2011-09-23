class GraphClient

  def self.server
    "http://localhost:9000/"
  end

  # returns the objects related
  def self.get(direction, relation, obj)
    data = Net::HTTP.get(URI.parse("http://localhost:9000/get/#{direction}/#{relation}/#{obj.class.to_s}/#{obj.id.to_s}"))
    
    begin
      array = ActiveSupport::JSON.decode(data)
      objs = Array.new
      array.each do |relation|
        begin
          objs << relation['do'].constantize.find(relation['di'])
        rescue
        end
      end
      return objs  
    rescue
      return []
    end
  end
  
  def self.get_count(direction, relation, obj)
    data = Net::HTTP.get(URI.parse("http://localhost:9000/get_count/#{direction}/#{relation}/#{obj.class.to_s}/#{obj.id.to_s}"))
    #begin
      return data
    #rescue
      #return []
    #end
  end
  
  def self.new(relation, obj, obj2)
    data = Net::HTTP.get(URI.parse("http://localhost:9000/new/#{relation}/#{obj.class.to_s}/#{obj.id.to_s}/#{obj2.class.to_s}/#{obj2.id.to_s}"))
    return ActiveSupport::JSON.decode(data)['ok'].to_s
  end
  
  def self.connected?(direction, relation, obj, obj2)
    data = Net::HTTP.get(URI.parse("http://localhost:9000/are_linked/#{direction}/#{relation}/#{obj.class.to_s}/#{obj.id.to_s}/#{obj2.class.to_s}/#{obj2.id.to_s}"))
    answer = ActiveSupport::JSON.decode(data)
    if answer == []
      return false
    else
      begin
        return answer[0]['at'].to_datetime
      rescue
        return false
      end
    end
  end
end