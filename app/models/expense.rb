class Expense < ApplicationRecord
    has_and_belongs_to_many :users
    validates :amount, presence: true, numericality: true
    validates :description, uniqueness: {scope: :amount}
    validate :validate_validates

    before_save :check_zero_amount

  private

  def validate_validates
    if description == "validate"
      errors.add(:description, "Checking validate vs validates......using Custom Validation")
    end
    end

  def check_zero_amount 
    if amount <= 0
      errors.add(:amount, "Should be greater than zero..... Using before_save Callback")
      throw :abort
    end
  end

end
