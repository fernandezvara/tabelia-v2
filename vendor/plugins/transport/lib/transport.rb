class Transport
  
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
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6 
      },
      '1' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'A' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'B' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'C' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'D' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'E' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'F' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'R' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6 
      },
      'S' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'T' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      },
      'U' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      }, 
      'V' => {
        0.5 => 1,
        1.0 => 2,
        1.5 => 3,
        2.0 => 4,
        2.5 => 5,
        3.0 => 6
      }
    }
    
    costs[zone_id.to_s][weight]
  end
  
end