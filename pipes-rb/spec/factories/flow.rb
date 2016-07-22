FactoryGirl.define do
  factory :flow do
    payload "test payload"
    flow_tag "test_tag"
    flow_type :simple
  end
end
