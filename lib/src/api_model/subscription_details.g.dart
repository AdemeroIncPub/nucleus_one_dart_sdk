// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDetails _$SubscriptionDetailsFromJson(Map<String, dynamic> json) =>
    SubscriptionDetails()
      ..paymentSubscriptionExists = json['PaymentSubscriptionExists'] as bool?
      ..paymentSubscriptionCanceled =
          json['PaymentSubscriptionCanceled'] as bool?
      ..paymentPlanId = json['PaymentPlanId'] as String?
      ..tokenId = json['TokenId'] as String?
      ..customerName = json['CustomerName'] as String?
      ..billingEmail = json['BillingEmail'] as String?
      ..postalCode = json['PostalCode'] as String?
      ..organizationName = json['OrganizationName'] as String?
      ..subscriptionRequired = json['SubscriptionRequired'] as bool?
      ..expiration = json['Expiration'] as String?
      ..isExpiringSoon = json['IsExpiringSoon'] as bool?
      ..freeUsers = json['FreeUsers'] as int?
      ..subtractFreeUsersFromPlan = json['SubtractFreeUsersFromPlan'] as bool?
      ..isExpired = json['IsExpired'] as bool?;

Map<String, dynamic> _$SubscriptionDetailsToJson(SubscriptionDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PaymentSubscriptionExists', instance.paymentSubscriptionExists);
  writeNotNull(
      'PaymentSubscriptionCanceled', instance.paymentSubscriptionCanceled);
  writeNotNull('PaymentPlanId', instance.paymentPlanId);
  writeNotNull('TokenId', instance.tokenId);
  writeNotNull('CustomerName', instance.customerName);
  writeNotNull('BillingEmail', instance.billingEmail);
  writeNotNull('PostalCode', instance.postalCode);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('SubscriptionRequired', instance.subscriptionRequired);
  writeNotNull('Expiration', instance.expiration);
  writeNotNull('IsExpiringSoon', instance.isExpiringSoon);
  writeNotNull('FreeUsers', instance.freeUsers);
  writeNotNull('SubtractFreeUsersFromPlan', instance.subtractFreeUsersFromPlan);
  writeNotNull('IsExpired', instance.isExpired);
  return val;
}
