STRIPE_PUBLIC_KEY = "pk_0GWCGojVFCFFAeKLO8yban43qJo7t" 

Rails.configuration.stripe = {
  :publishable_key => 'pk_0GWCGojVFCFFAeKLO8yban43qJo7t',
}

Stripe.api_key = Rails.configuration.stripe[:pusblishable_key]
