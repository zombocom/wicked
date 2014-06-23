module Wicked::Controller::Concerns::PrimaryResource
  extend ActiveSupport::Concern

  included do
    private

    cattr_accessor :primary_resource_name
  end

  module ClassMethods
    # For use with Wicked controllers nested beneath resource routes.
    # If set, Wicked will automatically populate [resource_name]_id param value after creating a new resource.
    # NOTE: Requires ivar with the same name to be set (see set_post method in example below).
    #
    # Example usage:
    #
    # config/routes.rb:
    #
    # resources :posts
    #   resources :wizard, controller: 'post_wizard'
    # end
    #
    # controller:
    #
    # class PostWizardController < Wicked::WizardController
    #   primary_resource :post    # now, render_wizard(resource=nil, options={}) will attempt a save of the passed-in
    #                             # resource, and, unless there are validation errors, will set the [resource_name]_id
    #                             # param value to be @post.id (if not nil)
    #   steps :create_post, :do_more_stuff, :last_step
    #   before_action :set_post
    #
    #   def update
    #     case step
    #     when :create_post
    #       @post.attributes = params[:post]
    #
    #     when :do_more_stuff
    #       auxiliary_model = AuxiliaryModel.new(params[:auxiliary_model].merge(post: @post))
    #       render_wizard(auxiliary_model) and return
    #
    #     when :last_step
    #       @post.attributes = params[:post]
    #     end
    #
    #     render_wizard(@post)
    #   end
    #
    #   private
    #
    #   def set_post
    #     if step == :create_post # AND/OR check for particular params[:post_id] value such as 'new'
    #       @post = Post.new
    #     else
    #       @post = Post.find(params[:post_id])
    #     end
    #   end
    # end
    def primary_resource(resource_name)
      self.primary_resource_name = resource_name
    end
  end

  private

  def primary_resource_name
    self.class.primary_resource_name
  end

  def primary_resource
    return nil unless primary_resource_name
    instance_variable_get("@#{primary_resource_name}")
  end
end
