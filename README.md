## Decisions
  * Rails v5.2.0 & Ruby v2.5.1
  
  * I used JWT for authentication.
  
  * APIs expect an Authorization header with the user token received on login.
  
  * Public API must receive an extra header "Accept: application/vnd.panels.v1+json".
  
  * I added versioning for both Public and Private API. separating their versions in routes.
  
  * I used rack-attack gem to throttle APIs requests.
  
  * I added a throttle for Public API, 10 requests per minutes.
  
  * I added a throttle for sign in API, 5 requests per 20 minutes.
  
  * I decided hardcode the requests count and period in rack-attack, this could be easily configured to by per user or whatever logic you need.
  
  * As for rack-attack, I decided not to white/black list any IPs.
  
  * Some sections on "http://time.com/" are fetched using AJAX. 
    I am not sure if this is a known issue. I tried to fix it for about 2 hours, using chrome headless browser, but the performance was terrible and I had issues with getting it to work correctly. So, I decided to stick with the current implemntation. This slitely affected the Letter and Node counts.
  
  * I also decided to search only for the small "a" letter.
  
  * After running the seeds you will have 3 users, emails [foo@example.com, baz@example.com, bar@example.com] password is 1234 for all.
  
  * I added few specs. There is room for adding more scenarios but in order to save time I just tested the private API controllers and few classes in the lib directory.

  * There are things that didn't make sense to me, for example target group and country both has panel_provider_id, for API request #3 we get panel provider from country while it's accessible from both.

  * The relation beteen how to calculate the price and the country was not clear. So I decided to depend on the country creation order.
