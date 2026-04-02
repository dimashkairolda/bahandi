import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'video_player_model.dart';
export 'video_player_model.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.url,
  });

  final String? url;

  static String routeName = 'videoPlayer';
  static String routePath = '/videoPlayer';

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoPlayerModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.chevron_left_sharp,
              color: Color(0xFF2A61ED),
              size: 30,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Вложение',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'SFProText',
                  color: Color(0xFF2A61ED),
                  fontSize: 16,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.isDownloading = true;
                  safeSetState(() {});
                  await actions.downloadVideoToGallery(
                    'https://app.etry.kz${widget!.url}',
                  );
                  _model.isDownloading = false;
                  safeSetState(() {});
                },
                child: Icon(
                  Icons.download_sharp,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 26,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowVideoPlayer(
                      path: 'https://app.etry.kz${widget!.url}',
                      videoType: VideoType.network,
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      autoPlay: true,
                      looping: false,
                      showControls: true,
                      allowFullScreen: false,
                      allowPlaybackSpeedMenu: false,
                      lazyLoad: true,
                      pauseOnNavigate: false,
                    ),
                  ],
                ),
              ),
              if (_model.isDownloading)
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: 
  Align( // Используем Align или Center, чтобы индикатор был посередине
    alignment: Alignment.center,
    child: Container(
      // Делаем квадратный контейнер
      width: 150.0, 
      height: 150.0,
      decoration: BoxDecoration(
        // Цвет фона берем из темы (чтобы работало и в темной теме)
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          // Красивая мягкая тень
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Вращающийся круг
          SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary, // Основной цвет приложения
              ),
              backgroundColor: FlutterFlowTheme.of(context).alternate, // Цвет трека
              strokeWidth: 4.0,
            ),
          ),
          const SizedBox(height: 16.0),
          // Текст загрузки
          Text(
            'Загрузка...',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'SFProText', // Твой шрифт
              color: FlutterFlowTheme.of(context).secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
