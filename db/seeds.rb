def generate_random_code
  "1234"
end

def generate_random_id
  1234
end

PANEL_PROVIDERS = %w(Panel_1 Panel_2 Panel_3)
LOCATION_GROUPS = %w(location_group_1 location_group_2 location_group_3 location_group_4)
COUNTRIES_LOCATIONS = {
  FR: %w(Lille Nice Toulouse Bordeaux Marseille),
  JP: %w(Sapporo Tokyo Yokohama Nagoya Kyoto Nara Osaka Kobe),
  US: ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "Dalls"]
}
COUNTRIES = COUNTRIES_LOCATIONS.keys

ROOT_TARGET_GROUPS = %w(GROUP_1 GROUP_2 GROUP_3 GROUP_4)

providers = PANEL_PROVIDERS.map { |code| PanelProvider.create(code: code) }

countries = COUNTRIES.zip(providers).map do |country_code, provider|
  Country.create(country_code: country_code, panel_provider: provider)
end

location_groups = LOCATION_GROUPS.zip(countries).map do |name, country|
  country = country || countries.first
  LocationGroup.create(name: name, country: country, panel_provider_id: country.panel_provider_id)
end

# Location should belong to the corresponding provider's country!
locations = COUNTRIES_LOCATIONS.map do |country_code, locations|
  location_group = Country.location_group_for(country_code)
  locations.each do |name|
    location_group.locations.create(name: name, secret_code: generate_random_code,
                                    external_id: generate_random_id)
  end
end

root_groups = ROOT_TARGET_GROUPS.zip(providers.map(&:id)).map do |name, panel_provider_id|
  panel_provider_id = panel_provider_id || providers.first.id
  target_group = TargetGroup.create(name: name, secret_code: generate_random_code,
                                    external_id: generate_random_id,
                                    panel_provider_id: panel_provider_id)
end

def create_children_for(group, count, nesting_level)
  return if nesting_level.zero?

  count.times do |i|
    new_group = TargetGroup.create(name: "#{group.name}_#{i}", secret_code: generate_random_code,
                                   external_id: generate_random_id, parent_id: group.id)
    puts new_group.errors.full_messages
    create_children_for(new_group, rand(1..5), nesting_level - 1)
  end
end

root_groups.map do |group|
  create_children_for(group, rand(1..5), 3)
end
