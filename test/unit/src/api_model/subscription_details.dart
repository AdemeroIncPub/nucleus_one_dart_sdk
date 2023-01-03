const subscriptionDetailsJson =
    '{"PaymentSubscriptionExists":true,"PaymentSubscriptionCanceled":true,"PaymentPlanId":"A","TokenId":"B","CustomerName":"C","BillingEmail":"D","PostalCode":"E","OrganizationName":"F","SubscriptionRequired":true,"Expiration":"0001-01-01T00:00:00Z","IsExpiringSoon":false,"FreeUsers":0,"SubtractFreeUsersFromPlan":true,"IsExpired":true}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
