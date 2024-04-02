class Expense < ApplicationRecord
    has_and_belongs_to_many :users
    validates :description, presence: true
    validates :amount, presence: true, numericality: true

    before_save :check_zero_amount

  private

  def check_zero_amount 
    if amount <= 0
      errors.add(:amount, "Should be greater than zero..... Using before_save Callback")
      throw :abort
    end
  end

end
