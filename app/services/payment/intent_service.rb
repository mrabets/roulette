module Payment
  class IntentService
    def initialize(amount, payment_id)
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
        rescue Stripe::InvalidRequestError => e
          raise CustomError.new(400), e.message
        end
    end

    private

    attr_reader :user_id, :amount, :payment_id

  end
end