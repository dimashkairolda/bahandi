import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shkala1_model.dart';
export 'shkala1_model.dart';

class Shkala1Widget extends StatefulWidget {
  const Shkala1Widget({
    super.key,
    required this.data,
    required this.searchID,
    required this.equipmentId,
    required this.name,
    required this.index,
    required this.nextIndex,
  });

  final dynamic data;
  final int? searchID;
  final int? equipmentId;
  final dynamic name;
  final int? index;
  final int? nextIndex;

  @override
  State<Shkala1Widget> createState() => _Shkala1WidgetState();
}

class _Shkala1WidgetState extends State<Shkala1Widget> {
  late Shkala1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Shkala1Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.99,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(11.0, 11.0, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getJsonField(
                  widget.data,
                  r'''$.data.title''',
                ).toString(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: Slider(
                      activeColor: FlutterFlowTheme.of(context).primary,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      min: 0.0,
                      max: 10.0,
                      value: _model.sliderValue ??= getJsonField(
                                widget.data,
                                r'''$.result.response''',
                              ) ==
                              null
                          ? 0.0
                          : getJsonField(
                              widget.data,
                              r'''$.result.response''',
                            ),
                      label: _model.sliderValue?.toStringAsFixed(0),
                      onChanged: (newValue) async {
                        newValue = double.parse(newValue.toStringAsFixed(0));
                        safeSetState(() => _model.sliderValue = newValue);
                        await actions.updateResponseByIdShkala(
                          FFAppState().checkCache,
                          widget.equipmentId!,
                          getJsonField(
                            widget.data,
                            r'''$.data.title''',
                          ).toString(),
                          _model.sliderValue!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
