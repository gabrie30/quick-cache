# quick-cache

#### Potential issues
- Cache contents will eventually become stale

#### Potential Improvements
- Since external API requests are slow I wanted to use Activejob/Delayedjob to perform the FullContact API request in the background. I was able to get this working and save the response data to the database. However, I was unable to get the FullContactLookup#to_email to return that data in the console so I ended up just removing it.

#### Potential Features
- Use FullContact webhooks. A 202 response from the FullContact API means they haven't yet seen the email we submitted and will need some time to process it. If there is data for the submitted email, they can return that data to us (at a later time) using a webhook. The advantage of using the webhook is that we won't have to send another request for the same email, once they return the data to us we can immediately cache it to the db.

#### Future Considerations
- The more external API requests we use in our tests the slower they will become. Eventually we'll need to start using something like VCR which records and reuses API requests in testing.