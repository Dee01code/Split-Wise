class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, uniqueness: true
    has_and_belongs_to_many :expenses 
end
