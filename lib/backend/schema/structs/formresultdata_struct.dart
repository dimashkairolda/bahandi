// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FormresultdataStruct extends BaseStruct {
  FormresultdataStruct({
    String? title,
    String? defect,
    String? normal,
    List<String>? remark,
    bool? required,
    String? description,
    List<String>? actionDefect,
    List<CheckboxesStruct>? checkboxes,
    List<RadiosStruct>? radios,
    String? image,
    List<DescriptionsStruct>? descriptions,
    String? to,
    String? from,
    String? unit,
    String? value,
  })  : _title = title,
        _defect = defect,
        _normal = normal,
        _remark = remark,
        _required = required,
        _description = description,
        _actionDefect = actionDefect,
        _checkboxes = checkboxes,
        _radios = radios,
        _image = image,
        _descriptions = descriptions,
        _to = to,
        _from = from,
        _unit = unit,
        _value = value;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "defect" field.
  String? _defect;
  String get defect => _defect ?? '';
  set defect(String? val) => _defect = val;

  bool hasDefect() => _defect != null;

  // "normal" field.
  String? _normal;
  String get normal => _normal ?? '';
  set normal(String? val) => _normal = val;

  bool hasNormal() => _normal != null;

  // "remark" field.
  List<String>? _remark;
  List<String> get remark => _remark ?? const [];
  set remark(List<String>? val) => _remark = val;

  void updateRemark(Function(List<String>) updateFn) {
    updateFn(_remark ??= []);
  }

  bool hasRemark() => _remark != null;

  // "required" field.
  bool? _required;
  bool get required => _required ?? false;
  set required(bool? val) => _required = val;

  bool hasRequired() => _required != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "action_defect" field.
  List<String>? _actionDefect;
  List<String> get actionDefect => _actionDefect ?? const [];
  set actionDefect(List<String>? val) => _actionDefect = val;

  void updateActionDefect(Function(List<String>) updateFn) {
    updateFn(_actionDefect ??= []);
  }

  bool hasActionDefect() => _actionDefect != null;

  // "checkboxes" field.
  List<CheckboxesStruct>? _checkboxes;
  List<CheckboxesStruct> get checkboxes => _checkboxes ?? const [];
  set checkboxes(List<CheckboxesStruct>? val) => _checkboxes = val;

  void updateCheckboxes(Function(List<CheckboxesStruct>) updateFn) {
    updateFn(_checkboxes ??= []);
  }

  bool hasCheckboxes() => _checkboxes != null;

  // "radios" field.
  List<RadiosStruct>? _radios;
  List<RadiosStruct> get radios => _radios ?? const [];
  set radios(List<RadiosStruct>? val) => _radios = val;

  void updateRadios(Function(List<RadiosStruct>) updateFn) {
    updateFn(_radios ??= []);
  }

  bool hasRadios() => _radios != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "descriptions" field.
  List<DescriptionsStruct>? _descriptions;
  List<DescriptionsStruct> get descriptions => _descriptions ?? const [];
  set descriptions(List<DescriptionsStruct>? val) => _descriptions = val;

  void updateDescriptions(Function(List<DescriptionsStruct>) updateFn) {
    updateFn(_descriptions ??= []);
  }

  bool hasDescriptions() => _descriptions != null;

  // "to" field.
  String? _to;
  String get to => _to ?? '';
  set to(String? val) => _to = val;

  bool hasTo() => _to != null;

  // "from" field.
  String? _from;
  String get from => _from ?? '';
  set from(String? val) => _from = val;

  bool hasFrom() => _from != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  static FormresultdataStruct fromMap(Map<String, dynamic> data) =>
      FormresultdataStruct(
        title: data['title'] as String?,
        defect: data['defect'] as String?,
        normal: data['normal'] as String?,
        remark: getDataList(data['remark']),
        required: data['required'] as bool?,
        description: data['description'] as String?,
        actionDefect: getDataList(data['action_defect']),
        checkboxes: getStructList(
          data['checkboxes'],
          CheckboxesStruct.fromMap,
        ),
        radios: getStructList(
          data['radios'],
          RadiosStruct.fromMap,
        ),
        image: data['image'] as String?,
        descriptions: getStructList(
          data['descriptions'],
          DescriptionsStruct.fromMap,
        ),
        to: data['to'] as String?,
        from: data['from'] as String?,
        unit: data['unit'] as String?,
        value: data['value'] as String?,
      );

  static FormresultdataStruct? maybeFromMap(dynamic data) => data is Map
      ? FormresultdataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'defect': _defect,
        'normal': _normal,
        'remark': _remark,
        'required': _required,
        'description': _description,
        'action_defect': _actionDefect,
        'checkboxes': _checkboxes?.map((e) => e.toMap()).toList(),
        'radios': _radios?.map((e) => e.toMap()).toList(),
        'image': _image,
        'descriptions': _descriptions?.map((e) => e.toMap()).toList(),
        'to': _to,
        'from': _from,
        'unit': _unit,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'defect': serializeParam(
          _defect,
          ParamType.String,
        ),
        'normal': serializeParam(
          _normal,
          ParamType.String,
        ),
        'remark': serializeParam(
          _remark,
          ParamType.String,
          isList: true,
        ),
        'required': serializeParam(
          _required,
          ParamType.bool,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'action_defect': serializeParam(
          _actionDefect,
          ParamType.String,
          isList: true,
        ),
        'checkboxes': serializeParam(
          _checkboxes,
          ParamType.DataStruct,
          isList: true,
        ),
        'radios': serializeParam(
          _radios,
          ParamType.DataStruct,
          isList: true,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'descriptions': serializeParam(
          _descriptions,
          ParamType.DataStruct,
          isList: true,
        ),
        'to': serializeParam(
          _to,
          ParamType.String,
        ),
        'from': serializeParam(
          _from,
          ParamType.String,
        ),
        'unit': serializeParam(
          _unit,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
      }.withoutNulls;

  static FormresultdataStruct fromSerializableMap(Map<String, dynamic> data) =>
      FormresultdataStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        defect: deserializeParam(
          data['defect'],
          ParamType.String,
          false,
        ),
        normal: deserializeParam(
          data['normal'],
          ParamType.String,
          false,
        ),
        remark: deserializeParam<String>(
          data['remark'],
          ParamType.String,
          true,
        ),
        required: deserializeParam(
          data['required'],
          ParamType.bool,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        actionDefect: deserializeParam<String>(
          data['action_defect'],
          ParamType.String,
          true,
        ),
        checkboxes: deserializeStructParam<CheckboxesStruct>(
          data['checkboxes'],
          ParamType.DataStruct,
          true,
          structBuilder: CheckboxesStruct.fromSerializableMap,
        ),
        radios: deserializeStructParam<RadiosStruct>(
          data['radios'],
          ParamType.DataStruct,
          true,
          structBuilder: RadiosStruct.fromSerializableMap,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        descriptions: deserializeStructParam<DescriptionsStruct>(
          data['descriptions'],
          ParamType.DataStruct,
          true,
          structBuilder: DescriptionsStruct.fromSerializableMap,
        ),
        to: deserializeParam(
          data['to'],
          ParamType.String,
          false,
        ),
        from: deserializeParam(
          data['from'],
          ParamType.String,
          false,
        ),
        unit: deserializeParam(
          data['unit'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FormresultdataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FormresultdataStruct &&
        title == other.title &&
        defect == other.defect &&
        normal == other.normal &&
        listEquality.equals(remark, other.remark) &&
        required == other.required &&
        description == other.description &&
        listEquality.equals(actionDefect, other.actionDefect) &&
        listEquality.equals(checkboxes, other.checkboxes) &&
        listEquality.equals(radios, other.radios) &&
        image == other.image &&
        listEquality.equals(descriptions, other.descriptions) &&
        to == other.to &&
        from == other.from &&
        unit == other.unit &&
        value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        defect,
        normal,
        remark,
        required,
        description,
        actionDefect,
        checkboxes,
        radios,
        image,
        descriptions,
        to,
        from,
        unit,
        value
      ]);
}

FormresultdataStruct createFormresultdataStruct({
  String? title,
  String? defect,
  String? normal,
  bool? required,
  String? description,
  String? image,
  String? to,
  String? from,
  String? unit,
  String? value,
}) =>
    FormresultdataStruct(
      title: title,
      defect: defect,
      normal: normal,
      required: required,
      description: description,
      image: image,
      to: to,
      from: from,
      unit: unit,
      value: value,
    );
