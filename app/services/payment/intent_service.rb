module Payment
  class IntentService
    def self.call(amount, payment_id)
      Stripe::PaymentIntent.create({
        amount: amount,
        currency: "USD",
        description: "Your Company Description",
        payment_method: payment_id,
        confirm: true,
      });
    rescue Stripe => e
      raise CustomError.new(406), e unless user.try(:id)
    end
  end
end