module Payment
  class IntentService
    def initialize(user_id, amount, payment_id)
      @user_id = user_id
      @amount = amount
      @payment_id = payment_id
    end

    def call
      begin
        Stripe::PaymentIntent.create({
                                       amount: amount * 100,
                                       currency: 'USD',
                                       payment_method: payment_id,
                                       confirm: true
                                     })
      rescue Stripe => e
        raise CustomError.new(406), e unless user.try(:id)
      end

      update_user_balance
    end

    private

    attr_reader :user_id, :amount, :payment_id

    def update_user_balance
      user = User.find user_id
      user.balance += amount.to_f if user
      user.save
    end
  end
end
