module Wicked
  module Wizard
    module Translated
      extend ActiveSupport::Concern
      include Wicked::Wizard

      included do
        skip_before_filter :setup_wizard
        before_filter      :setup_wizard_translated

        helper_method      :wizard_translate, :wizard_value
      end

      # creates a hash where keys are translated steps, values are the name of the view file
      #
      #  es:
      #    hello: "hola mundo"
      #    wicked:
      #      first: "uno"
      #      second: "dos"
      #
      #   steps :first, :second
      #
      # {:uno   => :first, :dos    => :second} # spanish
      # {:first => :first, :second => :second} # english
      #
      def wizard_translations
        @wizard_translations ||= steps.inject(ActiveSupport::OrderedHash.new) do |hash, step|
          step              = step.to_s.split(".").last
          translation       = wizard_translate(step)
          hash[translation] = step.to_sym
          hash
        end
      end

      # takes a canonical wizard value and translates to correct language
      #
      # es.yml
      # wicked:
      #   first: "uno"
      #
      #   wizard_translate(:first) # => :uno
      def wizard_translate(step_name)
        I18n.t("wicked.#{step_name}", :raise => true).to_sym
      rescue I18n::MissingTranslationData
        # don't symbolize if key doesn't exist
        I18n.t("wicked.#{step_name}")
      end

      # takes an already translated value and converts to a canonical wizard value
      #
      # es.yml
      # wicked:
      #   first: "uno"
      #
      #   wizard_value(step) # => :first
      #
      def wizard_value(step_name)
        wizard_translations[step_name]
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
        self.steps = wizard_translations.keys     # must come before setting previous/next steps
        setup_wizard
      end
      public
    end
  end
end

