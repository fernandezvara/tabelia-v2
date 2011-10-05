require 'faker'

namespace :db do
  desc 'crea 50.000 usuarios'
  task :populate => :environment do
    a = Time.now
    0.times do |n|
      if n % 100 == 0 
        puts "#{n}. #{(Time.now - a).to_i.to_s} segundos."
      end
      u = User.create!(
        :name => Faker::Name.name, 
        :email => n.to_s + "g@hotmail.com", 
        :password => '123456',
        :locale => 'en')
      u.save!
    end
    puts "#{(Time.now - a).to_i.to_s} segundos."
    
    puts "*** creando relaciones de tipo 1 ***"
    
    
    usercount = User.count
    (1..40000).each do |n|
      if n % 100 == 0 
        puts "#{n} rel. #{(Time.now - a).to_i.to_s} segundos."
      end
      
      user1 = User.skip(rand(usercount)).first
      user2 = User.skip(rand(usercount)).first
      
      rel = Graph.where(:re_type => user1.class.to_s, :re_id => user1.id, :rid => 1).first
      if rel.nil? == true
        rel = Graph.new(:re => user1, :rid => 1)
      end
      rel.save
      rel.nodes << Node.new(:re => user2)
      rel.save
      
      rel = Graph.where(:re_type => user2.class.to_s, :re_id => user2.id, :rid => 2).first
      if rel.nil? == true
        rel = Graph.new(:re => user2, :rid => 2)
      end
      rel.save
      rel.nodes << Node.new(:re => user1)
      rel.save
      
    end
    
  end
  
  desc 'crea relaciones entre usuarios'
  task :followers => :environment do
    
    a = Time.now
    
    usercount = User.count
    (1..40000).each do |n|
      if n % 100 == 0 
        puts "#{n} rel. #{(Time.now - a).to_f.to_s} segundos."
      end
      
      user1 = User.skip(rand(usercount)).first
      user2 = User.skip(rand(usercount)).first
      
      if user1 != user2
        GraphClient.new('Follow', user1, user2)
      end
    end
    
    puts "Total: #{(Time.now - a).to_f} segundos."
  end
  
  
  
  
end