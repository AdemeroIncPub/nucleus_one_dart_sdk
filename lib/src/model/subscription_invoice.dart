import 'package:get_it/get_it.dart';
import '../common/model.dart';

import '../api_model/subscription_invoice.dart' as api_mod;
import '../nucleus_one.dart';

class SubscriptionInvoiceCollection
    extends EntityCollection<SubscriptionInvoice, api_mod.SubscriptionInvoiceCollection> {
  SubscriptionInvoiceCollection({NucleusOneAppInternal? app, List<SubscriptionInvoice>? items})
      : super(app: app, items: items);

  factory SubscriptionInvoiceCollection.fromApiModel(
      api_mod.SubscriptionInvoiceCollection apiModel) {
    return SubscriptionInvoiceCollection(
      items: apiModel.items.map((x) => SubscriptionInvoice.fromApiModel(x)).toList(),
    );
  }

  @override
  api_mod.SubscriptionInvoiceCollection toApiModel() {
    return api_mod.SubscriptionInvoiceCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class SubscriptionInvoice with NucleusOneAppDependent {
  SubscriptionInvoice._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.amountDue,
      required this.isUpcoming,
      required this.status,
      required this.pdfUrl}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory SubscriptionInvoice.fromApiModel(api_mod.SubscriptionInvoice apiModel) {
    return SubscriptionInvoice._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        amountDue: apiModel.amountDue!,
        isUpcoming: apiModel.isUpcoming!,
        status: apiModel.status!,
        pdfUrl: apiModel.pdfUrl!);
  }

  String id;

  String createdOn;

  double amountDue;

  bool isUpcoming;

  String status;

  String pdfUrl;

  api_mod.SubscriptionInvoice toApiModel() {
    return api_mod.SubscriptionInvoice()
      ..id = id
      ..createdOn = createdOn
      ..amountDue = amountDue
      ..isUpcoming = isUpcoming
      ..status = status
      ..pdfUrl = pdfUrl;
  }
}
