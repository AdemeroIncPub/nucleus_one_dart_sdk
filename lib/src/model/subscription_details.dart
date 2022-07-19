import 'package:get_it/get_it.dart';

import '../api_model/subscription_details.dart' as api_mod;
import '../nucleus_one.dart';

class SubscriptionDetails with NucleusOneAppDependent {
  SubscriptionDetails._({
    NucleusOneApp? app,
    required this.paymentSubscriptionExists,
    required this.paymentPlanId,
    required this.tokenId,
    required this.customerName,
    required this.billingEmail,
    required this.postalCode,
    required this.organizationName,
    required this.expiration,
    required this.isExpiringSoon,
    required this.freeUsers,
    required this.isExpired,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory SubscriptionDetails.fromApiModel(
    api_mod.SubscriptionDetails apiModel, {
    NucleusOneApp? app,
  }) {
    return SubscriptionDetails._(
      app: app,
      paymentSubscriptionExists: apiModel.paymentSubscriptionExists!,
      paymentPlanId: apiModel.paymentPlanId!,
      tokenId: apiModel.tokenId!,
      customerName: apiModel.customerName!,
      billingEmail: apiModel.billingEmail!,
      postalCode: apiModel.postalCode!,
      organizationName: apiModel.organizationName!,
      expiration: apiModel.expiration!,
      isExpiringSoon: apiModel.isExpiringSoon!,
      freeUsers: apiModel.freeUsers!,
      isExpired: apiModel.isExpired!,
    );
  }

  bool paymentSubscriptionExists;

  String paymentPlanId;

  String tokenId;

  String customerName;

  String billingEmail;

  String postalCode;

  String organizationName;

  String expiration;

  bool isExpiringSoon;

  int freeUsers;

  bool isExpired;

  api_mod.SubscriptionDetails toApiModel() {
    return api_mod.SubscriptionDetails()
      ..paymentSubscriptionExists = paymentSubscriptionExists
      ..paymentPlanId = paymentPlanId
      ..tokenId = tokenId
      ..customerName = customerName
      ..billingEmail = billingEmail
      ..postalCode = postalCode
      ..organizationName = organizationName
      ..expiration = expiration
      ..isExpiringSoon = isExpiringSoon
      ..freeUsers = freeUsers
      ..isExpired = isExpired;
  }
}
