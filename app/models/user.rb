class User < ApplicationRecord
    has_secure_password
    # validate :name, custom_method: {scope: :email}
    validates :name, presence: true, uniqueness: true
    has_and_belongs_to_many :expenses 
    # has_many :transactions
end
