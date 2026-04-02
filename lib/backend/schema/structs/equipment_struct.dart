// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EquipmentStruct extends BaseStruct {
  EquipmentStruct({
    int? id,
    int? type,
    TypeInfoStruct? typeInfo,
    int? manufacturer,
    ManufacturerInfoStruct? manufacturerInfo,
    int? model,
    ModelInfoStruct? modelInfo,
    List<int>? departments,
    List<DepartmentsInfoStruct>? departmentsInfo,
    List<int>? responsibles,
    List<dynamic>? responsiblesInfo,
    String? factoryNumber,
    String? inventoryNumber,
    String? dispatchNumber,
    String? operatingTime,
    String? operationalDate,
    List<String>? technicalParameters,
    List<String>? operationalParameters,
    String? img,
    String? parent,
    List<String>? files,
    String? catalogGroup,
    String? title,
    String? parentInfo,
    int? author,
    String? numberScheme,
    bool? hasMonitoring,
    String? productiveAsset,
    String? productiveAssetInfo,
    String? barcode,
    int? area,
    AreaInfoStruct? areaInfo,
    String? status,
    List<String>? works,
    List<String>? spareParts,
  })  : _id = id,
        _type = type,
        _typeInfo = typeInfo,
        _manufacturer = manufacturer,
        _manufacturerInfo = manufacturerInfo,
        _model = model,
        _modelInfo = modelInfo,
        _departments = departments,
        _departmentsInfo = departmentsInfo,
        _responsibles = responsibles,
        _responsiblesInfo = responsiblesInfo,
        _factoryNumber = factoryNumber,
        _inventoryNumber = inventoryNumber,
        _dispatchNumber = dispatchNumber,
        _operatingTime = operatingTime,
        _operationalDate = operationalDate,
        _technicalParameters = technicalParameters,
        _operationalParameters = operationalParameters,
        _img = img,
        _parent = parent,
        _files = files,
        _catalogGroup = catalogGroup,
        _title = title,
        _parentInfo = parentInfo,
        _author = author,
        _numberScheme = numberScheme,
        _hasMonitoring = hasMonitoring,
        _productiveAsset = productiveAsset,
        _productiveAssetInfo = productiveAssetInfo,
        _barcode = barcode,
        _area = area,
        _areaInfo = areaInfo,
        _status = status,
        _works = works,
        _spareParts = spareParts;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  // "type_info" field.
  TypeInfoStruct? _typeInfo;
  TypeInfoStruct get typeInfo => _typeInfo ?? TypeInfoStruct();
  set typeInfo(TypeInfoStruct? val) => _typeInfo = val;

  void updateTypeInfo(Function(TypeInfoStruct) updateFn) {
    updateFn(_typeInfo ??= TypeInfoStruct());
  }

  bool hasTypeInfo() => _typeInfo != null;

  // "manufacturer" field.
  int? _manufacturer;
  int get manufacturer => _manufacturer ?? 0;
  set manufacturer(int? val) => _manufacturer = val;

  void incrementManufacturer(int amount) =>
      manufacturer = manufacturer + amount;

  bool hasManufacturer() => _manufacturer != null;

  // "manufacturer_info" field.
  ManufacturerInfoStruct? _manufacturerInfo;
  ManufacturerInfoStruct get manufacturerInfo =>
      _manufacturerInfo ?? ManufacturerInfoStruct();
  set manufacturerInfo(ManufacturerInfoStruct? val) => _manufacturerInfo = val;

  void updateManufacturerInfo(Function(ManufacturerInfoStruct) updateFn) {
    updateFn(_manufacturerInfo ??= ManufacturerInfoStruct());
  }

  bool hasManufacturerInfo() => _manufacturerInfo != null;

  // "model" field.
  int? _model;
  int get model => _model ?? 0;
  set model(int? val) => _model = val;

  void incrementModel(int amount) => model = model + amount;

  bool hasModel() => _model != null;

  // "model_info" field.
  ModelInfoStruct? _modelInfo;
  ModelInfoStruct get modelInfo => _modelInfo ?? ModelInfoStruct();
  set modelInfo(ModelInfoStruct? val) => _modelInfo = val;

  void updateModelInfo(Function(ModelInfoStruct) updateFn) {
    updateFn(_modelInfo ??= ModelInfoStruct());
  }

  bool hasModelInfo() => _modelInfo != null;

  // "departments" field.
  List<int>? _departments;
  List<int> get departments => _departments ?? const [];
  set departments(List<int>? val) => _departments = val;

  void updateDepartments(Function(List<int>) updateFn) {
    updateFn(_departments ??= []);
  }

  bool hasDepartments() => _departments != null;

  // "departments_info" field.
  List<DepartmentsInfoStruct>? _departmentsInfo;
  List<DepartmentsInfoStruct> get departmentsInfo =>
      _departmentsInfo ?? const [];
  set departmentsInfo(List<DepartmentsInfoStruct>? val) =>
      _departmentsInfo = val;

  void updateDepartmentsInfo(Function(List<DepartmentsInfoStruct>) updateFn) {
    updateFn(_departmentsInfo ??= []);
  }

  bool hasDepartmentsInfo() => _departmentsInfo != null;

  // "responsibles" field.
  List<int>? _responsibles;
  List<int> get responsibles => _responsibles ?? const [];
  set responsibles(List<int>? val) => _responsibles = val;

  void updateResponsibles(Function(List<int>) updateFn) {
    updateFn(_responsibles ??= []);
  }

  bool hasResponsibles() => _responsibles != null;

  // "responsibles_info" field.
  List<dynamic>? _responsiblesInfo;
  List<dynamic> get responsiblesInfo => _responsiblesInfo ?? [];
  set responsiblesInfo(List<dynamic>? val) => _responsiblesInfo = val;

  void updateResponsiblesInfo(Function(List<dynamic>) updateFn) {
    updateFn(_responsiblesInfo ??= []);
  }

  bool hasResponsiblesInfo() => _responsiblesInfo != null;
    

  // "factory_number" field.
  String? _factoryNumber;
  String get factoryNumber => _factoryNumber ?? '';
  set factoryNumber(String? val) => _factoryNumber = val;

  bool hasFactoryNumber() => _factoryNumber != null;

  // "inventory_number" field.
  String? _inventoryNumber;
  String get inventoryNumber => _inventoryNumber ?? '';
  set inventoryNumber(String? val) => _inventoryNumber = val;

  bool hasInventoryNumber() => _inventoryNumber != null;

  // "dispatch_number" field.
  String? _dispatchNumber;
  String get dispatchNumber => _dispatchNumber ?? '';
  set dispatchNumber(String? val) => _dispatchNumber = val;

  bool hasDispatchNumber() => _dispatchNumber != null;

  // "operating_time" field.
  String? _operatingTime;
  String get operatingTime => _operatingTime ?? '';
  set operatingTime(String? val) => _operatingTime = val;

  bool hasOperatingTime() => _operatingTime != null;

  // "operational_date" field.
  String? _operationalDate;
  String get operationalDate => _operationalDate ?? '';
  set operationalDate(String? val) => _operationalDate = val;

  bool hasOperationalDate() => _operationalDate != null;

  // "technical_parameters" field.
  List<String>? _technicalParameters;
  List<String> get technicalParameters => _technicalParameters ?? const [];
  set technicalParameters(List<String>? val) => _technicalParameters = val;

  void updateTechnicalParameters(Function(List<String>) updateFn) {
    updateFn(_technicalParameters ??= []);
  }

  bool hasTechnicalParameters() => _technicalParameters != null;

  // "operational_parameters" field.
  List<String>? _operationalParameters;
  List<String> get operationalParameters => _operationalParameters ?? const [];
  set operationalParameters(List<String>? val) => _operationalParameters = val;

  void updateOperationalParameters(Function(List<String>) updateFn) {
    updateFn(_operationalParameters ??= []);
  }

  bool hasOperationalParameters() => _operationalParameters != null;

  // "img" field.
  String? _img;
  String get img => _img ?? '';
  set img(String? val) => _img = val;

  bool hasImg() => _img != null;

  // "parent" field.
  String? _parent;
  String get parent => _parent ?? '';
  set parent(String? val) => _parent = val;

  bool hasParent() => _parent != null;

  // "files" field.
  List<String>? _files;
  List<String> get files => _files ?? const [];
  set files(List<String>? val) => _files = val;

  void updateFiles(Function(List<String>) updateFn) {
    updateFn(_files ??= []);
  }

  bool hasFiles() => _files != null;

  // "catalog_group" field.
  String? _catalogGroup;
  String get catalogGroup => _catalogGroup ?? '';
  set catalogGroup(String? val) => _catalogGroup = val;

  bool hasCatalogGroup() => _catalogGroup != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "parent_info" field.
  String? _parentInfo;
  String get parentInfo => _parentInfo ?? '';
  set parentInfo(String? val) => _parentInfo = val;

  bool hasParentInfo() => _parentInfo != null;

  // "author" field.
  int? _author;
  int get author => _author ?? 0;
  set author(int? val) => _author = val;

  void incrementAuthor(int amount) => author = author + amount;

  bool hasAuthor() => _author != null;

  // "number_scheme" field.
  String? _numberScheme;
  String get numberScheme => _numberScheme ?? '';
  set numberScheme(String? val) => _numberScheme = val;

  bool hasNumberScheme() => _numberScheme != null;

  // "has_monitoring" field.
  bool? _hasMonitoring;
  bool get hasMonitoring => _hasMonitoring ?? false;
  set hasMonitoring(bool? val) => _hasMonitoring = val;

  bool hasHasMonitoring() => _hasMonitoring != null;

  // "productive_asset" field.
  String? _productiveAsset;
  String get productiveAsset => _productiveAsset ?? '';
  set productiveAsset(String? val) => _productiveAsset = val;

  bool hasProductiveAsset() => _productiveAsset != null;

  // "productive_asset_info" field.
  String? _productiveAssetInfo;
  String get productiveAssetInfo => _productiveAssetInfo ?? '';
  set productiveAssetInfo(String? val) => _productiveAssetInfo = val;

  bool hasProductiveAssetInfo() => _productiveAssetInfo != null;

  // "barcode" field.
  String? _barcode;
  String get barcode => _barcode ?? '';
  set barcode(String? val) => _barcode = val;

  bool hasBarcode() => _barcode != null;

  // "area" field.
  int? _area;
  int get area => _area ?? 0;
  set area(int? val) => _area = val;

  void incrementArea(int amount) => area = area + amount;

  bool hasArea() => _area != null;

  // "area_info" field.
  AreaInfoStruct? _areaInfo;
  AreaInfoStruct get areaInfo => _areaInfo ?? AreaInfoStruct();
  set areaInfo(AreaInfoStruct? val) => _areaInfo = val;

  void updateAreaInfo(Function(AreaInfoStruct) updateFn) {
    updateFn(_areaInfo ??= AreaInfoStruct());
  }

  bool hasAreaInfo() => _areaInfo != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "works" field.
  List<String>? _works;
  List<String> get works => _works ?? const [];
  set works(List<String>? val) => _works = val;

  void updateWorks(Function(List<String>) updateFn) {
    updateFn(_works ??= []);
  }

  bool hasWorks() => _works != null;

  // "spare_parts" field.
  List<String>? _spareParts;
  List<String> get spareParts => _spareParts ?? const [];
  set spareParts(List<String>? val) => _spareParts = val;

  void updateSpareParts(Function(List<String>) updateFn) {
    updateFn(_spareParts ??= []);
  }

  bool hasSpareParts() => _spareParts != null;

  static EquipmentStruct fromMap(Map<String, dynamic> data) => EquipmentStruct(
        id: castToType<int>(data['id']),
        type: castToType<int>(data['type']),
        typeInfo: data['type_info'] is TypeInfoStruct
            ? data['type_info']
            : TypeInfoStruct.maybeFromMap(data['type_info']),
        manufacturer: castToType<int>(data['manufacturer']),
        manufacturerInfo: data['manufacturer_info'] is ManufacturerInfoStruct
            ? data['manufacturer_info']
            : ManufacturerInfoStruct.maybeFromMap(data['manufacturer_info']),
        model: castToType<int>(data['model']),
        modelInfo: data['model_info'] is ModelInfoStruct
            ? data['model_info']
            : ModelInfoStruct.maybeFromMap(data['model_info']),
        departments: getDataList(data['departments']),
        departmentsInfo: getStructList(
          data['departments_info'],
          DepartmentsInfoStruct.fromMap,
        ),
        responsibles: getDataList(data['responsibles']),
        responsiblesInfo: getDataList(data['responsibles_info']),
        factoryNumber: data['factory_number'] as String?,
        inventoryNumber: data['inventory_number'] as String?,
        dispatchNumber: data['dispatch_number'] as String?,
        operatingTime: data['operating_time'] as String?,
        operationalDate: data['operational_date'] as String?,
        technicalParameters: getDataList(data['technical_parameters']),
        operationalParameters: getDataList(data['operational_parameters']),
        img: data['img'] as String?,
        parent: data['parent'] as String?,
        files: getDataList(data['files']),
        catalogGroup: data['catalog_group'] as String?,
        title: data['title'] as String?,
        parentInfo: data['parent_info'] as String?,
        author: castToType<int>(data['author']),
        numberScheme: data['number_scheme'] as String?,
        hasMonitoring: data['has_monitoring'] as bool?,
        productiveAsset: data['productive_asset'] as String?,
        productiveAssetInfo: data['productive_asset_info'] as String?,
        barcode: data['barcode'] as String?,
        area: castToType<int>(data['area']),
        areaInfo: data['area_info'] is AreaInfoStruct
            ? data['area_info']
            : AreaInfoStruct.maybeFromMap(data['area_info']),
        status: data['status'] as String?,
        works: getDataList(data['works']),
        spareParts: getDataList(data['spare_parts']),
      );

  static EquipmentStruct? maybeFromMap(dynamic data) => data is Map
      ? EquipmentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'type': _type,
        'type_info': _typeInfo?.toMap(),
        'manufacturer': _manufacturer,
        'manufacturer_info': _manufacturerInfo?.toMap(),
        'model': _model,
        'model_info': _modelInfo?.toMap(),
        'departments': _departments,
        'departments_info': _departmentsInfo?.map((e) => e.toMap()).toList(),
        'responsibles': _responsibles,
        'responsibles_info': _responsiblesInfo,
        'factory_number': _factoryNumber,
        'inventory_number': _inventoryNumber,
        'dispatch_number': _dispatchNumber,
        'operating_time': _operatingTime,
        'operational_date': _operationalDate,
        'technical_parameters': _technicalParameters,
        'operational_parameters': _operationalParameters,
        'img': _img,
        'parent': _parent,
        'files': _files,
        'catalog_group': _catalogGroup,
        'title': _title,
        'parent_info': _parentInfo,
        'author': _author,
        'number_scheme': _numberScheme,
        'has_monitoring': _hasMonitoring,
        'productive_asset': _productiveAsset,
        'productive_asset_info': _productiveAssetInfo,
        'barcode': _barcode,
        'area': _area,
        'area_info': _areaInfo?.toMap(),
        'status': _status,
        'works': _works,
        'spare_parts': _spareParts,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
        'type_info': serializeParam(
          _typeInfo,
          ParamType.DataStruct,
        ),
        'manufacturer': serializeParam(
          _manufacturer,
          ParamType.int,
        ),
        'manufacturer_info': serializeParam(
          _manufacturerInfo,
          ParamType.DataStruct,
        ),
        'model': serializeParam(
          _model,
          ParamType.int,
        ),
        'model_info': serializeParam(
          _modelInfo,
          ParamType.DataStruct,
        ),
        'departments': serializeParam(
          _departments,
          ParamType.int,
          isList: true,
        ),
        'departments_info': serializeParam(
          _departmentsInfo,
          ParamType.DataStruct,
          isList: true,
        ),
        'responsibles': serializeParam(
          _responsibles,
          ParamType.String,
          isList: true,
        ),
        'responsibles_info': serializeParam(
          _responsiblesInfo,
          ParamType.String,
        ),
        'factory_number': serializeParam(
          _factoryNumber,
          ParamType.String,
        ),
        'inventory_number': serializeParam(
          _inventoryNumber,
          ParamType.String,
        ),
        'dispatch_number': serializeParam(
          _dispatchNumber,
          ParamType.String,
        ),
        'operating_time': serializeParam(
          _operatingTime,
          ParamType.String,
        ),
        'operational_date': serializeParam(
          _operationalDate,
          ParamType.String,
        ),
        'technical_parameters': serializeParam(
          _technicalParameters,
          ParamType.String,
          isList: true,
        ),
        'operational_parameters': serializeParam(
          _operationalParameters,
          ParamType.String,
          isList: true,
        ),
        'img': serializeParam(
          _img,
          ParamType.String,
        ),
        'parent': serializeParam(
          _parent,
          ParamType.String,
        ),
        'files': serializeParam(
          _files,
          ParamType.String,
          isList: true,
        ),
        'catalog_group': serializeParam(
          _catalogGroup,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'parent_info': serializeParam(
          _parentInfo,
          ParamType.String,
        ),
        'author': serializeParam(
          _author,
          ParamType.int,
        ),
        'number_scheme': serializeParam(
          _numberScheme,
          ParamType.String,
        ),
        'has_monitoring': serializeParam(
          _hasMonitoring,
          ParamType.bool,
        ),
        'productive_asset': serializeParam(
          _productiveAsset,
          ParamType.String,
        ),
        'productive_asset_info': serializeParam(
          _productiveAssetInfo,
          ParamType.String,
        ),
        'barcode': serializeParam(
          _barcode,
          ParamType.String,
        ),
        'area': serializeParam(
          _area,
          ParamType.int,
        ),
        'area_info': serializeParam(
          _areaInfo,
          ParamType.DataStruct,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'works': serializeParam(
          _works,
          ParamType.String,
          isList: true,
        ),
        'spare_parts': serializeParam(
          _spareParts,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static EquipmentStruct fromSerializableMap(Map<String, dynamic> data) =>
      EquipmentStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
        typeInfo: deserializeStructParam(
          data['type_info'],
          ParamType.DataStruct,
          false,
          structBuilder: TypeInfoStruct.fromSerializableMap,
        ),
        manufacturer: deserializeParam(
          data['manufacturer'],
          ParamType.int,
          false,
        ),
        manufacturerInfo: deserializeStructParam(
          data['manufacturer_info'],
          ParamType.DataStruct,
          false,
          structBuilder: ManufacturerInfoStruct.fromSerializableMap,
        ),
        model: deserializeParam(
          data['model'],
          ParamType.int,
          false,
        ),
        modelInfo: deserializeStructParam(
          data['model_info'],
          ParamType.DataStruct,
          false,
          structBuilder: ModelInfoStruct.fromSerializableMap,
        ),
        departments: deserializeParam<int>(
          data['departments'],
          ParamType.int,
          true,
        ),
        departmentsInfo: deserializeStructParam<DepartmentsInfoStruct>(
          data['departments_info'],
          ParamType.DataStruct,
          true,
          structBuilder: DepartmentsInfoStruct.fromSerializableMap,
        ),
        responsibles: deserializeParam<String>(
          data['responsibles'],
          ParamType.String,
          true,
        ),
        responsiblesInfo: deserializeParam(
          data['responsibles_info'],
          ParamType.String,
          false,
        ),
        factoryNumber: deserializeParam(
          data['factory_number'],
          ParamType.String,
          false,
        ),
        inventoryNumber: deserializeParam(
          data['inventory_number'],
          ParamType.String,
          false,
        ),
        dispatchNumber: deserializeParam(
          data['dispatch_number'],
          ParamType.String,
          false,
        ),
        operatingTime: deserializeParam(
          data['operating_time'],
          ParamType.String,
          false,
        ),
        operationalDate: deserializeParam(
          data['operational_date'],
          ParamType.String,
          false,
        ),
        technicalParameters: deserializeParam<String>(
          data['technical_parameters'],
          ParamType.String,
          true,
        ),
        operationalParameters: deserializeParam<String>(
          data['operational_parameters'],
          ParamType.String,
          true,
        ),
        img: deserializeParam(
          data['img'],
          ParamType.String,
          false,
        ),
        parent: deserializeParam(
          data['parent'],
          ParamType.String,
          false,
        ),
        files: deserializeParam<String>(
          data['files'],
          ParamType.String,
          true,
        ),
        catalogGroup: deserializeParam(
          data['catalog_group'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        parentInfo: deserializeParam(
          data['parent_info'],
          ParamType.String,
          false,
        ),
        author: deserializeParam(
          data['author'],
          ParamType.int,
          false,
        ),
        numberScheme: deserializeParam(
          data['number_scheme'],
          ParamType.String,
          false,
        ),
        hasMonitoring: deserializeParam(
          data['has_monitoring'],
          ParamType.bool,
          false,
        ),
        productiveAsset: deserializeParam(
          data['productive_asset'],
          ParamType.String,
          false,
        ),
        productiveAssetInfo: deserializeParam(
          data['productive_asset_info'],
          ParamType.String,
          false,
        ),
        barcode: deserializeParam(
          data['barcode'],
          ParamType.String,
          false,
        ),
        area: deserializeParam(
          data['area'],
          ParamType.int,
          false,
        ),
        areaInfo: deserializeStructParam(
          data['area_info'],
          ParamType.DataStruct,
          false,
          structBuilder: AreaInfoStruct.fromSerializableMap,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        works: deserializeParam<String>(
          data['works'],
          ParamType.String,
          true,
        ),
        spareParts: deserializeParam<String>(
          data['spare_parts'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'EquipmentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EquipmentStruct &&
        id == other.id &&
        type == other.type &&
        typeInfo == other.typeInfo &&
        manufacturer == other.manufacturer &&
        manufacturerInfo == other.manufacturerInfo &&
        model == other.model &&
        modelInfo == other.modelInfo &&
        listEquality.equals(departments, other.departments) &&
        listEquality.equals(departmentsInfo, other.departmentsInfo) &&
        listEquality.equals(responsibles, other.responsibles) &&
        responsiblesInfo == other.responsiblesInfo &&
        factoryNumber == other.factoryNumber &&
        inventoryNumber == other.inventoryNumber &&
        dispatchNumber == other.dispatchNumber &&
        operatingTime == other.operatingTime &&
        operationalDate == other.operationalDate &&
        listEquality.equals(technicalParameters, other.technicalParameters) &&
        listEquality.equals(
            operationalParameters, other.operationalParameters) &&
        img == other.img &&
        parent == other.parent &&
        listEquality.equals(files, other.files) &&
        catalogGroup == other.catalogGroup &&
        title == other.title &&
        parentInfo == other.parentInfo &&
        author == other.author &&
        numberScheme == other.numberScheme &&
        hasMonitoring == other.hasMonitoring &&
        productiveAsset == other.productiveAsset &&
        productiveAssetInfo == other.productiveAssetInfo &&
        barcode == other.barcode &&
        area == other.area &&
        areaInfo == other.areaInfo &&
        status == other.status &&
        listEquality.equals(works, other.works) &&
        listEquality.equals(spareParts, other.spareParts);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        type,
        typeInfo,
        manufacturer,
        manufacturerInfo,
        model,
        modelInfo,
        departments,
        departmentsInfo,
        responsibles,
        responsiblesInfo,
        factoryNumber,
        inventoryNumber,
        dispatchNumber,
        operatingTime,
        operationalDate,
        technicalParameters,
        operationalParameters,
        img,
        parent,
        files,
        catalogGroup,
        title,
        parentInfo,
        author,
        numberScheme,
        hasMonitoring,
        productiveAsset,
        productiveAssetInfo,
        barcode,
        area,
        areaInfo,
        status,
        works,
        spareParts
      ]);
}

EquipmentStruct createEquipmentStruct({
  int? id,
  int? type,
  TypeInfoStruct? typeInfo,
  int? manufacturer,
  ManufacturerInfoStruct? manufacturerInfo,
  int? model,
  ModelInfoStruct? modelInfo,
  dynamic? responsiblesInfo,
  String? factoryNumber,
  String? inventoryNumber,
  String? dispatchNumber,
  String? operatingTime,
  String? operationalDate,
  String? img,
  String? parent,
  String? catalogGroup,
  String? title,
  String? parentInfo,
  int? author,
  String? numberScheme,
  bool? hasMonitoring,
  String? productiveAsset,
  String? productiveAssetInfo,
  String? barcode,
  int? area,
  AreaInfoStruct? areaInfo,
  String? status,
}) =>
    EquipmentStruct(
      id: id,
      type: type,
      typeInfo: typeInfo ?? TypeInfoStruct(),
      manufacturer: manufacturer,
      manufacturerInfo: manufacturerInfo ?? ManufacturerInfoStruct(),
      model: model,
      modelInfo: modelInfo ?? ModelInfoStruct(),
      responsiblesInfo: responsiblesInfo,
      factoryNumber: factoryNumber,
      inventoryNumber: inventoryNumber,
      dispatchNumber: dispatchNumber,
      operatingTime: operatingTime,
      operationalDate: operationalDate,
      img: img,
      parent: parent,
      catalogGroup: catalogGroup,
      title: title,
      parentInfo: parentInfo,
      author: author,
      numberScheme: numberScheme,
      hasMonitoring: hasMonitoring,
      productiveAsset: productiveAsset,
      productiveAssetInfo: productiveAssetInfo,
      barcode: barcode,
      area: area,
      areaInfo: areaInfo ?? AreaInfoStruct(),
      status: status,
    );
