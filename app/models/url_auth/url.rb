module UrlAuth
  class Url < ActiveRecord::Base
    has_and_belongs_to_many :groups
    has_many :users, through: :groups
    
    validates :url_pattern, regexp: true
    
    scope :by_user, ->(user) do
      includes(:users).where({ url_auth_users: { id: user } }).all
    end
  end
end
