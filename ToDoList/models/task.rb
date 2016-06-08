class Task
  include DataMapper::Resource

  property :id, Serial
  property :title, String, required: true
  property :description, String

  belongs_to :user
end