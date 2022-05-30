class User < ActiveRecord::Base
has_many :scores, dependent: :delete_all
end