require 'erb'

module Wicked
  FINISH_STEP = "wicked_finish"
  FIRST_STEP  = "wicked_first"
  LAST_STEP   = "wicked_last"

  module Controller
    module Concerns
    end
  end
  module Wizard
  end
end

class WickedError < StandardError; end
class WickedProtectedStepError < WickedError; end

require 'wicked/controller/concerns/render_redirect'
require 'wicked/controller/concerns/steps'
require 'wicked/controller/concerns/path'
require 'wicked/wizard'
require 'wicked/wizard/translated'
require 'wicked/engine'

