const subscriptionPlanJson =
    '{"ID":"A","Title":"B","Currency":"C","Interval":"D","SavingsPercent":"E","TieredPricing":true,"AmountPerUnit":0,"Active":false}';
const subscriptionPlanCollectionJson =
    '{"SubscriptionPlans":[$subscriptionPlanJson],"CurrentUniqueNonReadOnlyTenantMemberCount":0,"CurrentUniqueReadOnlyTenantMemberCount":1,"SalesTaxRate":2.00}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
