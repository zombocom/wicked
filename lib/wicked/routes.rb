# inspired by https://github.com/lexmag/wizardry/blob/master/lib/wizardry/routes.rb

class ActionDispatch::Routing::Mapper
  def is_wicked(opts = {})
    unless resource_scope?
      raise ArgumentError, "can't use is_wicked outside resource(s) scope"
    end

    draw = { :update => true, :edit => true }

    options = @scope[:scope_level_resource].options

    except = Array.wrap(options.delete(:except)).map(&:to_sym)
    only = Array.wrap(options.delete(:only)).map(&:to_sym)

    only_was_present = only.present?
    if only_was_present = only.present?
      only.each { |action| except.delete(action) if except.include?(action) } # discard contradicting options
      draw.each { |k,v| draw[k] = only.delete(k) == k }
    end
    draw.each { |k,v| draw[k] = v && ! except.include?(k) } if except.present?

    options.merge!(only: only) if only_was_present
    except += draw.keys
    options.merge!(except: except.uniq)

    controller = @scope[:controller].to_s.dup.concat('_controller').classify.constantize rescue nil
    controller = @scope[:controller].to_s.singularize.concat('_controller').classify.constantize unless controller.present?

    step_parameter = opts.delete(:step_parameter).try(:to_s) || 'step'
    step_action = opts.delete(:show_step_action).try(:to_s) || 'edit'
    routes_config = {}
    routes_config = Wicked::Wizard.class_variable_get :@@routes_config if Wicked::Wizard.class_variable_defined? :@@routes_config
    routes_config.merge!({ controller.name => { :step_parameter => step_parameter, :step_action => step_action }})
    Wicked::Wizard.class_variable_set :@@routes_config, routes_config

    path_name = 'edit'
    path_name = @scope[:path_names][:edit] if @scope[:path_names].key? :edit
    update_path_name = path_name
    update_path_name = @scope[:path_names][:update] if @scope[:path_names].key? :update
    step = opts.delete(:step_optional) ? "(/:#{step_parameter})" : "/:#{step_parameter}"
    step = step.sub(/\//, '') unless path_name
    edit_params = {"#{path_name}#{step}" => step_action.to_sym, as: step_action.to_sym, on: :member}
    update_params = {"#{update_path_name}#{step}" => :update, as: :update, on: :member}

    step_constraint = opts.delete(:step_constraint)
    step_constraint = Regexp.new controller.wicked_steps.join('|') if step_constraint == true
    if step_constraint
      edit_params.merge! step_parameter.to_sym => step_constraint
      update_params.merge! step_parameter.to_sym => step_constraint
    end

    get edit_params if draw[:edit]
    put update_params if draw[:update]

  end

  [:resources, :resource].each do |method|
    class_eval <<-EOT, __FILE__, __LINE__ + 1
      def wicked_#{method}(*res)              # def wicked_resources(*res)
        wicked_options = res.extract_options! #   wicked_options = res.extract_options!
        options = wicked_options.slice! :step_constraint, :step_optional, :step_parameter, :show_step_action #   options = wicked_options.slice! :step_constraint, :step_optional, :step_parameter, :show_step_action
        res.push options if options.present?  #   res.push options if options.present?
        #{method} *res do                     #   resources *res do
          is_wicked wicked_options            #     is_wicked wicked_options
          yield if block_given?               #     yield if block_given?
        end                                   #   end
      end                                     # end
    EOT
  end
end