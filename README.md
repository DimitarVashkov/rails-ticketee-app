# README
- Use RSpec and Capybara
- Use BDD and TDD.
- Use FactoryBot gem

## Using RSpec
1. Include gem
2. Run: rails g rspec:install
3. Put tests in *spec* folder and make sure they're **named \*\*\*_spec.rb**
4. Run tests: bundle exec rspec

## Goals:
* Tracks tickets  and groups them into projects
* Provides a way to restrict users to certain projects
* Allows users to upload files to tickets
* Lets users tag tickets so they’re easy to find
* Provides an API on which users can base development of their own applications


### Devise stuff
**active_for_authentication?**

After authenticating a user and in each request, Devise checks if your model is active by calling 
model.active_for_authentication?. This method is overwritten by other devise modules. For instance, :confirmable 
overwrites .active_for_authentication? to only return true if your model was confirmed.

You can overwrite this method yourself, but if you do, don't forget to call super:
```
def active_for_authentication?
  super && special_condition_is_valid?
end
```
Whenever active_for_authentication? returns false, Devise asks the reason why your model is inactive using the inactive_message method. You can overwrite it as well:

```
def inactive_message
  special_condition_is_valid? ? super : :special_condition_is_not_valid
end
```
