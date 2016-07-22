class Flow < ApplicationRecord
  #belongs_to :user

  validates :payload, presence: true
  validates :flow_tag, presence: true, uniqueness: true
  validates :flow_type, presence: true

  enum flow_type: [ :simple, :stream, :binary ]
end
