#encoding: utf-8

# lanzar desde consola!


I18n.with_locale(:en) do 
Category.create!(:name => 'Gothic', :url => 'http://en.wikipedia.org/wiki/Gothic_art', :slug=> 'gothic')
Category.create!(:name => 'Renaissance', :url => 'http://en.wikipedia.org/wiki/Renaissance', :slug=> 'renaissance')
Category.create!(:name => 'Mannerism', :url => 'http://en.wikipedia.org/wiki/Mannerism', :slug=> 'mannerism')
Category.create!(:name => 'Flemish School', :url => 'http://en.wikipedia.org/wiki/Flemish_School', :slug=> 'flemish-school')
Category.create!(:name => 'Baroque', :url => 'http://en.wikipedia.org/wiki/Baroque', :slug=> 'baroque')
Category.create!(:name => 'Neoclassicism', :url => 'http://en.wikipedia.org/wiki/Neoclassicism', :slug=> 'neoclassicism')
Category.create!(:name => 'Realism', :url => 'http://en.wikipedia.org/wiki/Realism_(arts)', :slug=> 'realism')
Category.create!(:name => 'Romanticism', :url => 'http://en.wikipedia.org/wiki/Romanticism', :slug=> 'romanticism')
Category.create!(:name => 'Impresionism', :url => 'http://en.wikipedia.org/wiki/Impressionism', :slug=> 'impresionism')
Category.create!(:name => 'Post-Impresionism', :url => 'http://en.wikipedia.org/wiki/Post-Impressionism', :slug=> 'post-impresionism')
Category.create!(:name => 'Symbolism', :url => 'http://en.wikipedia.org/wiki/Symbolism_(arts)', :slug=> 'symbolism')
Category.create!(:name => 'Art Nouveau', :url => 'http://en.wikipedia.org/wiki/Art_Nouveau', :slug=> 'art-nouveau')
Category.create!(:name => 'Abstract', :url => 'http://en.wikipedia.org/wiki/Abstract_art', :slug=> 'abstract')
Category.create!(:name => 'Naïve Art', :url => 'http://en.wikipedia.org/wiki/Na%C3%AFve_art', :slug=> 'naive')
Category.create!(:name => 'Fauvism', :url => 'http://en.wikipedia.org/wiki/Fauvism', :slug=> 'fauvism')
Category.create!(:name => 'Expressionism', :url => 'http://en.wikipedia.org/wiki/Expressionism', :slug=> 'expressionism')
Category.create!(:name => 'Surrealism', :url => 'http://en.wikipedia.org/wiki/Surrealism', :slug=> 'surrealism')
Category.create!(:name => 'Cubism', :url => 'http://en.wikipedia.org/wiki/Cubism', :slug=> 'cubism')
Category.create!(:name => 'Futurism', :url => 'http://en.wikipedia.org/wiki/Futurism', :slug=> 'futurism')
Category.create!(:name => 'Contemporary Art', :url => 'http://en.wikipedia.org/wiki/Contemporary_art', :slug=> 'contemporary-art')
Category.create!(:name => 'Manga / Anime', :url => 'http://en.wikipedia.org/wiki/Manga', :slug=> 'manga-anime')
end

I18n.with_locale(:es) do 
c = Category.where(:slug=> 'gothic').first
c.name = 'Gótico'
c.url = 'http://es.wikipedia.org/wiki/Arte_gótico'
c.save
c = Category.where(:slug=> 'renaissance').first
c.name = 'Renacimiento'
c.url = 'http://es.wikipedia.org/wiki/Renacimiento'
c.save
c = Category.where(:slug=> 'mannerism').first
c.name = 'Manierismo'
c.url = 'http://es.wikipedia.org/wiki/Manierismo'
c.save
c = Category.where(:slug=> 'flemish-school').first
c.name = 'Pintura flamenca'
c.url = 'http://es.wikipedia.org/wiki/Pintura_flamenca_(siglos_XV_y_XVI)'
c.save
c = Category.where(:slug=> 'baroque').first
c.name = 'Barroco'
c.url = 'http://es.wikipedia.org/wiki/Barroco'
c.save
c = Category.where(:slug=> 'neoclassicism').first
c.name = 'Neoclasicismo'
c.url = 'http://es.wikipedia.org/wiki/Neoclasicismo'
c.save
c = Category.where(:slug=> 'realism').first
c.name = 'Realismo'
c.url = 'http://es.wikipedia.org/wiki/Pintura_del_realismo'
c.save
c = Category.where(:slug=> 'romanticism').first
c.name = 'Romanticismo'
c.url = 'http://es.wikipedia.org/wiki/Romanticismo'
c.save
c = Category.where(:slug=> 'impresionism').first
c.name = 'Impresionismo'
c.url = 'http://es.wikipedia.org/wiki/Impresionismo'
c.save
c = Category.where(:slug=> 'post-impresionism').first
c.name = 'Post-Impresionismo'
c.url = 'http://es.wikipedia.org/wiki/Posimpresionismo'
c.save
c = Category.where(:slug=> 'art-nouveau').first
c.name = 'Modernismo'
c.url = 'http://es.wikipedia.org/wiki/Modernismo'
c.save
c = Category.where(:slug=> 'surrealism').first
c.name = 'Surrealismo'
c.url = 'http://es.wikipedia.org/wiki/Surrealismo'
c.save
c = Category.where(:slug=> 'symbolism').first
c.name = 'Simbolismo'
c.url = 'http://es.wikipedia.org/wiki/Simbolismo'
c.save


c = Category.where(:slug=> 'abstract').first
c.name = 'Abstracto'
c.url = 'http://es.wikipedia.org/wiki/Arte_abstracto' 
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
c = Category.where(:slug=> 'cubism').first
c.name = 'Cubismo'
c.url = 'http://es.wikipedia.org/wiki/Cubismo'
c.save
c = Category.where(:slug=> 'futurism').first
c.name = 'Futurismo'
c.url = 'http://es.wikipedia.org/wiki/Futurismo'
c.save
c = Category.where(:slug=> 'contemporary-art').first
c.name = 'Arte Contemporáneo'
c.url = 'http://es.wikipedia.org/wiki/Arte_contemporáneo'
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
  Genre.create!(:name => 'Religious', :slug => 'religious', :url => 'http://commons.wikimedia.org/wiki/Category:Religious_paintings')
  Genre.create!(:name => 'Illustration', :slug => 'illustration', :url => 'http://en.wikipedia.org/wiki/Illustration')
  Genre.create!(:name => 'Children', :slug => 'children', :url => '')
  Genre.create!(:name => 'Botany', :slug => 'botany', :url => '')
  Genre.create!(:name => 'Fauna', :slug => 'fauna', :url => '')
  Genre.create!(:name => 'Cinema', :slug => 'cinema', :url => '')
  Genre.create!(:name => 'Architecture', :slug => 'architecture', :url => '')
  Genre.create!(:name => 'Regional', :slug => 'regional', :url => '')
  Genre.create!(:name => 'Motor', :slug => 'motor', :url => '')
  Genre.create!(:name => 'Cartography', :slug => 'cartography', :url => '')
  
  
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
  g = Genre.where(:slug => 'religious').first
  g.name = 'Religiosa'
  g.url = 'http://es.wikipedia.org/wiki/Pintura_religiosa'
  g.save
  g = Genre.where(:slug => 'illustration').first
  g.name = 'Ilustración'
  g.url = 'http://es.wikipedia.org/wiki/Ilustraci%C3%B3n_(dise%C3%B1o_gr%C3%A1fico)'
  g.save
  g = Genre.where(:slug => 'children').first
  g.name = 'Infantil'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'botany').first
  g.name = 'Botánica'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'fauna').first
  g.name = 'Fauna'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'cinema').first
  g.name = 'Cine'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'architecture').first
  g.name = 'Arquitectura'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'regional').first
  g.name = 'Regional'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'motor').first
  g.name = 'Motor'
  g.url = ''
  g.save
  g = Genre.where(:slug => 'cartography').first
  g.name = 'Cartografía'
  g.url = ''
  g.save
end

# ACABAR CON LOS GENEROS!!!

I18n.with_locale(:en) do 
  Subject.create!(:name => 'Architecture - Urban', :slug => 'urban')
  Subject.create!(:name => 'People', :slug => 'people')
  Subject.create!(:name => 'Digital', :slug => 'digital')
  Subject.create!(:name => 'Graphic', :slug => 'graphic')
  Subject.create!(:name => 'Botany', :slug => 'botany')
  Subject.create!(:name => 'Fauna', :slug => 'fauna')
  Subject.create!(:name => 'Travel', :slug => 'travel')
  Subject.create!(:name => 'Landscape', :slug => 'landscape')
  Subject.create!(:name => 'Artistic', :slug => 'artistic')
end

I18n.with_locale(:es) do 

  g = Subject.where(:slug => 'urban').first
  g.name = 'Arquitectura - Urbano'
  g.save
  g = Subject.where(:slug => 'people').first
  g.name = 'Gente'
  g.save
  g = Subject.where(:slug => 'digital').first
  g.name = 'Digital'
  g.save
  g = Subject.where(:slug => 'graphic').first
  g.name = 'Gráfica'
  g.save
  g = Subject.where(:slug => 'botany').first
  g.name = 'Botánica'
  g.save
  g = Subject.where(:slug => 'fauna').first
  g.name = 'Fauna'
  g.save
  g = Subject.where(:slug => 'travel').first
  g.name = 'Viajes'
  g.save
  g = Subject.where(:slug => 'landscape').first
  g.name = 'Paisajes'
  g.save
  g = Subject.where(:slug => 'artistic').first
  g.name = 'Artística'
  g.save
end