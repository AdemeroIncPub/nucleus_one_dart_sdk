import 'package:json_annotation/json_annotation.dart';

part 'subscription_plan.g.dart';

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class SubscriptionPlanCollection {
  SubscriptionPlanCollection();

  /// A necessary factory constructor for creating a new SubscriptionPlanCollection instance
  /// from a map. Pass the map to the generated [_$SubscriptionPlanCollectionFromJson()] constructor.
  /// The constructor is named after the source class, in this case, SubscriptionPlanCollection.
  factory SubscriptionPlanCollection.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanCollectionFromJson(json);

  @JsonKey(name: 'SubscriptionPlans')
  List<SubscriptionPlan>? subscriptionPlans;

  @JsonKey(name: 'CurrentUniqueNonReadOnlyTenantMemberCount')
  int? currentUniqueNonReadOnlyTenantMemberCount;

  @JsonKey(name: 'CurrentUniqueReadOnlyTenantMemberCount')
  int? currentUniqueReadOnlyTenantMemberCount;

  @JsonKey(name: 'SalesTaxRate')
  double? salesTaxRate;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$SubscriptionPlanCollectionToJson].
  Map<String, dynamic> toJson() => _$SubscriptionPlanCollectionToJson(this);
  // coverage:ignore-end
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class SubscriptionPlan {
  SubscriptionPlan();

  /// A necessary factory constructor for creating a new SubscriptionPlan instance
  /// from a map. Pass the map to the generated [_$SubscriptionPlanFromJson()] constructor.
  /// The constructor is named after the source class, in this case, SubscriptionPlan.
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'Title')
  String? title;

  @JsonKey(name: 'Currency')
  String? currency;

  @JsonKey(name: 'Interval')
  String? interval;

  @JsonKey(name: 'SavingsPercent')
  String? savingsPercent;

  @JsonKey(name: 'TieredPricing')
  bool? tieredPricing;

  @JsonKey(name: 'AmountPerUnit')
  int? amountPerUnit;

  @JsonKey(name: 'Active')
  bool? active;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$SubscriptionPlanToJson].
  Map<String, dynamic> toJson() => _$SubscriptionPlanToJson(this);
  // coverage:ignore-end
}
