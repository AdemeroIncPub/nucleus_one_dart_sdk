import '../api_model/subscription_details.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

// Originally generated by nucleus_one_utilities.
class SubscriptionDetails extends Entity with NucleusOneAppDependent {
  SubscriptionDetails._({
    NucleusOneApp? app,
    required this.paymentSubscriptionExists,
    required this.paymentSubscriptionCanceled,
    required this.paymentPlanId,
    required this.tokenId,
    required this.customerName,
    required this.billingEmail,
    required this.postalCode,
    required this.organizationName,
    required this.subscriptionRequired,
    required this.expiration,
    required this.isExpiringSoon,
    required this.freeUsers,
    required this.subtractFreeUsersFromPlan,
    required this.isExpired,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory SubscriptionDetails.fromApiModel(
    api_mod.SubscriptionDetails apiModel, {
    NucleusOneApp? app,
  }) {
    return SubscriptionDetails._(
      app: app,
      paymentSubscriptionExists: apiModel.paymentSubscriptionExists!,
      paymentSubscriptionCanceled: apiModel.paymentSubscriptionCanceled!,
      paymentPlanId: apiModel.paymentPlanId!,
      tokenId: apiModel.tokenId!,
      customerName: apiModel.customerName!,
      billingEmail: apiModel.billingEmail!,
      postalCode: apiModel.postalCode!,
      organizationName: apiModel.organizationName!,
      subscriptionRequired: apiModel.subscriptionRequired!,
      expiration: apiModel.expiration!,
      isExpiringSoon: apiModel.isExpiringSoon!,
      freeUsers: apiModel.freeUsers!,
      subtractFreeUsersFromPlan: apiModel.subtractFreeUsersFromPlan!,
      isExpired: apiModel.isExpired!,
    );
  }

  bool paymentSubscriptionExists;

  bool paymentSubscriptionCanceled;

  String paymentPlanId;

  String tokenId;

  String customerName;

  String billingEmail;

  String postalCode;

  String organizationName;

  bool subscriptionRequired;

  String expiration;

  bool isExpiringSoon;

  int freeUsers;

  bool subtractFreeUsersFromPlan;

  bool isExpired;

  @override
  api_mod.SubscriptionDetails toApiModel() {
    return api_mod.SubscriptionDetails()
      ..paymentSubscriptionExists = paymentSubscriptionExists
      ..paymentSubscriptionCanceled = paymentSubscriptionCanceled
      ..paymentPlanId = paymentPlanId
      ..tokenId = tokenId
      ..customerName = customerName
      ..billingEmail = billingEmail
      ..postalCode = postalCode
      ..organizationName = organizationName
      ..subscriptionRequired = subscriptionRequired
      ..expiration = expiration
      ..isExpiringSoon = isExpiringSoon
      ..freeUsers = freeUsers
      ..subtractFreeUsersFromPlan = subtractFreeUsersFromPlan
      ..isExpired = isExpired;
  }
}
