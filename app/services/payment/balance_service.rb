module Payment
  class BalanceService
    def initialize(user_id, amount, spending = false)
      @user_id = user_id
      @amount = amount.to_f
      @spending = spending
    end

    def update
      return unless user

      user.with_lock do
        if @spending
          user.update(balance: user.balance - amount)
        else
          user.update(balance: user.balance + amount)
        end
      end
    end

    private

    attr_reader :user_id, :amount, :spending

    def user
      @user ||= User.find @user_id
    end
  end
end
