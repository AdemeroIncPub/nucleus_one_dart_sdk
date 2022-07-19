import 'package:get_it/get_it.dart';
import '../common/model.dart';
import '../api_model/support_error_event.dart' as api_mod;
import '../nucleus_one.dart';

class SupportErrorEventCollection
    extends EntityCollection<SupportErrorEvent, api_mod.SupportErrorEventCollection> {
  SupportErrorEventCollection({
    NucleusOneApp? app,
    List<SupportErrorEvent>? items,
  }) : super(app: app, items: items);

  factory SupportErrorEventCollection.fromApiModel(
    api_mod.SupportErrorEventCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return SupportErrorEventCollection(
        items: apiModel.supportErrorEvents?.map((x) => SupportErrorEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.SupportErrorEventCollection toApiModel() {
    return api_mod.SupportErrorEventCollection()
      ..supportErrorEvents = items.map((x) => x.toApiModel()).toList();
  }
}

class SupportErrorEvent with NucleusOneAppDependent {
  SupportErrorEvent._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.tenantID,
    required this.tenantName,
    required this.tenantNameLower,
    required this.userEmailLower,
    required this.userID,
    required this.serviceNameLower,
    required this.level,
    required this.uniqueID,
    required this.requestURI,
    required this.header,
    required this.message,
    required this.clientMessage,
    required this.httpStatus,
    required this.otherValues,
    required this.wordsLower,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory SupportErrorEvent.fromApiModel(
    api_mod.SupportErrorEvent apiModel, {
    NucleusOneApp? app,
  }) {
    return SupportErrorEvent._(
      app: app,
      id: apiModel.id!,
      createdOn: apiModel.createdOn!,
      tenantID: apiModel.tenantID!,
      tenantName: apiModel.tenantName!,
      tenantNameLower: apiModel.tenantNameLower!,
      userEmailLower: apiModel.userEmailLower!,
      userID: apiModel.userID!,
      serviceNameLower: apiModel.serviceNameLower!,
      level: apiModel.level!,
      uniqueID: apiModel.uniqueID!,
      requestURI: apiModel.requestURI!,
      header: apiModel.header!,
      message: apiModel.message!,
      clientMessage: apiModel.clientMessage!,
      httpStatus: apiModel.httpStatus!,
      otherValues: apiModel.otherValues!,
      wordsLower: apiModel.wordsLower!,
    );
  }

  String id;

  String createdOn;

  String tenantID;

  String tenantName;

  String tenantNameLower;

  String userEmailLower;

  String userID;

  String serviceNameLower;

  String level;

  String uniqueID;

  String requestURI;

  String header;

  String message;

  String clientMessage;

  int httpStatus;

  List<String> otherValues;

  List<String> wordsLower;

  api_mod.SupportErrorEvent toApiModel() {
    return api_mod.SupportErrorEvent()
      ..id = id
      ..createdOn = createdOn
      ..tenantID = tenantID
      ..tenantName = tenantName
      ..tenantNameLower = tenantNameLower
      ..userEmailLower = userEmailLower
      ..userID = userID
      ..serviceNameLower = serviceNameLower
      ..level = level
      ..uniqueID = uniqueID
      ..requestURI = requestURI
      ..header = header
      ..message = message
      ..clientMessage = clientMessage
      ..httpStatus = httpStatus
      ..otherValues = otherValues
      ..wordsLower = wordsLower;
  }
}
