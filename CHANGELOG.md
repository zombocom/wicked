## 0.4.0
* User imputs no longer converted to symbol this mitigates risk of DoS
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
