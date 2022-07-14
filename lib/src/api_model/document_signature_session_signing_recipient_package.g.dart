// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_signing_recipient_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionSigningRecipientPackage
    _$DocumentSignatureSessionSigningRecipientPackageFromJson(
            Map<String, dynamic> json) =>
        DocumentSignatureSessionSigningRecipientPackage()
          ..requireAccessCode = json['RequireAccessCode'] as bool?
          ..signingRecipient = json['SigningRecipient'] == null
              ? null
              : DocumentSignatureSessionSigningRecipient.fromJson(
                  json['SigningRecipient'] as Map<String, dynamic>)
          ..formFieldPackage = json['FormFieldPackage'] == null
              ? null
              : DocumentSignatureSessionFormFieldPackage.fromJson(
                  json['FormFieldPackage'] as Map<String, dynamic>)
          ..serverDate = json['ServerDate'] as String?
          ..contentPackage = json['ContentPackage'] == null
              ? null
              : DocumentContentPackage.fromJson(
                  json['ContentPackage'] as Map<String, dynamic>);

Map<String, dynamic> _$DocumentSignatureSessionSigningRecipientPackageToJson(
    DocumentSignatureSessionSigningRecipientPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('RequireAccessCode', instance.requireAccessCode);
  writeNotNull('SigningRecipient', instance.signingRecipient);
  writeNotNull('FormFieldPackage', instance.formFieldPackage);
  writeNotNull('ServerDate', instance.serverDate);
  writeNotNull('ContentPackage', instance.contentPackage);
  return val;
}

DocumentSignatureSessionFormFieldPackage
    _$DocumentSignatureSessionFormFieldPackageFromJson(
            Map<String, dynamic> json) =>
        DocumentSignatureSessionFormFieldPackage()
          ..formDesignType = json['FormDesignType'] as String?
          ..quickDesignPlaceInitials = json['QuickDesignPlaceInitials'] as bool?
          ..quickDesignPlaceFullName = json['QuickDesignPlaceFullName'] as bool?
          ..quickDesignPlaceEmail = json['QuickDesignPlaceEmail'] as bool?
          ..quickDesignPlaceTitle = json['QuickDesignPlaceTitle'] as bool?
          ..formFields = (json['FormFields'] as List<dynamic>?)
              ?.map((e) => DocumentSignatureSessionRecipientFormField.fromJson(
                  e as Map<String, dynamic>))
              .toList()
          ..completedFormFields = (json['CompletedFormFields']
                  as List<dynamic>?)
              ?.map((e) => DocumentSignatureSessionRecipientFormField.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$DocumentSignatureSessionFormFieldPackageToJson(
    DocumentSignatureSessionFormFieldPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FormDesignType', instance.formDesignType);
  writeNotNull('QuickDesignPlaceInitials', instance.quickDesignPlaceInitials);
  writeNotNull('QuickDesignPlaceFullName', instance.quickDesignPlaceFullName);
  writeNotNull('QuickDesignPlaceEmail', instance.quickDesignPlaceEmail);
  writeNotNull('QuickDesignPlaceTitle', instance.quickDesignPlaceTitle);
  writeNotNull('FormFields', instance.formFields);
  writeNotNull('CompletedFormFields', instance.completedFormFields);
  return val;
}

DocumentSignatureSessionRecipientFormField
    _$DocumentSignatureSessionRecipientFormFieldFromJson(
            Map<String, dynamic> json) =>
        DocumentSignatureSessionRecipientFormField()
          ..id = json['ID'] as String?
          ..documentSignatureFormFieldID =
              json['DocumentSignatureFormFieldID'] as String?
          ..documentSignatureSessionRecipientID =
              json['DocumentSignatureSessionRecipientID'] as String?
          ..documentSignatureSessionRecipientRank =
              json['DocumentSignatureSessionRecipientRank'] as int?
          ..isComplete = json['IsComplete'] as bool?
          ..type = json['Type'] as String?
          ..pageIndex = json['PageIndex'] as int?
          ..x = (json['X'] as num?)?.toDouble()
          ..y = (json['Y'] as num?)?.toDouble()
          ..value = json['Value'] as String?
          ..placementRank = json['PlacementRank'] as int?;

Map<String, dynamic> _$DocumentSignatureSessionRecipientFormFieldToJson(
    DocumentSignatureSessionRecipientFormField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull(
      'DocumentSignatureFormFieldID', instance.documentSignatureFormFieldID);
  writeNotNull('DocumentSignatureSessionRecipientID',
      instance.documentSignatureSessionRecipientID);
  writeNotNull('DocumentSignatureSessionRecipientRank',
      instance.documentSignatureSessionRecipientRank);
  writeNotNull('IsComplete', instance.isComplete);
  writeNotNull('Type', instance.type);
  writeNotNull('PageIndex', instance.pageIndex);
  writeNotNull('X', instance.x);
  writeNotNull('Y', instance.y);
  writeNotNull('Value', instance.value);
  writeNotNull('PlacementRank', instance.placementRank);
  return val;
}

DocumentSignatureSessionSigningRecipient
    _$DocumentSignatureSessionSigningRecipientFromJson(
            Map<String, dynamic> json) =>
        DocumentSignatureSessionSigningRecipient()
          ..email = json['Email'] as String?
          ..fullName = json['FullName'] as String?;

Map<String, dynamic> _$DocumentSignatureSessionSigningRecipientToJson(
    DocumentSignatureSessionSigningRecipient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Email', instance.email);
  writeNotNull('FullName', instance.fullName);
  return val;
}
