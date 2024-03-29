#encoding: UTF-8
class Transport
  
  def self.calculate_size(country_id, height, width, framed)
    const_altura = 5.0 # altura del objeto enmarcado
    const_diametro_rollo = 6.0
    # peso volumetrico
    if framed == true
      puts "framed!!!!"
      volumetrico = (height.to_f * width.to_f * const_altura) / 5000.0
    else
      if height < width or height == width
        # añadimos un margen interno
        puts "h"
        volumetrico = ((height.to_f + 6.0) * const_diametro_rollo * const_diametro_rollo) / 5000.0
      else
        puts "w"
        w = width.to_f + 6.0
        volumetrico = (w * const_diametro_rollo * const_diametro_rollo) / 5000.0
      end
    end
    # peso normal
    peso_metro_liston = 0.360 # kilos
    peso_embalaje_rollo = 0.450 # kilos Tubo + emboltorio interior por metro lineal de tubo
    peso_embalaje_montado = 0.200 # kilos por metro cuadrado
    peso_material_cm2 = 0.000032 # Peso del material por cm2 el papel es de 320g +- m2 en kilos!, son 0,32 g/cm2
    if framed == true
      peso = ((((height + width) * 2 ) / 100).ceil * peso_metro_liston) + (((height / 100) * (width / 100)) * peso_embalaje_montado)
    else
      if height < width or height == width
        peso_tubo = ((height + 10) / 100) * peso_embalaje_rollo
      else
        peso_tubo = ((width + 10) / 100) * peso_embalaje_rollo
      end
      peso = ((height * width) * peso_material_cm2) + peso_tubo
    end
    
    coste_volumetrico = self.calculate(country_id, volumetrico)
    puts "volumetrico = #{volumetrico}"
    puts "coste volumetrico = #{coste_volumetrico}"
    puts "peso = #{peso}"
    coste_peso = self.calculate(country_id, peso)
    puts "coste peso = #{coste_peso}"
    
    if coste_volumetrico > coste_peso
      return coste_volumetrico
    else
      return coste_peso
    end
  end
  
  def self.calculate_weight(country_id, height, width, framed)
    const_altura = 5.0 # altura del objeto enmarcado
    const_diametro_rollo = 6.0
    # peso volumetrico
    if framed == true
      puts "framed!!!!"
      volumetrico = (height.to_f * width.to_f * const_altura) / 5000.0
    else
      if height < width or height == width
        # añadimos un margen interno
        puts "h"
        volumetrico = ((height.to_f + 6.0) * const_diametro_rollo * const_diametro_rollo) / 5000.0
      else
        puts "w"
        w = width.to_f + 6.0
        volumetrico = (w * const_diametro_rollo * const_diametro_rollo) / 5000.0
      end
    end
    # peso normal
    peso_metro_liston = 0.360 # kilos
    peso_embalaje_rollo = 0.450 # kilos Tubo + emboltorio interior por metro lineal de tubo
    peso_embalaje_montado = 0.200 # kilos por metro cuadrado
    peso_material_cm2 = 0.000032 # Peso del material por cm2 el papel es de 320g +- m2 en kilos!, son 0,32 g/cm2
    if framed == true
      peso = ((((height + width) * 2 ) / 100).ceil * peso_metro_liston) + (((height / 100) * (width / 100)) * peso_embalaje_montado)
    else
      if height < width or height == width
        peso_tubo = ((height + 10) / 100) * peso_embalaje_rollo
      else
        peso_tubo = ((width + 10) / 100) * peso_embalaje_rollo
      end
      peso = ((height * width) * peso_material_cm2) + peso_tubo
    end
    
    puts "volumetrico = #{volumetrico}"
    puts "peso = #{peso}"
    
    if volumetrico > peso
      r =  volumetrico
    else
      r = peso
    end
    r
  end
  
  def self.calculate(country_id, weight)
    next_weight = ((((weight * 100).round / 50) + 1) * 50) / 100.0
    puts next_weight
    zone = get_zone(country_id)
    puts zone
    cost = get_cost(next_weight, zone)
    cost
  end
  
  def self.get_zone(country_id)
    zones = {
      '0' => ['ES'],
      '1' => ['EA', 'IC'],
      'A' => ['CA', 'US'],
      'B' => ['AU', 'HK', 'ID', 'JP', 'KH', 'KR', 'LA', 'MO', 'MX', 'MY', 'NZ', 'PH', 'SG', 'TH', 'TL', 'TW', 'VN'],
      'C' => ['AE', 'BD', 'BH', 'BN', 'BT', 'DZ', 'EG', 'IL', 'IN', 'JO', 'KW', 'LB', 'LK', 'LY', 'MA', 'NP', 'OM', 'PK', 'QA', 'SA', 'SY', 'TN',
        'YE'],
      'D' => ['AG', 'AI', 'AN', 'AR', 'AW', 'BB', 'BL', 'BM', 'BO', 'BR', 'BS', 'BZ', 'CL', 'CO', 'CR', 'DM', 'DO', 'EC', 'GD', 'GF', 'GP', 'GT',
        'HN', 'HT', 'JM', 'KN', 'KY', 'LC', 'MF', 'MQ', 'MS', 'NI', 'PA', 'PE', 'PR', 'PY', 'SR', 'SV', 'TC', 'TT', 'UY', 'VE', 'VG', 'VI', 'ZA',
        'VC'],
      'E' => ['AF', 'AM', 'AO', 'AS', 'AZ', 'BF', 'BI', 'BJ', 'BW', 'ML', 'CD', 'CI', 'CK', 'CM', 'CV', 'DJ', 'ER', 'ET', 'FJ', 'FM', 'GA', 'GE', 
        'GH', 'GM', 'GN', 'GU', 'IQ', 'KE', 'KZ', 'LR', 'LS', 'NE', 'MG', 'MH', 'MN', 'MR', 'MU', 'MV', 'MW', 'MZ', 'NA', 'NC', 'NG', 'PF', 'PG',
        'PW', 'RW', 'SC', 'SN', 'SZ', 'TE', 'TG', 'TO', 'TZ', 'UG', 'VO', 'WF', 'ZM', 'ZW', 'UZ', 'RE'],
      'F' => ['CN'],
      'R' => ['AD', 'BE', 'FR', 'GB', 'LU', 'MC', 'NL', 'PT'],
      'S' => ['DE', 'AT', 'DK', 'FI', 'GR', 'IE', 'IT', 'SE', 'GL', 'VA'],
      'T' => ['BG', 'CY', 'CZ', 'EE', 'HU', 'LT', 'LV', 'MT', 'PL', 'RO', 'SI', 'SK'],
      'U' => ['CH', 'GI', 'IS', 'LI', 'NO'],
      'V' => ['AL', 'BA', 'BY', 'HV', 'MD', 'MK', 'RS', 'ME', 'RU', 'TR', 'UA']
       }
    # Pendientes: Isla de la Ascension, Antartida (no llegamos), Islas Alan, Isla bouvet, Islas Cocos, Isla Kliperton, Cuba(no se envia)
    # Islas Christmas, Diego Garcia, Sahara Occidental, Islas Malvinas, Islas Feroe, Guernsey,  Guinea Ecuatorial, Sandwith,
    # Guinea Bissau, guyana, Islas Hear y MacDonald, Isla de Man, Terrotorio Britanico del Oceano Indico, Iran, Jersey, KI (kiribati)
    # coromas (KN), Korea del norte(KP), Myanmar(MM), Isla Norfolk, Nauru, Isla Niue, San Pedro y Mequelon, Islas Pytcairn, Terrirotios palestino
    # Territorios alejados de oceania,  islas salomon, sudan, santa elena, svalbard y janmayen (sj), sierra leona, san marino
    # somalia, santo tome y principe, tristan da cunha, territorios australes franceses, tayikistan, tokelau, turkmenistan, tuvalu,
    # islas alejadas de los estados unidos, uzbekistan, san vicente y las granadinas, mayotte
    
    # Comprobar :Kirguistan(KG) -> Fedex Kirgicistan
    to_return = false
    
    zones.keys.each do |key|
      if zones[key].include?(country_id)
        to_return = key
      end
    end

    return to_return
  end
  
  def self.get_cost(weight, zone_id)
    
    costs = {
      '0' => {
        0.5 => 8,
        1.0 => 8,
        1.5 => 8,
        2.0 => 8,
        2.5 => 8,
        3.0 => 8,
        3.5 => 8,
        4.0 => 8,
        4.5 => 8,
        5.0 => 8,
        5.5 => 8,
        6.0 => 8,
        6.5 => 8,
        7.0 => 8,
        7.5 => 8,
        8.0 => 8,
        8.5 => 8,
        9.0 => 8,
        9.5 => 8,
        10.0 => 8,
        10.5 => 8,
        11.0 => 8,
        11.5 => 8,
        12.0 => 8,
        12.5 => 8,
        13.0 => 8,
        13.5 => 8,
        14.0 => 8,
        14.5 => 8,
        15.0 => 8,
        15.5 => 8,
        16.0 => 8,
        16.5 => 8,
        17.0 => 8,
        17.5 => 8,
        18.0 => 8,
        18.5 => 8,
        19.0 => 8,
        19.5 => 8,
        20.0 => 8
      },
      '1' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'A' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'B' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'C' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'D' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'E' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'F' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6,
        3.5 => 1,
        4.0 => 2,
        4.5 => 3,
        5.0 => 4,
        5.5 => 5,
        6.0 => 6,
        6.5 => 1,
        7.0 => 2,
        7.5 => 3,
        8.0 => 4,
        8.5 => 5,
        9.0 => 6,
        9.5 => 1,
        10.0 => 2,
        10.5 => 3,
        11.0 => 4,
        11.5 => 5,
        12.0 => 6,
        12.5 => 1,
        13.0 => 2,
        13.5 => 3,
        14.0 => 4,
        14.5 => 5,
        15.0 => 6,
        15.5 => 1,
        16.0 => 2,
        16.5 => 3,
        17.0 => 4,
        17.5 => 5,
        18.0 => 6,
        18.5 => 1,
        19.0 => 2,
        19.5 => 3,
        20.0 => 4
      },
      'R' => {
        0.5 => 29,
        1.0 => 32.6,
        1.5 => 36.2,
        2.0 => 38.8,
        2.5 => 43.4,
        3.0 => 45.6,
        3.5 => 47.8,
        4.0 => 50,
        4.5 => 52.2,
        5.0 => 54.4,
        5.5 => 55.5,
        6.0 => 56.6,
        6.5 => 57.7,
        7.0 => 58.8,
        7.5 => 59.9,
        8.0 => 61,
        8.5 => 62.1,
        9.0 => 63.2,
        9.5 => 64.3,
        10.0 => 65.4,
        10.5 => 66.2,
        11.0 => 67,
        11.5 => 67.8,
        12.0 => 68.6,
        12.5 => 69.4,
        13.0 => 70.2,
        13.5 => 71,
        14.0 => 71.8,
        14.5 => 72.6,
        15.0 => 73.4,
        15.5 => 74.2,
        16.0 => 75,
        16.5 => 75.8,
        17.0 => 76.6,
        17.5 => 77.4,
        18.0 => 78.2,
        18.5 => 79,
        19.0 => 79.8,
        19.5 => 80.6,
        20.0 => 81.4
      },
      'S' => {
        0.5 => 29,
        1.0 => 32.6,
        1.5 => 36.2,
        2.0 => 38.8,
        2.5 => 43.4,
        3.0 => 45.6,
        3.5 => 47.8,
        4.0 => 50,
        4.5 => 52.2,
        5.0 => 54.4,
        5.5 => 55.5,
        6.0 => 56.6,
        6.5 => 57.7,
        7.0 => 58.8,
        7.5 => 59.9,
        8.0 => 61,
        8.5 => 62.1,
        9.0 => 63.2,
        9.5 => 64.3,
        10.0 => 65.4,
        10.5 => 66.2,
        11.0 => 67,
        11.5 => 67.8,
        12.0 => 68.6,
        12.5 => 69.4,
        13.0 => 70.2,
        13.5 => 71,
        14.0 => 71.8,
        14.5 => 72.6,
        15.0 => 73.4,
        15.5 => 74.2,
        16.0 => 75,
        16.5 => 75.8,
        17.0 => 76.6,
        17.5 => 77.4,
        18.0 => 78.2,
        18.5 => 79,
        19.0 => 79.8,
        19.5 => 80.6,
        20.0 => 81.4
      },
      'T' => {
        0.5 => 34.8,
        1.0 => 39.1,
        1.5 => 43.4,
        2.0 => 47.7,
        2.5 => 52,
        3.0 => 55.5,
        3.5 => 59,
        4.0 => 62.5,
        4.5 => 66,
        5.0 => 69.5,
        5.5 => 71.4,
        6.0 => 73.3,
        6.5 => 75.2,
        7.0 => 77.1,
        7.5 => 79,
        8.0 => 80.9,
        8.5 => 82.8,
        9.0 => 84.7,
        9.5 => 86.6,
        10.0 => 88.5,
        10.5 => 89.8,
        11.0 => 91.1,
        11.5 => 92.4,
        12.0 => 93.7,
        12.5 => 95,
        13.0 => 96.3,
        13.5 => 97.6,
        14.0 => 98.9,
        14.5 => 100.2,
        15.0 => 101.5,
        15.5 => 102.8,
        16.0 => 104.1,
        16.5 => 105.3,
        17.0 => 106.7,
        17.5 => 108,
        18.0 => 109.3,
        18.5 => 110.6,
        19.0 => 111.9,
        19.5 => 113.2,
        20.0 => 114.5
      },
      'U' => {
        0.5 => 43.3,
        1.0 => 48.7,
        1.5 => 54.1,
        2.0 => 59.5,
        2.5 => 64.9,
        3.0 => 68.1,
        3.5 => 71.3,
        4.0 => 74.5,
        4.5 => 77.7,
        5.0 => 80.9,
        5.5 => 82.5,
        6.0 => 84.1,
        6.5 => 85.7,
        7.0 => 87.3,
        7.5 => 88.9,
        8.0 => 90.5,
        8.5 => 92.1,
        9.0 => 93.7,
        9.5 => 95.3,
        10.0 => 96.9,
        10.5 => 98.1,
        11.0 => 99.3,
        11.5 => 100.5,
        12.0 => 101.7,
        12.5 => 102.9,
        13.0 => 104.1,
        13.5 => 105.3,
        14.0 => 106.5,
        14.5 => 107.7,
        15.0 => 108.9,
        15.5 => 110.1,
        16.0 => 111.3,
        16.5 => 112.5,
        17.0 => 113.7,
        17.5 => 114.9,
        18.0 => 116.1,
        18.5 => 117.3,
        19.0 => 118.5,
        19.5 => 119.7,
        20.0 => 120.9
      }, 
      'V' => {
        0.5 => 77.4,
        1.0 => 87,
        1.5 => 96.6,
        2.0 => 106.2,
        2.5 => 115.8,
        3.0 => 123.5,
        3.5 => 131.2,
        4.0 => 138.9,
        4.5 => 146.6,
        5.0 => 154.3,
        5.5 => 158.6,
        6.0 => 162.9,
        6.5 => 167.2,
        7.0 => 171.5,
        7.5 => 175.8,
        8.0 => 180.1,
        8.5 => 184.4,
        9.0 => 188.7,
        9.5 => 193,
        10.0 => 197.3,
        10.5 => 200,
        11.0 => 202.7,
        11.5 => 205.4,
        12.0 => 208.1,
        12.5 => 210.8,
        13.0 => 213.5,
        13.5 => 216.2,
        14.0 => 218.9,
        14.5 => 221.6,
        15.0 => 224.3,
        15.5 => 227,
        16.0 => 229.7,
        16.5 => 232.4,
        17.0 => 235.1,
        17.5 => 237.8,
        18.0 => 240.5,
        18.5 => 243.2,
        19.0 => 245.9,
        19.5 => 248.6,
        20.0 => 251.3
      }
    }
    
    if zone_id.to_s == "0"
      total = costs[zone_id.to_s][weight]
    else
      recargo_combustible = 1.17  # cambiar!!!
      total = costs[zone_id.to_s][weight] * recargo_combustible
    end
    total
  end
  
end