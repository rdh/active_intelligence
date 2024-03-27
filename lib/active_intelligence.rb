# frozen_string_literal: true

require 'require_all'

require 'active_intelligence/engine'
require 'active_intelligence/version'

require 'active_intelligence/adapter'
require 'active_intelligence/config'

require_rel 'active_intelligence/concerns'
require_rel 'active_intelligence/asr'
require_rel 'active_intelligence/llm'

module ActiveIntelligence
  # Your code goes here...
end
