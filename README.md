# Test Authorisation API

## Dependencies:

* Ruby 2.2.2
* Rails 5.0.0.rc1

## To migrate the DB

    rails db:migrate

## To start a server

    rails s
    open http://api.lvh.me:3000/v1/users

## To run the test suite

    rails test

## Notes

I found this to be a fun and educational micro-project. I have not done much with authorisation since I first learned Rails (we use Devise at work and I tend to default to that), so it was interesting to learn about JWTs and implement authorisation like this. I agree with most online commentators that it is a superior alternative to session-based authentication. It was also interesting working entirely without a front-end, something I'm not used to. It forced me to trust my tests more completely.

I tried to demonstrate some best practices as I went on - TDD was used approximately 50% of the time. I find TDD more useful when I know roughly what needs to happen; when learning new tech or following online instructions I find it more efficient to write tests after I understand what is needed.

I general, I believe the requirements have been met to a good standard.

### Future improvements

There is a lot that could be improved in the application as it stands, to wit:

* Change refresh-token implementation so that tokens between 1 and 2 hours old automatically refresh - at the moment it is up to the client to try to refresh an invalid token
* Generate a separate refresh-token timeout and store it in the JWT
* DRY out AuthenticateUser/RefreshToken service objects
* Add customisable roles and activity-based authorisation
* Switch the tests over to 'spec' notation
* DRY out test usage of "headers: { authorization: @token }"
* Extend test coverage
* Build a toy front-end in React to play with
* Set up Docker and deploy to Heroku

### Assumptions

I made some assumptions:

* Only admins should be able to destroy groups, so the destroy group action authorizes for that too. Users can index and show groups.
* Secrets.yml should never be uploaded to version control - in this case it makes sense to include it so reviewers can get up and running straight away. If moving to production it would need to be added to .gitignore and then new secrets generated, since they will already have been scraped.

### Research

During the course of the project I used various online resources and tutorials:

#### General:

* http://guides.rubyonrails.org/
* http://stackoverflow.com/

#### Authentication:

* https://quickleft.com/blog/rails-tip-validating-users-with-has_secure_password/
* http://sourcey.com/building-the-prefect-rails-5-api-only-app/
* https://github.com/pluralsight/guides/blob/master/published/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api/article.md
* http://zacstewart.com/2015/05/14/using-json-web-tokens-to-authenticate-javascript-front-ends-on-rails.html

#### Authorization:

* https://www.sitepoint.com/straightforward-rails-authorization-with-pundit/
