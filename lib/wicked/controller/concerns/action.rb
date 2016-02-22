module Wicked::Controller::Concerns::Action
  extend ActiveSupport::Concern

  module ClassMethods
    def self.extended(base)
      %w{before skip_before prepend_before}.each do |action|
        define_method "#{action}_action" do |*names, &blk|
          send("#{action}_filter", *names, &blk)
        end unless base.respond_to? "#{action}_action"
      end
    end
  end
end
