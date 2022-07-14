// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionInvoice _$SubscriptionInvoiceFromJson(Map<String, dynamic> json) =>
    SubscriptionInvoice()
      ..id = json['ID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..amountDue = (json['AmountDue'] as num?)?.toDouble()
      ..isUpcoming = json['IsUpcoming'] as bool?
      ..status = json['Status'] as String?
      ..pdfUrl = json['PDFUrl'] as String?;

Map<String, dynamic> _$SubscriptionInvoiceToJson(SubscriptionInvoice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('AmountDue', instance.amountDue);
  writeNotNull('IsUpcoming', instance.isUpcoming);
  writeNotNull('Status', instance.status);
  writeNotNull('PDFUrl', instance.pdfUrl);
  return val;
}
