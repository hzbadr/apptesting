## Decisions
  * Rails v5.2.0 & Ruby v2.5.1

  * I used sqlite database.

  * It seems like sqlite is case-sensitive. So, country code must be [US, FR, JP].
  
  * JWT is used for authentication.
  
  * APIs expect an Authorization header with the user token received on login.
  
  * Public API must receive an extra header "Accept: application/vnd.panels.v1+json".
  
  * I added versioning for both Public and Private API. separating their versions in routes.
  
  * I used rack-attack gem to throttle APIs requests.
  
  * I added a throttle for Public API, 10 requests per minutes.
  
  * I added a throttle for sign in API, 5 requests per 20 minutes.
  
  * I decided to hardcode the requests count and period in rack-attack, this could be easily configured to be    per user or whatever logic needed.
  
  * As for rack-attack, I decided not to white/black list any IPs.
  
  * Some sections on "http://time.com/" are fetched using AJAX. 
    I am not sure if this is a known issue. I tried to fix it for about 2 hours, using chrome headless browser, but the performance was terrible and I had issues with getting it to work correctly. So, I decided to stick with the current implemntation. This slitely affected the Letter and Node counts.
  
  * I also decided to search only for the small "a" letter.
  
  * After running the seeds you will have 3 users, emails [foo@example.com, baz@example.com, bar@example.com] password is 1234 for all.
  
  * I added few specs. There is room for adding more tests but in order to save time I just tested the private API controllers and few classes in the lib directory.

  * There are things that didn't make sense to me, for example target group and country both has panel_provider_id, for API request #3 we get panel provider from country while it's accessible from both.

  * The relation beteen how to calculate the price and the country was not clear. So I decided to depend on the country creation order.

  * Nothing mentioned about the resonse, I returned the object as json.


## Test Using Postman

### login
  * post localhost:3000/auth/login
  * params { email: bar@example.com, password: 1234 }

### locations
  * get localhost:3000/locations/US
  * headers { Accept: application/vnd.panels.v1+json, Authorization: TOKEN_FROM_LOGIN }
  * response 
    {
      "locations": [
        {
          "id": 14,
          "name": "New York",
          "external_id": 68312,
          "secret_code": "pCBiTQ==",
          "created_at": "2018-05-23T15:17:21.805Z",
          "updated_at": "2018-05-23T15:17:21.805Z"
        }, ...
      ]
    }

### Target Group 
  * get localhost:3000/target_groups/US
  * headers { Accept: application/vnd.panels.v1+json, Authorization: TOKEN_FROM_LOGIN }
  * response 
    {
      "target_groups": [
        {
            "id": 3,
            "name": "GROUP_3",
            "external_id": 896107,
            "parent_id": null,
            "secret_code": "54FN9Q==",
            "panel_provider_id": 3,
            "created_at": "2018-05-23T15:17:22.319Z",
            "updated_at": "2018-05-23T15:17:22.319Z"
        },...
      ]
    }

### Evaluate Target
  * post localhost:3000/evaluate_target/
  * headers { Accept: application/vnd.panels.v1+json, Authorization: TOKEN_FROM_LOGIN }
  * params { locations[0][id]: 12, locations[0][panel_size]: 23, locations[1][id]: 12, locations[1][panel_size]: 23, country_code: US, target_group_id: 23}
  * response { price": 10.23 }