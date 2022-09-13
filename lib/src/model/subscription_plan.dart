import '../common/get_it.dart';
import '../common/model.dart';

import '../api_model/subscription_plan.dart' as api_mod;
import '../nucleus_one.dart';

class SubscriptionPlanCollection
    extends EntityCollection<SubscriptionPlan, api_mod.SubscriptionPlanCollection> {
  SubscriptionPlanCollection({
    NucleusOneApp? app,
    List<SubscriptionPlan>? items,
    required this.currentUniqueNonReadOnlyTenantMemberCount,
    required this.currentUniqueReadOnlyTenantMemberCount,
    required this.salesTaxRate,
  }) : super(app: app, items: items);

  factory SubscriptionPlanCollection.fromApiModel(
    api_mod.SubscriptionPlanCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return SubscriptionPlanCollection(
      items: apiModel.subscriptionPlans?.map((x) => SubscriptionPlan.fromApiModel(x)).toList(),
      currentUniqueNonReadOnlyTenantMemberCount:
          apiModel.currentUniqueNonReadOnlyTenantMemberCount!,
      currentUniqueReadOnlyTenantMemberCount: apiModel.currentUniqueReadOnlyTenantMemberCount!,
      salesTaxRate: apiModel.salesTaxRate!,
    );
  }

  int currentUniqueNonReadOnlyTenantMemberCount;

  int currentUniqueReadOnlyTenantMemberCount;

  double salesTaxRate;

  @override
  api_mod.SubscriptionPlanCollection toApiModel() {
    return api_mod.SubscriptionPlanCollection()
      ..subscriptionPlans = items.map((x) => x.toApiModel()).toList()
      ..currentUniqueNonReadOnlyTenantMemberCount = currentUniqueNonReadOnlyTenantMemberCount
      ..currentUniqueReadOnlyTenantMemberCount = currentUniqueReadOnlyTenantMemberCount
      ..salesTaxRate = salesTaxRate;
  }
}

class SubscriptionPlan with NucleusOneAppDependent {
  SubscriptionPlan._({
    NucleusOneApp? app,
    required this.id,
    required this.title,
    required this.currency,
    required this.interval,
    required this.savingsPercent,
    required this.tieredPricing,
    required this.amountPerUnit,
    required this.active,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory SubscriptionPlan.fromApiModel(
    api_mod.SubscriptionPlan apiModel, {
    NucleusOneApp? app,
  }) {
    return SubscriptionPlan._(
      app: app,
      id: apiModel.id!,
      title: apiModel.title!,
      currency: apiModel.currency!,
      interval: apiModel.interval!,
      savingsPercent: apiModel.savingsPercent!,
      tieredPricing: apiModel.tieredPricing!,
      amountPerUnit: apiModel.amountPerUnit!,
      active: apiModel.active!,
    );
  }

  String id;

  String title;

  String currency;

  String interval;

  String savingsPercent;

  bool tieredPricing;

  int amountPerUnit;

  bool active;

  api_mod.SubscriptionPlan toApiModel() {
    return api_mod.SubscriptionPlan()
      ..id = id
      ..title = title
      ..currency = currency
      ..interval = interval
      ..savingsPercent = savingsPercent
      ..tieredPricing = tieredPricing
      ..amountPerUnit = amountPerUnit
      ..active = active;
  }
}
