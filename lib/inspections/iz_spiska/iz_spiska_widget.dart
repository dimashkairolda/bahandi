import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'iz_spiska_model.dart';
export 'iz_spiska_model.dart';

class IzSpiskaWidget extends StatefulWidget {
  const IzSpiskaWidget({
    super.key,
    required this.data,
    required this.index,
    required this.old,
  });

  final dynamic data;
  final int? index;
  final bool? old;

  @override
  State<IzSpiskaWidget> createState() => _IzSpiskaWidgetState();
}

class _IzSpiskaWidgetState extends State<IzSpiskaWidget> {
  late IzSpiskaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IzSpiskaModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Builder(
                builder: (context) {
                  final radios = getJsonField(
                    widget.data,
                    r'''$.data.radios[:]''',
                  ).toList();

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(radios.length, (radiosIndex) {
                      final radiosItem = radios[radiosIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().updateFormresult1AtIndex(
                            widget.index!,
                            (e) => e
                              ..updateResult(
                                (e) => e
                                  ..response = functions.findIndexByText(
                                      getJsonField(
                                        widget.data,
                                        r'''$.data.radios[:]''',
                                        true,
                                      )!,
                                      getJsonField(
                                        radiosItem,
                                        r'''$.text''',
                                      ).toString())
                                  ..comment = null
                                  ..image = null,
                              ),
                          );
                          FFAppState().update(() {});
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              (getJsonField(
                                            widget.data,
                                            r'''$.result.response''',
                                          ) !=
                                          null) &&
                                      (valueOrDefault<int>(
                                            functions.stringToInt(getJsonField(
                                              widget.data,
                                              r'''$.result.response''',
                                            ).toString()),
                                            0,
                                          ) ==
                                          radiosIndex)
                                  ? FlutterFlowTheme.of(context)
                                      .primaryBackground
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 0.3,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ((getJsonField(
                                        widget.data,
                                        r'''$.result.response''',
                                      ) !=
                                      null) &&
                                  (valueOrDefault<int>(
                                        functions.stringToInt(getJsonField(
                                          widget.data,
                                          r'''$.result.response''',
                                        ).toString()),
                                        0,
                                      ) ==
                                      radiosIndex))
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.02,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.02,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              Text(
                                getJsonField(
                                  radiosItem,
                                  r'''$.text''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ]
                                .divide(SizedBox(width: 10.0))
                                .addToStart(SizedBox(width: 15.0)),
                          ),
                        ),
                      );
                    }).divide(SizedBox(height: 5.0)),
                  );
                },
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
