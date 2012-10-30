module Wicked
  module Wizard
    module Translated
      extend ActiveSupport::Concern

      included do
        include Wicked::Wizard
        skip_before_filter :setup_wizard

        before_filter :setup_wizard_translated
      end

      # creates a hash where keys are translated steps, values are the name of the view file
      # {:first=>"first", :second=>"second"}
      # {:uno=>"first", :dos=>"second"}
      #
      def wizard_translations
        @wizard_translations ||= steps.inject({}) do |hash, step|
          step        = step.to_s.split(".").last
          translation = I18n.t("wicked.#{step}").to_sym
          hash[translation] = step
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
        self.steps     = wizard_translations.keys

        redirect_to wizard_path(steps.first) if params[:id].try(:to_sym) == :wizard_first
        redirect_to wizard_path(steps.last)  if params[:id].try(:to_sym) == :wizard_last
        original_step = params[:id] = params[:id].to_sym


        @previous_step = previous_step(original_step)
        @next_step     = next_step(original_step)
        @step          = wizard_translations[params[:id]]
      end
      public
    end
  end
end