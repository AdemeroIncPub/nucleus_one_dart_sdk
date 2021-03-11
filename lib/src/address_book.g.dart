// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddressBookItem> _$addressBookItemSerializer =
    new _$AddressBookItemSerializer();

class _$AddressBookItemSerializer
    implements StructuredSerializer<AddressBookItem> {
  @override
  final Iterable<Type> types = const [AddressBookItem, _$AddressBookItem];
  @override
  final String wireName = 'AddressBookItem';

  @override
  Iterable<Object> serialize(Serializers serializers, AddressBookItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'EmailLower',
      serializers.serialize(object.emailLower,
          specifiedType: const FullType(String)),
      'Name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'TenantMemberID',
      serializers.serialize(object.tenantMemberID,
          specifiedType: const FullType(String)),
      'RoleID',
      serializers.serialize(object.roleID,
          specifiedType: const FullType(String)),
      'FieldID',
      serializers.serialize(object.fieldID,
          specifiedType: const FullType(String)),
      'FormTemplateID',
      serializers.serialize(object.formTemplateID,
          specifiedType: const FullType(String)),
      'FormTemplateName',
      serializers.serialize(object.formTemplateName,
          specifiedType: const FullType(String)),
      'FormTemplateFieldID',
      serializers.serialize(object.formTemplateFieldID,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AddressBookItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddressBookItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'EmailLower':
          result.emailLower = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'TenantMemberID':
          result.tenantMemberID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'RoleID':
          result.roleID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'FieldID':
          result.fieldID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'FormTemplateID':
          result.formTemplateID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'FormTemplateName':
          result.formTemplateName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'FormTemplateFieldID':
          result.formTemplateFieldID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AddressBookItem extends AddressBookItem {
  @override
  final String emailLower;
  @override
  final String name;
  @override
  final String tenantMemberID;
  @override
  final String roleID;
  @override
  final String fieldID;
  @override
  final String formTemplateID;
  @override
  final String formTemplateName;
  @override
  final String formTemplateFieldID;

  factory _$AddressBookItem([void Function(AddressBookItemBuilder) updates]) =>
      (new AddressBookItemBuilder()..update(updates)).build();

  _$AddressBookItem._(
      {this.emailLower,
      this.name,
      this.tenantMemberID,
      this.roleID,
      this.fieldID,
      this.formTemplateID,
      this.formTemplateName,
      this.formTemplateFieldID})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        emailLower, 'AddressBookItem', 'emailLower');
    BuiltValueNullFieldError.checkNotNull(name, 'AddressBookItem', 'name');
    BuiltValueNullFieldError.checkNotNull(
        tenantMemberID, 'AddressBookItem', 'tenantMemberID');
    BuiltValueNullFieldError.checkNotNull(roleID, 'AddressBookItem', 'roleID');
    BuiltValueNullFieldError.checkNotNull(
        fieldID, 'AddressBookItem', 'fieldID');
    BuiltValueNullFieldError.checkNotNull(
        formTemplateID, 'AddressBookItem', 'formTemplateID');
    BuiltValueNullFieldError.checkNotNull(
        formTemplateName, 'AddressBookItem', 'formTemplateName');
    BuiltValueNullFieldError.checkNotNull(
        formTemplateFieldID, 'AddressBookItem', 'formTemplateFieldID');
  }

  @override
  AddressBookItem rebuild(void Function(AddressBookItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddressBookItemBuilder toBuilder() =>
      new AddressBookItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddressBookItem &&
        emailLower == other.emailLower &&
        name == other.name &&
        tenantMemberID == other.tenantMemberID &&
        roleID == other.roleID &&
        fieldID == other.fieldID &&
        formTemplateID == other.formTemplateID &&
        formTemplateName == other.formTemplateName &&
        formTemplateFieldID == other.formTemplateFieldID;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, emailLower.hashCode), name.hashCode),
                            tenantMemberID.hashCode),
                        roleID.hashCode),
                    fieldID.hashCode),
                formTemplateID.hashCode),
            formTemplateName.hashCode),
        formTemplateFieldID.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AddressBookItem')
          ..add('emailLower', emailLower)
          ..add('name', name)
          ..add('tenantMemberID', tenantMemberID)
          ..add('roleID', roleID)
          ..add('fieldID', fieldID)
          ..add('formTemplateID', formTemplateID)
          ..add('formTemplateName', formTemplateName)
          ..add('formTemplateFieldID', formTemplateFieldID))
        .toString();
  }
}

class AddressBookItemBuilder
    implements Builder<AddressBookItem, AddressBookItemBuilder> {
  _$AddressBookItem _$v;

  String _emailLower;
  String get emailLower => _$this._emailLower;
  set emailLower(String emailLower) => _$this._emailLower = emailLower;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _tenantMemberID;
  String get tenantMemberID => _$this._tenantMemberID;
  set tenantMemberID(String tenantMemberID) =>
      _$this._tenantMemberID = tenantMemberID;

  String _roleID;
  String get roleID => _$this._roleID;
  set roleID(String roleID) => _$this._roleID = roleID;

  String _fieldID;
  String get fieldID => _$this._fieldID;
  set fieldID(String fieldID) => _$this._fieldID = fieldID;

  String _formTemplateID;
  String get formTemplateID => _$this._formTemplateID;
  set formTemplateID(String formTemplateID) =>
      _$this._formTemplateID = formTemplateID;

  String _formTemplateName;
  String get formTemplateName => _$this._formTemplateName;
  set formTemplateName(String formTemplateName) =>
      _$this._formTemplateName = formTemplateName;

  String _formTemplateFieldID;
  String get formTemplateFieldID => _$this._formTemplateFieldID;
  set formTemplateFieldID(String formTemplateFieldID) =>
      _$this._formTemplateFieldID = formTemplateFieldID;

  AddressBookItemBuilder();

  AddressBookItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _emailLower = $v.emailLower;
      _name = $v.name;
      _tenantMemberID = $v.tenantMemberID;
      _roleID = $v.roleID;
      _fieldID = $v.fieldID;
      _formTemplateID = $v.formTemplateID;
      _formTemplateName = $v.formTemplateName;
      _formTemplateFieldID = $v.formTemplateFieldID;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddressBookItem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddressBookItem;
  }

  @override
  void update(void Function(AddressBookItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AddressBookItem build() {
    final _$result = _$v ??
        new _$AddressBookItem._(
            emailLower: BuiltValueNullFieldError.checkNotNull(
                emailLower, 'AddressBookItem', 'emailLower'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'AddressBookItem', 'name'),
            tenantMemberID: BuiltValueNullFieldError.checkNotNull(
                tenantMemberID, 'AddressBookItem', 'tenantMemberID'),
            roleID: BuiltValueNullFieldError.checkNotNull(
                roleID, 'AddressBookItem', 'roleID'),
            fieldID: BuiltValueNullFieldError.checkNotNull(
                fieldID, 'AddressBookItem', 'fieldID'),
            formTemplateID: BuiltValueNullFieldError.checkNotNull(
                formTemplateID, 'AddressBookItem', 'formTemplateID'),
            formTemplateName: BuiltValueNullFieldError.checkNotNull(
                formTemplateName, 'AddressBookItem', 'formTemplateName'),
            formTemplateFieldID: BuiltValueNullFieldError.checkNotNull(
                formTemplateFieldID, 'AddressBookItem', 'formTemplateFieldID'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
