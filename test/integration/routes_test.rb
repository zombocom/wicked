# mostly from https://github.com/lexmag/wizardry/blob/master/spec/wizardry/routes_spec.rb

require 'test_helper'

class RouteHelperTest < ActionController::TestCase

  include Rails.application.routes.url_helpers


  test 'must accept wizard `edit` routes' do
    assert_recognizes({ controller: 'products', action: 'edit', id: '1', step: 'first'}, '/products/1/edit/first')
    assert_recognizes({ controller: 'products', action: 'edit', id: '1', step: 'second'}, '/products/1/edit/second')
    assert_recognizes({ controller: 'products', action: 'edit', id: '1', step: 'last_step'}, '/products/1/edit/last_step')
    assert '/products/1/first', edit_product_path(id: 1, step: 'first')
  end

  test 'must accept only valid steps' do
    assert_raises ActionController::RoutingError do
      assert_recognizes({ controller: 'products', action: 'edit', id: '1', step: 'fictional'}, '/products/1/edit/fictional')
    end
  end

  test 'must not accept default `edit` route' do
    assert_raises ActionController::RoutingError do
      assert_recognizes({ controller: 'products', action: 'edit', id: '1'}, '/products/1/edit')
    end
  end

  test 'must not accept `destroy` route' do
    assert_raises ActionController::RoutingError do
      assert_recognizes({ controller: 'products', action: 'destroy', id: '1'}, { path: '/products/1', method: :delete })
    end
  end

  test 'must accept routes defined in block' do
    assert_recognizes({ controller: 'products', action: 'commit' }, '/products/commit')
    assert '/products/commit', commit_products_path
  end

  test 'must have overriden `new` path name' do
    assert_recognizes({ controller: 'products', action: 'new' }, '/products/make')
    assert '/products/make', new_product_path
  end

  test 'must have `wicked_resources` helper' do
    with_routing do |set|
      set.draw{ wicked_resources :products }

      assert_recognizes({ controller: 'products', action: 'edit', id: '1', step: 'initial'}, '/products/1/edit/initial')
    end
  end

  test 'must have `wicked_resource` helper' do
    with_routing do |set|
      set.draw{ wicked_resource :products }

      assert_recognizes({ controller: 'products', action: 'edit', step: 'initial'}, '/products/edit/initial')
    end
  end

  test 'must not let to use `is_wicked` outside resource(s) scope' do
    with_routing do |set|
      assert_raises ArgumentError do
        set.draw{ is_wicked }
      end
    end
  end

  test 'must not accept default `edit` route with `only` option' do
    with_routing do |set|
      set.draw{ wicked_resources :products, only: [:edit, :update] }

      assert_raises ActionController::RoutingError do
        assert_recognizes({ controller: 'products', action: 'edit', id: '1'}, '/products/1/edit')
      end
    end
  end

  test 'must have only wicked routes' do
    with_routing do |set|
      set.draw{ wicked_resource :products, only: [:edit, :update] }

      assert_recognizes({ controller: 'products', action: 'edit', step: 'first'}, '/products/edit/first')
      assert_recognizes({ controller: 'products', action: 'update', step: 'initial'}, { path: '/products/initial', method: :put })
      assert_equal 2, set.routes.count
    end
  end

  test 'must not have edit, update routes' do
    with_routing do |set|
      set.draw{ wicked_resource :products, except: [:edit, :update], }

      assert_raises ActionController::RoutingError do
        assert_recognizes({ controller: 'products', action: 'edit', step: 'first'}, '/products/edit/first')
      end
      assert_raises ActionController::RoutingError do
        assert_recognizes({ controller: 'products', action: 'edit'}, '/products/edit')
      end
      assert_raises ActionController::RoutingError do
        assert_recognizes({ controller: 'products', action: 'update', step: 'first'}, { path: '/products/first', method: :put })
      end
      assert_raises ActionController::RoutingError do
        assert_recognizes({ controller: 'products', action: 'update'}, { path: '/products', method: :put })
      end
      assert_equal 4, set.routes.count
    end
  end

  test 'must only have update route' do
    with_routing do |set|
      set.draw{ wicked_resource :products, except: [:edit, :update], only: :update }

      assert_recognizes({ controller: 'products', action: 'update', step: 'first'}, { path: '/products/first', method: :put })
      assert_equal 1, set.routes.count
    end
  end

  test 'must only have edit route' do
    with_routing do |set|
      set.draw{ wicked_resource :products, only: :edit }

      assert_recognizes({ controller: 'products', action: 'edit', step: 'first'}, '/products/edit/first')
      assert_equal 1, set.routes.count
    end
  end

  test 'must rename edit route' do
    with_routing do |set|
      set.draw{ wicked_resource :products, path_names: { edit: :amend } }

      assert_recognizes({ controller: 'products', action: 'edit', step: 'first'}, '/products/amend/first')
    end
  end

  test 'must change edit route to omit /edit' do
    with_routing do |set|
      set.draw{ wicked_resource :products, path_names: { edit: nil } }

      assert_recognizes({ controller: 'products', action: 'edit', step: 'first'}, '/products/first')
    end
  end

  test 'step must be optional' do
    with_routing do |set|
      set.draw{ wicked_resource :products, step_optional: true }
      assert_recognizes({ controller: 'products', action: 'edit', step: 'first'}, '/products/edit/first')
      assert_recognizes({ controller: 'products', action: 'edit'}, '/products/edit')
    end
  end

end