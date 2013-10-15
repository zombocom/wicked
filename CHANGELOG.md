## 1.0.2 (8/15/2013)

* Contains Security updates plz upgrade
* Only allow params[:id] to be used as step if in valid list
* Better redirect handling thanks @gabrielg

## 1.0.1 (8/08/2013)

* Fix security issue #94

## 1.0.0 (8/03/2013)

* Rails 4 compatible tested version released
* Remove compatibility for Ruby 1.8.7 since it is EOL

## 0.6.1 (05/05/2013)

* [#62] bugfix to translating wizard values thanks @hwo411

## 0.6.0 (03/20/2013)

* Breaking change: hardcoded internal `finish` keyword changed to
`wicked_finish`. Can be modified by setting `Wicked::FINISH_STEP`.
Please use constants from now on instead of relying on the values of the
strings.
* [#56] raise error while using reserved keyword
* Keywords are now configurable as constants `Wicked::FIRST_STEP`,
`Wicked::LAST_STEP`, and `Wicked::FINISH_STEP`

## 0.5.0 (01/27/2013)
* [#51] bug fix: while using translations all wizard helpers now return values
in the same language (in whatever locale is being used). So if a user is
requesting a controller action in spanish, then `step` will be in
spanish and all the values inside of `steps` and `next_step` etc. will
be in spanish. To convert one of these values to a "canonical" wizard
value (that matches the names of your files) you can use
`wizard_value(step)` method.

## 0.4.0
* User inputs no longer converted to symbol this mitigates risk of DoS
via symbol table or RAM (symbols are not garbage collected).

## 0.3.4
* Dynamic steps officially supported and tested

## 0.3.3
* warn users users who forgot to set steps

## 0.3.2
* Forward params passed to the index action
* bug fix: 1.8.7 hash ordering

## 0.3.1
* Prettier code, thanks code climate

## 0.3.0

* [#22] enable I18n on wicked paths with `Wicked::Wizard::Translated`
* jRuby is officially supported and tested with Travis
* [#30] bugfix, filter options now work on `steps` method (@jeremyruppel)

## 0.2.0 (07/27/2012)

* Make step configuration an instance level config instead of class.
* [#25] current_step?, past_step?, future_step?, next_step? & previous_step? step helper methods to be used in the view(thanks @ahorner)
# [#28] accept options to `render_wizard` (@nata79)

## 0.1.6 (06/02/2012)

* remove `WizardController#_reset_invocation_response`
* bug fix for when jump_to is used in conjunction with passing a resource to render_wizard (thanks @fschwahn)

## 0.1.5 (05/13/2012)

* rename `controller` to `wizard_controller` to avoid collisions with other controller based gems (thanks @lucatironi)

## 0.1.4 (4/01/2012)

* expose `steps` and `wizard_steps` to view
* default index path of wizard controller to the first step
* paths to first and last steps `/wizard_first` & `/wizard_last`

## 0.1.3 (4/01/2012)

* previous_wizard_path introduced

## 0.1.2 (3/16/2012)

* next_wizard_path takes options (thanks @Flink)


## 0.1.1 (3/16/2012)

* fixed include bug


## 0.1.0 (3/11/2012)

* Allow including `Wicked::Wizard` into controllers
* Added Tests for Helpers

## 0.0.2

* Fixed url bug

## 0.0.1

* First Release
