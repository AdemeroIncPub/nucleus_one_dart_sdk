// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlanCollection _$SubscriptionPlanCollectionFromJson(Map<String, dynamic> json) =>
    SubscriptionPlanCollection()
      ..subscriptionPlans = (json['SubscriptionPlans'] as List<dynamic>?)
          ?.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>))
          .toList()
      ..currentUniqueNonReadOnlyTenantMemberCount =
          json['CurrentUniqueNonReadOnlyTenantMemberCount'] as int?
      ..currentUniqueReadOnlyTenantMemberCount =
          json['CurrentUniqueReadOnlyTenantMemberCount'] as int?
      ..salesTaxRate = (json['SalesTaxRate'] as num?)?.toDouble();

Map<String, dynamic> _$SubscriptionPlanCollectionToJson(SubscriptionPlanCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SubscriptionPlans', instance.subscriptionPlans);
  writeNotNull('CurrentUniqueNonReadOnlyTenantMemberCount',
      instance.currentUniqueNonReadOnlyTenantMemberCount);
  writeNotNull(
      'CurrentUniqueReadOnlyTenantMemberCount', instance.currentUniqueReadOnlyTenantMemberCount);
  writeNotNull('SalesTaxRate', instance.salesTaxRate);
  return val;
}

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) => SubscriptionPlan()
  ..id = json['ID'] as String?
  ..title = json['Title'] as String?
  ..currency = json['Currency'] as String?
  ..interval = json['Interval'] as String?
  ..savingsPercent = json['SavingsPercent'] as String?
  ..tieredPricing = json['TieredPricing'] as bool?
  ..amountPerUnit = json['AmountPerUnit'] as int?
  ..active = json['Active'] as bool?;

Map<String, dynamic> _$SubscriptionPlanToJson(SubscriptionPlan instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('Title', instance.title);
  writeNotNull('Currency', instance.currency);
  writeNotNull('Interval', instance.interval);
  writeNotNull('SavingsPercent', instance.savingsPercent);
  writeNotNull('TieredPricing', instance.tieredPricing);
  writeNotNull('AmountPerUnit', instance.amountPerUnit);
  writeNotNull('Active', instance.active);
  return val;
}
