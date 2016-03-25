# quick-cache

#### Potential issues
- Unsuccessful API calls will still save a response to the DB. This might be undesirable. To fix this we could check for a 200 status before saving the response. However, given the instructions for our method to return what FullContact.person would return, I chose to save whatever the response was.
- Cache contents will eventually become stale