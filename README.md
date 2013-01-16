![](http://cl.ly/image/3O2i1P061o3y/content.png)

# Step-By-Step Wizard Controllers

[![Build Status](https://secure.travis-ci.org/schneems/wicked.png)](http://travis-ci.org/schneems/wicked) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/schneems/wicked)

Use wicked to make your Rails controllers into step-by-step wizards. To see Wicked in action check out the example [Rails app](https://github.com/schneems/wicked_example) or [watch the screencast](http://schneems.com/post/18437886598/wizard-ify-your-rails-controllers-with-wicked).

## Why

Many times I'm left wanting a RESTful way to display a step by step process that may or not be associated with a resource. Wicked gives the flexibility to do what I want while hiding all the really nasty stuff you shouldn't do in a controller to make this possible. At it's core Wicked is a RESTful(ish) state machine, but you don't need to know that, just use it.

## Install

Add this to your Gemfile

```ruby
  gem 'wicked'
```

Then run `bundle install` and you're ready to start

## Quicklinks

* [Build an object step-by-step](https://github.com/schneems/wicked/wiki/Building-Partial-Objects-Step-by-Step)
* [Use object ID's with wizard paths](https://github.com/schneems/wicked/wiki/Building-Partial-Objects-Step-by-Step)
* [Show Current Wizard Progress to User](https://github.com/schneems/wicked/wiki/Show-Current-Wizard-Progress-to-User)
* [Example App](https://github.com/schneems/wicked_example)
* [Screencast](http://schneems.com/post/18437886598/wizard-ify-your-rails-controllers-with-wicked)
* [Watch Railscasts episode: #346 Wizard Forms with Wicked](http://railscasts.com/episodes/346-wizard-forms-with-wicked)

## How

We are going to build an 'after signup' wizard. If you don't have a `current_user` then check out how to [Build a step-by-step object with Wicked](https://github.com/schneems/wicked/wiki/Building-Partial-Objects-Step-by-Step).

First create a controller:

```
  rails g controller after_signup
```

Add Routes into `config/routes.rb`:

```ruby
  resources :after_signup
```

Next include `Wicked::Wizard` in your controller

```ruby

  class AfterSignupController < ApplicationController
    include Wicked::Wizard

    steps :confirm_password, :confirm_profile, :find_friends
    # ...

```

You can also use the old way of inheriting from `Wicked::WizardController`.

```ruby

  class AfterSignupController < Wicked::WizardController

    steps :confirm_password, :confirm_profile, :find_friends
    # ...

```

The wizard is set to call steps in order in the show action, you can specify custom logic in your show using a case statement like below. To send someone to the first step in this wizard we can direct them to `after_signup_path(:confirm_password)`.

```ruby
  class AfterSignupController < ApplicationController
    include Wicked::Wizard

    steps :confirm_password, :confirm_profile, :find_friends

    def show
      @user = current_user
      case step
      when :find_friends
        @friends = @user.find_friends
      end
      render_wizard
    end
  end
```

**Note:** Wicked uses the `:id` parameter to control the flow of steps, if you need to have an id parameter, please use nested routes see [building objects with wicked](https://github.com/schneems/wicked/wiki/Partial-Validation-of-Active-Record-Objects) for an example. It will need to be prefixed, for example a Product's `:id` would be `:product_id`

You'll need to call `render_wizard` at the end of your action to get the correct views to show up.

By default the wizard will render a view with the same name as the step. So for our controller `AfterSignupController` with a view path of `/views/after_signup/` if call the :confirm_password step, our wizard will render `/views/after_signup/confirm_password.html.erb`

Then in your view you can use the helpers to get to the next step.

```ruby
   <%= link_to 'skip', next_wizard_path %>
```

You can manually specify which wizard action you want to link to by using the wizard_path helper.

```ruby
   <%= link_to 'skip', wizard_path(:find_friends) %>
```

In addition to showing sequential views we can update elements in our controller.


```ruby
  class AfterSignupController < ApplicationController
    include Wicked::Wizard

    steps :confirm_password, :confirm_profile, :find_friends

    def update
      @user = current_user
      case step
      when :confirm_password
        @user.update_attributes(params[:user])
      end
      sign_in(@user, :bypass => true) # needed for devise
      render_wizard @user
    end
  end
```

We're passing `render_wizard` our `@user` object here. If you pass an object into `render_wizard` it will show the next step if the object saves or re-render the previous view if it does not save.


To get to this update action, you simply need to submit a form that PUT's to the same url

```ruby

    <%= form_for @user, :url => wizard_path, :method => :put do |f| %>
      <%=  f.password_field :password  %>
      <%=  f.password_field :password_confirmation  %>

      <%= f.submit "Change Password" %>
    <% end %>

```

We explicitly tell the form to PUT above. If you forget this, you will get a warning about the create action not existing, or no route found for POST. Don't forget this.


In the controller if you find that you want to skip a step, you can do it simply by calling `skip_step`

```ruby

  def show
    @user = current_user
    case step
    when :find_friends
      if @user.has_facebook_access_token?
        @friends = @user.find_friends
      else
        skip_step
      end
    end
    render_wizard
  end

```

Now you've got a fully functioning AfterSignup controller! If you have questions or if you struggled with something, let me know on [twitter](http://twitter.com/schneems), and i'll try to make it better or make the docs better.

## Quick Reference

View/URL Helpers

```ruby

  wizard_path                  # Grabs the current path in the wizard
  wizard_path(:specific_step)  # Url of the :specific_step
  next_wizard_path             # Url of the next step
  previous_wizard_path         # Url of the previous step

  # These only work while in a Wizard, and are not absolute paths
  # You can have multiple wizards in a project with multiple `wizard_path` calls
```


Controller Tidbits:

```ruby
  steps  :first, :second       # Sets the order of steps
  step                         # Gets symbol of current step
  next_step                    # Gets symbol of next step
  skip_step                    # Tells render_wizard to skip to the next logical step
  render_wizard                # Renders the current step
  render_wizard(@user)         # Shows next_step if @user.save, otherwise renders current step
```


Finally:

Don't forget to create your named views

```
  app/
   views/
    controller_name/
      first.html.erb
      second.html.erb
      # ...
```


# Finish Wizard Path

You can specify the url that your user goes to by over-riding the `finish_wizard_path` in your wizard controller.


```
  def finish_wizard_path
    user_path(current_user)
  end
```


### Testing with RSpec

```ruby
  # Test find_friends block of show action
  get :show, :id => :find_friends

  # Test find_friends block of update action
  put :update, {'id' => 'find_friends', "user" => { "id" => @user.id.to_s }}
```


### Internationalization of URLS (I18n)

If your site works in multiple languages, or if you just want more control over how your URL's look you can now use I18n with wicked. To do so you need to replace this:

    include Wicked::Wizard

With this:

    include Wicked::Wizard::Translated

This will allow you to specify translation keys instead of literal step names. Let's say you've got steps that look like this:

    steps :first, :second

So the urls would be `/after_signup/first` and `/after_signup/second`. But you want them to show up differently for different locales. For example someone coming form a Spanish speaking locale should see `/after_signup/uno` and `after_signup/dos`.

To internationalize first you need to create your locales files under `config/locales` such as `config/locales/es.yml` for Spanish. You then need to add a `first` and `second` key under a `wicked` key like this:

    es:
      hello: "hola mundo"
      wicked:
        first: "uno"
        second: "dos"

It would also be a good idea to create a english version under `config/locales/en.yml` or your english speaking friends will get errors. If your app already uses I18n you don't need to do anything else, if not you will need to make sure that you set the `I18n.locale` on each request you could do this somewhere like a before filter in your application_controller.rb


    before_filter :set_locale

    private

    def set_locale
      I18n.locale = params[:locale] if params[:locale].present?
    end

    def default_url_options(options = {})
      {locale: I18n.locale}
    end

For a screencast on setting up and using I18n check out [Railscasts](http://railscasts.com/episodes/138-i18n-revised). You can also read the [free I18n Rails Guide](http://guides.rubyonrails.org/i18n.html).

Now when you visit your controller with the proper locale set your url's should be more readable like `/after_signup/uno` and `after_signup/dos`.

Wicked expects your files to be named the same as your keys, so when a user visits `after_signup/dos` with the `es` locale it will render the `second.html.erb` file.

## Custom URL's

Very similar to using I18n from above but instead of making new files for different languages, you can stick with one language. Make sure you are using the right module:

    include Wicked::Wizard::Translated

Then you'll need to specify translations in your language file. For me, the language I'm using is english so I can add translations to `config/locales/en.yml`

    en:
      hello: "hello world"
      wicked:
        first: "verify_email"
        second: "if_you_are_popular_add_friends"

Now you can change the values in the URL's to whatever you want without changing your controller or your files, just modify your `en.yml`. If you're not using English you can set your default_locale to something other than `en` in your `config/application.rb` file.

    config.i18n.default_locale = :de

Custom crafted wizard urls: just another way Wicked makes your app a little more saintly.

## Dynamic Step Names

If you wish to set the order of your steps dynamically you can do this with a `prepend_before_filter` and `self.steps =` like this:

```
  include Wicked::Wizard
  prepend_before_filter :set_steps

  # ...

  private
  def set_steps
    if params[:flow] == "twitter"
      self.steps = [:ask_twitter, :ask_email]
    elsif params[:flow] == "facebook"
      self.steps = [:ask_facebook, :ask_email]
    end
  end
```

Note: Do not pass user submitted params directly into `self.steps` while using the custom or translated urls. The translator calls `to_sym` on steps provided, and if a user is allowed to submit arbitrary symbols, they could flood the take down your production app by filling up the symbol table. So just don't do it.

## About

Please poke around the source code, if you see easier ways to get a Rails controller do do what I want, let me know.

If you have a question file an issue or, find me on the Twitters [@schneems](http://twitter.com/schneems).

This project rocks and uses MIT-LICENSE.