// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_widget.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DashboardWidget> _$dashboardWidgetSerializer =
    new _$DashboardWidgetSerializer();

class _$DashboardWidgetSerializer
    implements StructuredSerializer<DashboardWidget> {
  @override
  final Iterable<Type> types = const [DashboardWidget, _$DashboardWidget];
  @override
  final String wireName = 'DashboardWidget';

  @override
  Iterable<Object> serialize(Serializers serializers, DashboardWidget object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ID',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'TenantID',
      serializers.serialize(object.tenantID,
          specifiedType: const FullType(String)),
      'TenantMemberID',
      serializers.serialize(object.tenantMemberID,
          specifiedType: const FullType(String)),
      'Type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'GridColumn',
      serializers.serialize(object.gridColumn,
          specifiedType: const FullType(int)),
      'ColumnRank',
      serializers.serialize(object.columnRank,
          specifiedType: const FullType(int)),
      'Name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'Detail',
      serializers.serialize(object.detail,
          specifiedType: const FullType(String)),
      'JsonData',
      serializers.serialize(object.jsonData,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DashboardWidget deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DashboardWidgetBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'ID':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'TenantID':
          result.tenantID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'TenantMemberID':
          result.tenantMemberID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'GridColumn':
          result.gridColumn = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ColumnRank':
          result.columnRank = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'Name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Detail':
          result.detail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'JsonData':
          result.jsonData = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardWidget extends DashboardWidget {
  @override
  final String id;
  @override
  final String tenantID;
  @override
  final String tenantMemberID;
  @override
  final String type;
  @override
  final int gridColumn;
  @override
  final int columnRank;
  @override
  final String name;
  @override
  final String detail;
  @override
  final String jsonData;

  factory _$DashboardWidget([void Function(DashboardWidgetBuilder) updates]) =>
      (new DashboardWidgetBuilder()..update(updates)).build();

  _$DashboardWidget._(
      {this.id,
      this.tenantID,
      this.tenantMemberID,
      this.type,
      this.gridColumn,
      this.columnRank,
      this.name,
      this.detail,
      this.jsonData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'DashboardWidget', 'id');
    BuiltValueNullFieldError.checkNotNull(
        tenantID, 'DashboardWidget', 'tenantID');
    BuiltValueNullFieldError.checkNotNull(
        tenantMemberID, 'DashboardWidget', 'tenantMemberID');
    BuiltValueNullFieldError.checkNotNull(type, 'DashboardWidget', 'type');
    BuiltValueNullFieldError.checkNotNull(
        gridColumn, 'DashboardWidget', 'gridColumn');
    BuiltValueNullFieldError.checkNotNull(
        columnRank, 'DashboardWidget', 'columnRank');
    BuiltValueNullFieldError.checkNotNull(name, 'DashboardWidget', 'name');
    BuiltValueNullFieldError.checkNotNull(detail, 'DashboardWidget', 'detail');
    BuiltValueNullFieldError.checkNotNull(
        jsonData, 'DashboardWidget', 'jsonData');
  }

  @override
  DashboardWidget rebuild(void Function(DashboardWidgetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardWidgetBuilder toBuilder() =>
      new DashboardWidgetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardWidget &&
        id == other.id &&
        tenantID == other.tenantID &&
        tenantMemberID == other.tenantMemberID &&
        type == other.type &&
        gridColumn == other.gridColumn &&
        columnRank == other.columnRank &&
        name == other.name &&
        detail == other.detail &&
        jsonData == other.jsonData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), tenantID.hashCode),
                                tenantMemberID.hashCode),
                            type.hashCode),
                        gridColumn.hashCode),
                    columnRank.hashCode),
                name.hashCode),
            detail.hashCode),
        jsonData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardWidget')
          ..add('id', id)
          ..add('tenantID', tenantID)
          ..add('tenantMemberID', tenantMemberID)
          ..add('type', type)
          ..add('gridColumn', gridColumn)
          ..add('columnRank', columnRank)
          ..add('name', name)
          ..add('detail', detail)
          ..add('jsonData', jsonData))
        .toString();
  }
}

class DashboardWidgetBuilder
    implements Builder<DashboardWidget, DashboardWidgetBuilder> {
  _$DashboardWidget _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _tenantID;
  String get tenantID => _$this._tenantID;
  set tenantID(String tenantID) => _$this._tenantID = tenantID;

  String _tenantMemberID;
  String get tenantMemberID => _$this._tenantMemberID;
  set tenantMemberID(String tenantMemberID) =>
      _$this._tenantMemberID = tenantMemberID;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _gridColumn;
  int get gridColumn => _$this._gridColumn;
  set gridColumn(int gridColumn) => _$this._gridColumn = gridColumn;

  int _columnRank;
  int get columnRank => _$this._columnRank;
  set columnRank(int columnRank) => _$this._columnRank = columnRank;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _detail;
  String get detail => _$this._detail;
  set detail(String detail) => _$this._detail = detail;

  String _jsonData;
  String get jsonData => _$this._jsonData;
  set jsonData(String jsonData) => _$this._jsonData = jsonData;

  DashboardWidgetBuilder();

  DashboardWidgetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _tenantID = $v.tenantID;
      _tenantMemberID = $v.tenantMemberID;
      _type = $v.type;
      _gridColumn = $v.gridColumn;
      _columnRank = $v.columnRank;
      _name = $v.name;
      _detail = $v.detail;
      _jsonData = $v.jsonData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardWidget other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashboardWidget;
  }

  @override
  void update(void Function(DashboardWidgetBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardWidget build() {
    final _$result = _$v ??
        new _$DashboardWidget._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'DashboardWidget', 'id'),
            tenantID: BuiltValueNullFieldError.checkNotNull(
                tenantID, 'DashboardWidget', 'tenantID'),
            tenantMemberID: BuiltValueNullFieldError.checkNotNull(
                tenantMemberID, 'DashboardWidget', 'tenantMemberID'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'DashboardWidget', 'type'),
            gridColumn: BuiltValueNullFieldError.checkNotNull(
                gridColumn, 'DashboardWidget', 'gridColumn'),
            columnRank: BuiltValueNullFieldError.checkNotNull(
                columnRank, 'DashboardWidget', 'columnRank'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'DashboardWidget', 'name'),
            detail: BuiltValueNullFieldError.checkNotNull(
                detail, 'DashboardWidget', 'detail'),
            jsonData: BuiltValueNullFieldError.checkNotNull(
                jsonData, 'DashboardWidget', 'jsonData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
