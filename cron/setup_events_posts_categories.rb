p = Placecategory.new
p.slug = 'art_school'
p.title = 'Art School'
I18n.with_locale(:es) do
  p.title = 'Escuela de Arte'
end
p.save

p = Placecategory.new
p.slug = 'photography_school'
p.title = 'Photography School'
I18n.with_locale(:es) do
  p.title = 'Escuela de Fotografía'
end
p.save

p = Placecategory.new
p.slug = 'art_gallery'
p.title = 'Art Gallery'
I18n.with_locale(:es) do
  p.title = 'Galería de Arte'
end
p.save

p = Placecategory.new
p.slug = 'exposition'
p.title = ''
I18n.with_locale(:es) do
  p.title = ''
end
p.save

p = Placecategory.new
p.slug = ''
p.title = ''
I18n.with_locale(:es) do
  p.title = ''
end
p.save

p = Placecategory.new
p.slug = ''
p.title = ''
I18n.with_locale(:es) do
  p.title = ''
end
p.save

