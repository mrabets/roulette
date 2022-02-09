module Payment
  class IntentService
    def initialize(attributes)
      @user_id = attributes.fetch(:user_id)
      @amount = attributes.fetch(:amount)
      @payment_id = attributes.fetch(:payment_id)
    end

    def call
      ActiveRecord::Base.transaction do
        Stripe::PaymentIntent.create({
                                       amount: amount * 100,
                                       currency: 'USD',
                                       payment_method: payment_id,
                                       confirm: true
                                     })
        Payment::BalanceService.new({ user_id: user_id, amount: amount, spending: false }).update
      end
    rescue Stripe::InvalidRequestError => e
      raise CustomError.new(400), e.message
    end

    private

    attr_reader :user_id, :amount, :payment_id
  end
end
