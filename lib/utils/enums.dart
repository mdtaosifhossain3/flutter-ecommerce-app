enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  canceled,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}

enum PaymentMethod {
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
  cashOnDelivery,
  bankTransfer,
}
