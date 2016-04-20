class ChargeSucceeded < ApplicationController

  #skip_before_filter  :verify_authenticity_token
  #skip_before_action :verify_authenticity_token
  protect_from_forgery :except => :webhook
  respond_to :json
  require 'json'

  def self.webhook
    render json:{}
    puts "Charge succeeded call function called"
    puts params
    puts params[:data][:object][:receipt_email]

    charge = Stripe::Charge.retrieve(params[:data][:object][:id].to_s)
    balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)
    #customer = Stripe::Customer.retrieve(charge.customer.to_s)
    @date = Time.at(charge.created)
    @stripe_customer = StripeCustomer.new
    @stripe_customer.GENERAL_JOURNAL = @date.strftime("%m/%d/%Y")
    @stripe_customer.Stripe_Sales = charge.amount * -0.01
    @stripe_customer.Charge_ID = charge.id
    @stripe_customer.Description = charge.description
    @stripe_customer.Email = params[:data][:object][:receipt_email]
    @stripe_customer.Stripe_Payment_Processing_Fees = balance_transaction.fee * 0.01
    @stripe_customer.Fees_for_charge_ID = charge.id
    @stripe_customer.Stripe_Account = balance_transaction.net * 0.01
    @stripe_customer.Net_for_charge_ID = charge.id
    @stripe_customer.save

  end
end