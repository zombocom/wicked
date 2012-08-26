## This controller uses includes

class ProductsController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step
end
