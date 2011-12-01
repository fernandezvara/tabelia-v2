#encoding: utf-8

# lanzar desde consola!


I18n.with_locale(:en) do 
Category.create!(:name => 'Realism', :url => 'http://en.wikipedia.org/wiki/Realism_(arts)', :slug=> 'realism')
Category.create!(:name => 'Impresionism', :url => 'http://en.wikipedia.org/wiki/Impressionism', :slug=> 'impresionism')
Category.create!(:name => 'Pointillism', :url => 'http://en.wikipedia.org/wiki/Pointillism', :slug=> 'pointillism')
Category.create!(:name => 'Post-Impresionism', :url => 'http://en.wikipedia.org/wiki/Post-Impressionism', :slug=> 'post-impresionism')
Category.create!(:name => 'Symbolism', :url => 'http://en.wikipedia.org/wiki/Symbolism_(arts)', :slug=> 'symbolism')
Category.create!(:name => 'Modernism', :url => 'http://en.wikipedia.org/wiki/Modernism', :slug=> 'modernism')
Category.create!(:name => 'Naïve Art', :url => 'http://en.wikipedia.org/wiki/Na%C3%AFve_art', :slug=> 'naive')
Category.create!(:name => 'Fauvism', :url => 'http://en.wikipedia.org/wiki/Fauvism', :slug=> 'fauvism')
Category.create!(:name => 'Expressionism', :url => 'http://en.wikipedia.org/wiki/Expressionism', :slug=> 'expressionism')
Category.create!(:name => 'New Objectivity', :url => 'http://en.wikipedia.org/wiki/New_Objectivity', :slug=> 'new-objectivity')
Category.create!(:name => 'Cubism', :url => 'http://en.wikipedia.org/wiki/Cubism', :slug=> 'cubism')
Category.create!(:name => 'Futurism', :url => 'http://en.wikipedia.org/wiki/Futurism', :slug=> 'futurism')
Category.create!(:name => 'Dadaism', :url => 'http://en.wikipedia.org/wiki/Dada', :slug=> 'dadaism')
Category.create!(:name => 'Metaphysical', :url => 'http://en.wikipedia.org/wiki/Metaphysical_art', :slug=> 'metaphysical')
Category.create!(:name => 'Surrealism', :url => 'http://en.wikipedia.org/wiki/Surrealism', :slug=> 'surrealism')
Category.create!(:name => 'Abstract', :url => 'http://en.wikipedia.org/wiki/Abstract_art', :slug=> 'abstract')
Category.create!(:name => 'Neoplasticism', :url => 'http://en.wikipedia.org/wiki/Neoplasticism', :slug=> 'neoplasticism')
Category.create!(:name => 'Constructivism', :url => 'http://en.wikipedia.org/wiki/Constructivism_(art)', :slug=> 'constructivism')
Category.create!(:name => 'Abstract Expressionism', :url => 'http://en.wikipedia.org/wiki/Abstract_expressionism', :slug=> 'abstract-expressionism')
Category.create!(:name => 'Op Art', :url => 'http://en.wikipedia.org/wiki/Op_art', :slug=> 'op-art')
Category.create!(:name => 'Pop Art', :url => 'http://en.wikipedia.org/wiki/Pop_art', :slug=> 'pop-art')
Category.create!(:name => 'Minimalism', :url => 'http://en.wikipedia.org/wiki/Minimalism', :slug=> 'minimalism')
Category.create!(:name => 'Hyperrealism', :url => 'http://en.wikipedia.org/wiki/Hyperrealism_(visual_arts)', :slug=> 'hyperrealism')
Category.create!(:name => 'Digital Art', :url => 'http://en.wikipedia.org/wiki/Digital_art', :slug=> 'digital-art')
Category.create!(:name => 'Psychedelic Art', :url => 'http://en.wikipedia.org/wiki/Psychedelic_art' , :slug=> 'psychedelic-art')
Category.create!(:name => 'Manga / Anime', :url => 'http://en.wikipedia.org/wiki/Manga', :slug=> 'manga-anime')

end

I18n.with_locale(:es) do 

c = Category.where(:slug=> 'realism').first
c.name = 'Realismo'
c.url = 'http://es.wikipedia.org/wiki/Pintura_del_realismo'
c.save
c = Category.where(:slug=> 'impresionism').first
c.name = 'Impresionismo'
c.url = 'http://es.wikipedia.org/wiki/Impresionismo'
c.save
c = Category.where(:slug=> 'pointillism').first
c.name = 'Puntillismo'
c.url = 'http://es.wikipedia.org/wiki/Posimpresionismo'
c.save
c = Category.where(:slug=> 'post-impresionism').first
c.name = 'Post-Impresionismo'
c.url = 'http://es.wikipedia.org/wiki/Posimpresionismo'
c.save
c = Category.where(:slug=> 'symbolism').first
c.name = 'Simbolismo'
c.url = 'http://es.wikipedia.org/wiki/Simbolismo'
c.save
c = Category.where(:slug=> 'modernism').first
c.name = 'Modernismo'
c.url = 'http://es.wikipedia.org/wiki/Modernismo'
c.save
c = Category.where(:slug=> 'naive').first
c.name = 'Arte Naïf'
c.url = 'http://es.wikipedia.org/wiki/Na%C3%AFf'
c.save
c = Category.where(:slug=> 'fauvism').first
c.name = 'Fauvismo'
c.url = 'http://es.wikipedia.org/wiki/Fovismo'
c.save
c = Category.where(:slug=> 'expressionism').first
c.name = 'Expresionismo'
c.url = 'http://es.wikipedia.org/wiki/Expresionismo'
c.save
c = Category.where(:slug=> 'new-objectivity').first
c.name = 'Nueva Objetividad'
c.url = 'http://es.wikipedia.org/wiki/Nueva_objetividad'
c.save
c = Category.where(:slug=> 'cubism').first
c.name = 'Cubismo'
c.url = 'http://es.wikipedia.org/wiki/Cubismo'
c.save
c = Category.where(:slug=> 'futurism').first
c.name = 'Futurismo'
c.url = 'http://es.wikipedia.org/wiki/Futurismo'
c.save
c = Category.where(:slug=> 'dadaism').first
c.name = 'Dadaísmo'
c.url = 'http://es.wikipedia.org/wiki/Dada%C3%ADsmo'
c.save
c = Category.where(:slug=> 'metaphysical').first
c.name = 'Metafísica'
c.url = 'http://es.wikipedia.org/wiki/Pintura_metaf%C3%ADsica'
c.save
c = Category.where(:slug=> 'surrealism').first
c.name = 'Surrealismo'
c.url = 'http://es.wikipedia.org/wiki/Surrealismo'
c.save
c = Category.where(:slug=> 'abstract').first
c.name = 'Abstracto'
c.url = 'http://es.wikipedia.org/wiki/Arte_abstracto' 
c.save
c = Category.where(:slug=> 'neoplasticism').first
c.name = 'Neoplasticismo'
c.url = 'http://es.wikipedia.org/wiki/Neoplasticismo'
c.save
c = Category.where(:slug=> 'constructivism').first
c.name = 'Constructivismo'
c.url = 'http://es.wikipedia.org/wiki/Constructivismo_(arte)'
c.save
c = Category.where(:slug=> 'abstract-expressionism').first
c.name = 'Expresionismo Abstracto'
c.url = 'http://es.wikipedia.org/wiki/Expresionismo_abstracto'
c.save
c = Category.where(:slug=> 'op-art').first
c.name = 'Op Art'
c.url = 'http://en.wikipedia.org/wiki/Op_art'
c.save
c = Category.where(:slug=> 'pop-art').first
c.name = 'Pop Art'
c.url = 'http://en.wikipedia.org/wiki/Pop_art'
c.save
c = Category.where(:slug=> 'minimalism').first
c.name = 'Minimalismo'
c.url = 'http://es.wikipedia.org/wiki/Minimalismo_(pintura)'
c.save
c = Category.where(:slug=> 'hyperrealism').first
c.name = 'Hiperrealismo'
c.url ='http://es.wikipedia.org/wiki/Hiperrealismo'
c.save
c = Category.where(:slug=> 'digital-art').first
c.name = 'Arte Digital'
c.url = 'http://es.wikipedia.org/wiki/Arte_digital'
c.save
c = Category.where(:slug=> 'psychedelic-art').first
c.name = 'Arte Psicodélico'
c.url = 'http://es.wikipedia.org/wiki/Arte_psicod%C3%A9lico'
c.save
c = Category.where(:slug=> 'manga-anime').first
c.name = 'Manga y Anime'
c.url = 'http://es.wikipedia.org/wiki/Manga'
c.save

end

I18n.with_locale(:en) do 
  Genre.create!(:name => 'Portrait', :slug => 'portrait', :url => 'http://en.wikipedia.org/wiki/Portrait_painting')
  Genre.create!(:name => 'Still Life', :slug => 'still-life', :url => 'http://en.wikipedia.org/wiki/Still_life')
  Genre.create!(:name => 'Landscape', :slug => 'landscape', :url => 'http://en.wikipedia.org/wiki/Landscape_art')
  Genre.create!(:name => 'Marine', :slug => 'marine', :url => 'http://en.wikipedia.org/wiki/Marine_art')
  Genre.create!(:name => 'Figure', :slug => 'figure', :url => 'http://en.wikipedia.org/wiki/Figure_painting')
  Genre.create!(:name => 'Allegory', :slug => 'allegory', :url => 'http://en.wikipedia.org/wiki/Allegory')
  Genre.create!(:name => 'History', :slug => 'history', :url => 'http://en.wikipedia.org/wiki/History_painting')
  Genre.create!(:name => 'Religious', :slug => 'religious', :url => 'http://commons.wikimedia.org/wiki/Category:Religious_paintings')
  Genre.create!(:name => 'Genre Works', :slug => 'genre-works', :url => 'http://en.wikipedia.org/wiki/Genre_works')
  Genre.create!(:name => 'Illustration', :slug => 'illustration', :url => 'http://en.wikipedia.org/wiki/Illustration')
  #Genre.create!(:name => '', :slug => '', :url => '')
end

I18n.with_locale(:es) do 
  g = Genre.where(:slug => 'portrait').first
  g.name = 'Retrato'
  g.url = 'http://es.wikipedia.org/wiki/Retrato'
  g.save
  g = Genre.where(:slug => 'still-life').first
  g.name = 'Naturaleza Muerta - Bodegón'
  g.url = 'http://es.wikipedia.org/wiki/Bodeg%C3%B3n'
  g.save
  g = Genre.where(:slug => 'landscape').first
  g.name = 'Paisaje'
  g.url = 'http://es.wikipedia.org/wiki/Arte_del_paisaje'
  g.save
  g = Genre.where(:slug => 'marine').first
  g.name = 'Marina'
  g.url = 'http://es.wikipedia.org/wiki/Marina_%28pintura%29'
  g.save
  g = Genre.where(:slug => 'figure').first
  g.name = 'Figuras humanas y desnudos'
  g.url = 'http://es.wikipedia.org/wiki/Desnudo_(g%C3%A9nero_art%C3%ADstico)'
  g.save
  g = Genre.where(:slug => 'allegory').first
  g.name = 'Alegoría'
  g.url = 'http://es.wikipedia.org/wiki/Alegor%C3%ADa'
  g.save
  g = Genre.where(:slug => 'history').first
  g.name = 'Histórica'
  g.url = 'http://es.wikipedia.org/wiki/Pintura_hist%C3%B3rica'
  g.save
  g = Genre.where(:slug => 'religious').first
  g.name = 'Religiosa'
  g.url = 'http://es.wikipedia.org/wiki/Pintura_religiosa'
  g.save
  g = Genre.where(:slug => 'genre-works').first
  g.name = 'Costumbrista'
  g.url = 'http://es.wikipedia.org/wiki/Pintura_de_g%C3%A9nero'
  g.save
  g = Genre.where(:slug => 'illustration').first
  g.name = 'Ilustración'
  g.url = 'http://es.wikipedia.org/wiki/Ilustraci%C3%B3n_(dise%C3%B1o_gr%C3%A1fico)'
  g.save
  
end

I18n.with_locale(:en) do 
  Subject.create!(:name => 'Portrait', :slug => 'portrait')
  Subject.create!(:name => 'Urban', :slug => 'urban')

end

I18n.with_locale(:es) do 
  g = Subject.where(:slug => 'portrait').first
  g.name = 'Retrato'
  g.save
  g = Subject.where(:slug => 'urban').first
  g.name = 'Urbano'
  g.save
end

