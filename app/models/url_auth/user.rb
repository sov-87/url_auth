module UrlAuth
  class User < ActiveRecord::Base
    has_and_belongs_to_many :groups
    has_many :urls, through: :groups
  end
end
