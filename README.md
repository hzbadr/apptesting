PanelProvider
id, code

Country is linked with LocationGroup via one to many relationship and with TargetGroup via many to many but only with the root nodes:
id, country_code, panel_provider_id

LocationGroup:
id, name, country_id, panel_provider_id

Location is linked with LocationGroup via many to many relationship:
id, name, external_id, secret_code

TargetGroup model would have associations with it self 
via parent_id which would form a tree with multiple root nodes:
id, name, external_id, parent_id, secret_code, panel_provider_id


The application should have:
3 Panel Providers
3 Countries, each with different panel provider
4 Location Groups, 3 of them with different provider and 1 would belong to any of them
20 Locations of any type (city, region, state, etc.)
4 root Target Groups and each root should start a tree which is minimium 3 levels deep (3 of them with different provider and 1 would belong to any of them)