import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/change_equipment_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'barcode_model.dart';
export 'barcode_model.dart';

class BarcodeWidget extends StatefulWidget {
  const BarcodeWidget({super.key});

  static String routeName = 'barcode';
  static String routePath = '/barcode';

  @override
  State<BarcodeWidget> createState() => _BarcodeWidgetState();
}

class _BarcodeWidgetState extends State<BarcodeWidget> {
  late BarcodeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BarcodeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.aa = await FlutterBarcodeScanner.scanBarcode(
        '#C62828', // scanning line color
        '', // cancel button text
        true, // whether to show the flash icon
        ScanMode.BARCODE,
      );

      if (_model.aa != '-1') {
        _model.qq = await GetEquipmentsBarcodeCall.call(
          access: currentAuthenticationToken,
          barcode: _model.aa,
        );

        if (functions.emptyList(getJsonField(
          (_model.qq?.jsonBody ?? ''),
          r'''$.data''',
          true,
        ))!) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ошибка! Оборудование не найдено.',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: Duration(milliseconds: 2000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
          var confirmDialogResponse = await showDialog<bool>(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('Добавить новое оборудование'),
                    content: Text(
                        'Этого оборудования нет в системе. Хотите ли вы его добавить?'),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(alertDialogContext, false),
                        child: Text('Отменить'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(alertDialogContext, true),
                        child: Text('Добавить'),
                      ),
                    ],
                  );
                },
              ) ??
              false;
          if (confirmDialogResponse) {
            context.pushNamed(
              CreateEquipmentWidget.routeName,
              queryParameters: {
                'barcode': serializeParam(
                  _model.aa,
                  ParamType.String,
                ),
              }.withoutNulls,
            );
          }
        } else {
          if ((functions
                      .jsonToList(getJsonField(
                        FFAppState().Area,
                        r'''$.data''',
                      ))
                      .length ==
                  1) &&
              (getJsonField(
                    (_model.qq?.jsonBody ?? ''),
                    r'''$.data[0].area''',
                  ) !=
                  getJsonField(
                    FFAppState().Area,
                    r'''$.data[0].id''',
                  ))) {
            var confirmDialogResponse = await showDialog<bool>(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text('Неправильный филиал'),
                      content: Text(
                          'Филиал, к которому прикреплено оборудование, не совпадает с вашим. Переместить оборудование?'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(alertDialogContext, false),
                          child: Text('Отменить'),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(alertDialogContext, true),
                          child: Text('Переместить'),
                        ),
                      ],
                    );
                  },
                ) ??
                false;
            if (confirmDialogResponse) {
              await showDialog(
                context: context,
                builder: (dialogContext) {
                  return Dialog(
                    elevation: 0,
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    alignment: AlignmentDirectional(0.0, 1.0)
                        .resolve(Directionality.of(context)),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(dialogContext).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.65,
                        child: ChangeEquipmentWidget(
                          id: getJsonField(
                            (_model.qq?.jsonBody ?? ''),
                            r'''$.data[0].id''',
                          ),
                          json: getJsonField(
                            (_model.qq?.jsonBody ?? ''),
                            r'''$.data[0]''',
                          ),
                          barcode: _model.aa,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            context.pushNamed(
              EquipmentsDetailedWidget.routeName,
              queryParameters: {
                'json': serializeParam(
                  getJsonField(
                    (_model.qq?.jsonBody ?? ''),
                    r'''$.data[0]''',
                  ),
                  ParamType.JSON,
                ),
                'id': serializeParam(
                  getJsonField(
                    (_model.qq?.jsonBody ?? ''),
                    r'''$.data[0].id''',
                  ),
                  ParamType.int,
                ),
              }.withoutNulls,
            );
          }
        }
      } else {
        context.goNamed(DefectsWidget.routeName);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
