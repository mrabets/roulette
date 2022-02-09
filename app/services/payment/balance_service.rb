module Payment
  class BalanceService
    def initialize(attributes)
      @user_id = attributes.fetch(:user_id)
      @amount = attributes.fetch(:amount).to_f
      @spending = attributes.fetch(:spending)
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
