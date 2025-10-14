class Task < ApplicationRecord
    validates :tittle, :weight, presence: true
    validate :between_one_and_five
    belongs_to :user

    private


    def between_one_and_five
        return if weight.nil?

        if weight < 1 || weight > 5
            errors.add(:weight, "The value must be between 1 and 5")
        end
    end
end
