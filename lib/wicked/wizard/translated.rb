module Wicked
  module Wizard
    module Translated
      extend ActiveSupport::Concern

      included do
        include Wicked::Wizard
        skip_before_filter :setup_wizard
        before_filter      :setup_wizard_translated
      end

      # creates a hash where keys are translated steps, values are the name of the view file
      # {:first=>"first", :second=>"second"}
      # {:uno=>"first", :dos=>"second"}
      #
      def wizard_translations
        @wizard_translations ||= steps.inject({}) do |hash, step|
          step        = step.to_s.split(".").last
          translation = I18n.t("wicked.#{step}").to_sym
          hash[translation] = step.to_sym
          hash
        end
      end

      private

      # sets up a translated wizard controller
      # translations are expected under the 'wicked' namespace
      #
      #  es:
      #    hello: "hola mundo"
      #    wicked:
      #      first: "uno"
      #      second: "dos"
      #
      # translation keys can be provided to `steps` with or without the 'wicked' key:
      #
      #     steps :first, :second
      # or
      #
      #     steps "wicked.first", "wicked.second"
      #
      def setup_wizard_translated
        step_name      = setup_step_from(params[:id])
        self.steps     = wizard_translations.keys        # must come before setting previous/next steps
        @previous_step = previous_step(step_name)
        @next_step     = next_step(step_name)
        @step          = wizard_translations[step_name]  # translates step name to url
      end
      public
    end
  end
end