class Taxes
  
  def self.calculate(country_id, is_company, amount)
    
    tax_basic = 0.18
    
    eu_countries = ['ES', 'DE', 'AT', 'BE', 'BG', 'CY', 'DK', 'EE', 'SK', 'SI', 'FI', 'FR', 'GR', 'HU', 'IE', 'IT',
      'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'GB', 'CZ']
    
    if eu_countries.include?(country_id) == true
      # Si es miembro de la CCEE se debe cobrar IVA a particulares, no a empresas
      if is_company == true
        tax = 0
      else
        tax = (amount * tax_basic).round(2)
      end
      # Unico caso en el que siempre hay que cobrar IVA si es España, siempre hay que cobrar IVA, sea particular
      #   o empresa
      if country_id == 'ES'
        tax = (amount * tax_basic).round(2)
      end
    else
      tax = 0
    end
    
    tax
  end
  
end