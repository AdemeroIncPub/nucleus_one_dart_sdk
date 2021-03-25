import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:test/test.dart';

const dashboardWidget1Json =
    r'{"ID":"Ub5J5Lgs27RF-tYYziBV776WcFGmWuIaaUtGa7batp4","TenantID":"yhv0SScPN5LxidjEfZCE","TenantMemberID":"n8rgN483rSfA9J84yb_T2Ce0okOdO1kNc4j7GXwAGt4","Type":"DashboardWidgetType_Capture","GridColumn":0,"ColumnRank":0,"Name":"","Detail":"","JsonData":""}';
const dashboardWidget2Json =
    r'{"ID":"OUUndeojgzBdMWuvACrK","TenantID":"yhv0SScPN5LxidjEfZCE","TenantMemberID":"n8rgN483rSfA9J84yb_T2Ce0okOdO1kNc4j7GXwAGt4","Type":"DashboardWidgetType_Folder","GridColumn":1,"ColumnRank":0,"Name":"Agreement","Detail":"","JsonData":"{\"FolderType\":\"folderHierarchies\",\"Name\":\"Agreement\",\"UniqueId\":\"oBc7dZx0C0UXpEpf8KOm_ByClassification_v3iBOAzEvGiRM8UFpG6p_1\",\"FolderHierarchyID\":\"oBc7dZx0C0UXpEpf8KOm\",\"ItemIndex\":1,\"HasChildren\":true,\"ApiParams\":{\"classificationID\":\"v3iBOAzEvGiRM8UFpG6p\"},\"SearchClassificationID\":\"v3iBOAzEvGiRM8UFpG6p\",\"ParentFolder\":{\"FolderType\":\"folderHierarchies\",\"FolderHierarchyID\":\"oBc7dZx0C0UXpEpf8KOm\",\"Name\":\"By Classification\",\"ItemIndex\":0,\"UniqueId\":\"oBc7dZx0C0UXpEpf8KOm\"}}"}';
const dashboardWidgetsJson = '[$dashboardWidget1Json,$dashboardWidget2Json]';

void main() {
  group('DashboardWidgets class tests', () {
    test('Serialization test', () {
      final dbws = DashboardWidgets.fromJson(dashboardWidgetsJson);
      const itemCount = 2;
      expect(dbws.items.length, itemCount);
    });
  });

  group('DashboardWidget class tests', () {
    test('Constructor test', () {
      final dbw = DashboardWidget();

      expect(dbw.id, null);
      expect(dbw.tenantID, null);
      expect(dbw.tenantMemberID, null);
      expect(dbw.type, null);
      expect(dbw.gridColumn, null);
      expect(dbw.columnRank, null);
      expect(dbw.name, null);
      expect(dbw.detail, null);
      expect(dbw.jsonData, null);
    });

    test('DashboardWidget.forRankUpdate constructor test', () {
      final dbw = DashboardWidget.forRankUpdate('1', 2, 3);

      expect(dbw.id, '1');
      expect(dbw.tenantID, null);
      expect(dbw.tenantMemberID, null);
      expect(dbw.type, null);
      expect(dbw.gridColumn, 2);
      expect(dbw.columnRank, 3);
      expect(dbw.name, null);
      expect(dbw.detail, null);
      expect(dbw.jsonData, null);
    });

    test('Serialization & deserialization test', () {
      try {
        var dbw = DashboardWidget.fromJson(jsonDecode(dashboardWidget1Json));

        expect(dbw.id, 'Ub5J5Lgs27RF-tYYziBV776WcFGmWuIaaUtGa7batp4');
        expect(dbw.tenantID, 'yhv0SScPN5LxidjEfZCE');
        expect(dbw.tenantMemberID, 'n8rgN483rSfA9J84yb_T2Ce0okOdO1kNc4j7GXwAGt4');
        expect(dbw.type, 'DashboardWidgetType_Capture');
        expect(dbw.gridColumn, 0);
        expect(dbw.columnRank, 0);
        expect(dbw.name, '');
        expect(dbw.detail, '');
        expect(dbw.jsonData, '');

        var jsonMap = dbw.toJson();
        expect(dashboardWidget1Json, jsonEncode(jsonMap));

        dbw = DashboardWidget.fromJson(jsonDecode(dashboardWidget2Json));

        expect(dbw.id, 'OUUndeojgzBdMWuvACrK');
        expect(dbw.tenantID, 'yhv0SScPN5LxidjEfZCE');
        expect(dbw.tenantMemberID, 'n8rgN483rSfA9J84yb_T2Ce0okOdO1kNc4j7GXwAGt4');
        expect(dbw.type, 'DashboardWidgetType_Folder');
        expect(dbw.gridColumn, 1);
        expect(dbw.columnRank, 0);
        expect(dbw.name, 'Agreement');
        expect(dbw.detail, '');
        expect(dbw.jsonData,
            '{\"FolderType\":\"folderHierarchies\",\"Name\":\"Agreement\",\"UniqueId\":\"oBc7dZx0C0UXpEpf8KOm_ByClassification_v3iBOAzEvGiRM8UFpG6p_1\",\"FolderHierarchyID\":\"oBc7dZx0C0UXpEpf8KOm\",\"ItemIndex\":1,\"HasChildren\":true,\"ApiParams\":{\"classificationID\":\"v3iBOAzEvGiRM8UFpG6p\"},\"SearchClassificationID\":\"v3iBOAzEvGiRM8UFpG6p\",\"ParentFolder\":{\"FolderType\":\"folderHierarchies\",\"FolderHierarchyID\":\"oBc7dZx0C0UXpEpf8KOm\",\"Name\":\"By Classification\",\"ItemIndex\":0,\"UniqueId\":\"oBc7dZx0C0UXpEpf8KOm\"}}');

        jsonMap = dbw.toJson();
        expect(dashboardWidget2Json, jsonEncode(jsonMap));
      } catch (e) {
        fail(
            'Boilerplate class methods fromJson/toJson for json_serializable failed the (de)serialization process with the following error.\r\n$e');
      }
    });
  });
}
