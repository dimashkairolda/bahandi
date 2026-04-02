import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'iz_spiska_show_model.dart';
export 'iz_spiska_show_model.dart';

class IzSpiskaShowWidget extends StatefulWidget {
  const IzSpiskaShowWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final dynamic data;
  final int? index;

  @override
  State<IzSpiskaShowWidget> createState() => _IzSpiskaShowWidgetState();
}

class _IzSpiskaShowWidgetState extends State<IzSpiskaShowWidget> {
  late IzSpiskaShowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IzSpiskaShowModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.99,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(11, 11, 10, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getJsonField(
                  widget!.data,
                  r'''$.data.title''',
                ).toString(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 14,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Builder(
                builder: (context) {
                  final radios = getJsonField(
                    widget!.data,
                    r'''$.data.radios[:]''',
                  ).toList();

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(radios.length, (radiosIndex) {
                      final radiosItem = radios[radiosIndex];
                      return Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: MediaQuery.sizeOf(context).height * 0.06,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            (getJsonField(
                                          widget!.data,
                                          r'''$.result.response''',
                                        ) !=
                                        null) &&
                                    (valueOrDefault<int>(
                                          functions.stringToInt(getJsonField(
                                            widget!.data,
                                            r'''$.result.response''',
                                          ).toString()),
                                          0,
                                        ) ==
                                        radiosIndex)
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                            FlutterFlowTheme.of(context).secondaryBackground,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            width: 0.3,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if ((getJsonField(
                                      widget!.data,
                                      r'''$.result.response''',
                                    ) !=
                                    null) &&
                                (valueOrDefault<int>(
                                      functions.stringToInt(getJsonField(
                                        widget!.data,
                                        r'''$.result.response''',
                                      ).toString()),
                                      0,
                                    ) ==
                                    radiosIndex))
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.02,
                                height: MediaQuery.sizeOf(context).width * 0.02,
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
                              .divide(SizedBox(width: 10))
                              .addToStart(SizedBox(width: 15)),
                        ),
                      );
                    }).divide(SizedBox(height: 5)),
                  );
                },
              ),
            ].divide(SizedBox(height: 10)),
          ),
        ),
      ),
    );
  }
}
