# Wicked

Use wicked to make your Rails controllers into step-by-step wizards.

## Why

Many times I'm left wanting a restful way to display a step by step process that may or not be associated with a resource. Wicked gives the flexibility to do what I want while hiding all the really scary stuff you shouldn't do in a controller to make this possible.

## Install

Add this to your Gemfile

```ruby

  gem 'wicked'

```

Then run `bundle install` and you're ready to start

## How

Simply inherit from Wicked::WizardController and you can specify a set of steps. Here we have a controller called Users::AfterSignupController with existing routes.

```ruby
  class Users::AfterSignupController < Wicked::WizardController

    steps :confirm_password, :confirm_profile, :find_friends
    # ...

```

The wizard is set to call steps in order in the show action, you can specify custom logic in your show using a case statement like this:

```ruby
  class Users::AfterSignupController < Wicked::WizardController
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

Note: you'll need to call `render_wizard` at the end of your action to get the correct views to show up.

By default the wizard will render a view with the same name as the step. So for our controller `Users::AfterSignupController` with a view path of `/views/users/after_signup/` if call the :confirm_password step, our wizard will render `/views/users/after_signup/confirm_password.html.erb`

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
  class Users::AfterSignupController < Wicked::WizardController

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

Note we're passing `render_wizard` our `@user` object here. If you pass an object into `render_wizard` it will show the next step if the object saves or re-render the previous view if it does not save.


To get to this update action, you simply need to submit a form that PUT's to the same url

```ruby

    <%= form_for @user, :url => wizard_path, :method => :put do |f| %>
      <%=  f.password_field :password  %>
      <%=  f.password_field :password_confirmation  %>

      <%= f.submit "Change Password" %>
    <% end %>

```

Note: we explicitly tell the form to PUT above


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


## About

Please poke around the source code, if you see easier ways to get a Rails controller do do what I want, let me know.

If you have a question file an issue or, find me on the Twitters [@schneems](http://twitter.com/schneems).

This project rocks and uses MIT-LICENSE.