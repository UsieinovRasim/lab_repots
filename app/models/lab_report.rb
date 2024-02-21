# frozen_string_literal: true

class LabReport < ApplicationRecord
  belongs_to :user

  GRADES = %w[A B C D E FX F].freeze

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :grade, inclusion: { in: GRADES }

  def self.user_options
    User.all.collect { |u| [u.first_name, u.id] }
  end
end
