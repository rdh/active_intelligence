# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActiveIntelligence::Engine => '/active_intelligence'
end
