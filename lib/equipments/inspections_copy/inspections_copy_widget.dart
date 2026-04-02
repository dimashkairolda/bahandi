import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'inspections_copy_model.dart';
export 'inspections_copy_model.dart';

class InspectionsCopyWidget extends StatefulWidget {
  const InspectionsCopyWidget({super.key});

  static String routeName = 'InspectionsCopy';
  static String routePath = '/inspectionsCopy';

  @override
  State<InspectionsCopyWidget> createState() => _InspectionsCopyWidgetState();
}

class _InspectionsCopyWidgetState extends State<InspectionsCopyWidget> {
  late InspectionsCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InspectionsCopyModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Builder(
              builder: (context) {
                final respnses = getJsonField(
                  FFAppState().checkCache,
                  r'''$.responses[0].form_result''',
                ).toList();

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(respnses.length, (respnsesIndex) {
                      final respnsesItem = respnses[respnsesIndex];
                      return Text(
                        getJsonField(
                          respnsesItem,
                          r'''$.result''',
                        ).toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.readexPro(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      );
                    }).divide(SizedBox(height: 50)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
