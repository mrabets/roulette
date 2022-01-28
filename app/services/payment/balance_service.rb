module Payment
  class BalanceService
    def initialize(user_id, amount, spending = false)
      @user_id = user_id
      @amount = amount
      @spending = spending
    end

    def update
      return unless user

      if @spending
        user.balance -= amount.to_f
      else
        user.balance += amount.to_f
      end

      user.save
    end

    private

    attr_reader :user_id, :amount, :spending

    def user
      @user ||= User.find @user_id
    end
  end
end
