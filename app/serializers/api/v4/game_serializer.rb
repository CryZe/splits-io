class Api::V4::GameSerializer < Api::V4::ApplicationSerializer
  has_many :categories

  attributes :id, :name, :shortname, :srl_id, :created_at, :updated_at
end
