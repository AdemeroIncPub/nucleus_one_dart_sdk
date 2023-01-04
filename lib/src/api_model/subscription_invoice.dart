import 'package:json_annotation/json_annotation.dart';
import '../common/api_model.dart';

part 'subscription_invoice.g.dart';

// Originally generated by nucleus_one_utilities.
class SubscriptionInvoiceCollection extends EntityCollection<SubscriptionInvoice> {
  SubscriptionInvoiceCollection() : super();

  factory SubscriptionInvoiceCollection.fromJson(List<dynamic> json) {
    return EntityCollection.fromJson(
      json: json,
      instance: SubscriptionInvoiceCollection(),
      entityFromJsonCallback: (x) => SubscriptionInvoice.fromJson(x),
    );
  }
}

// Originally generated by nucleus_one_utilities.
// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class SubscriptionInvoice extends Entity {
  SubscriptionInvoice();

  /// A necessary factory constructor for creating a new SubscriptionInvoice instance
  /// from a map. Pass the map to the generated [_$SubscriptionInvoiceFromJson()] constructor.
  /// The constructor is named after the source class, in this case, SubscriptionInvoice.
  factory SubscriptionInvoice.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionInvoiceFromJson(json);

  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'CreatedOn')
  String? createdOn;

  @JsonKey(name: 'AmountDue')
  double? amountDue;

  @JsonKey(name: 'IsUpcoming')
  bool? isUpcoming;

  @JsonKey(name: 'Status')
  String? status;

  @JsonKey(name: 'PDFUrl')
  String? pdfUrl;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$SubscriptionInvoiceToJson].
  @override
  Map<String, dynamic> toJson() => _$SubscriptionInvoiceToJson(this);
  // coverage:ignore-end
}
