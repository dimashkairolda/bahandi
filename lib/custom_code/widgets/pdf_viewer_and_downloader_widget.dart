// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class PdfViewerAndDownloaderWidget extends StatefulWidget {
  final String apiUrl;
  final String fileName;
  final double width;
  final double height;
  final String accessToken; // Токен для авторизации

  const PdfViewerAndDownloaderWidget({
    super.key,
    required this.apiUrl,
    required this.fileName,
    required this.width,
    required this.height,
    required this.accessToken,
  });

  @override
  _PdfViewerAndDownloaderWidgetState createState() =>
      _PdfViewerAndDownloaderWidgetState();
}

class _PdfViewerAndDownloaderWidgetState
    extends State<PdfViewerAndDownloaderWidget> {
  File? _pdfFile;
  PdfControllerPinch? _pdfController;

  @override
  void initState() {
    super.initState();
    _downloadAndDisplayPdf();
  }

  Future<void> _downloadAndDisplayPdf() async {
    try {
      // Заголовки с токеном
      final headers = {
        'Authorization': 'JWT ${widget.accessToken}',
      };

      // Загрузка PDF из API
      final response = await http.get(
        Uri.parse(widget.apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Сохранение файла на устройство
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${widget.fileName}';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Установка файла и контроллера для PDF
        setState(() {
          _pdfFile = file;
          _pdfController = PdfControllerPinch(
            document: PdfDocument.openFile(file.path),
          );
        });

        // Уведомление пользователя о загрузке
      } else {
        throw Exception('Ошибка загрузки PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  Future<void> _downloadPdfToDownloads() async {
    try {
      // Заголовки с токеном
      final headers = {
        'Authorization': 'JWT ${widget.accessToken}',
      };

      // Загрузка PDF из API
      final response = await http.get(
        Uri.parse(widget.apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Получение директории "Downloads"
        final directory = Platform.isAndroid
            ? Directory(
                '/storage/emulated/0/Download') // Android: Папка "Загрузки"
            : (await getApplicationDocumentsDirectory());

        // Путь для сохранения файла
        final fileName = widget.fileName.endsWith('.pdf')
            ? widget.fileName
            : '${widget.fileName}.pdf'; // Убедимся, что файл имеет расширение .pdf
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);

        // Сохранение файла
        await file.writeAsBytes(response.bodyBytes);

        // Показ алерта после успешного скачивания
        _showDownloadCompleteAlert(
            'Файл $fileName успешно скачан в ${directory.path}');
      } else {
        throw Exception('Ошибка загрузки PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка: $e');
      _showDownloadCompleteAlert('Ошибка при скачивании файла.');
    }
  }

  void _showDownloadCompleteAlert(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Результат загрузки'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть алерт
              },
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Просмотр PDF',
          style: FlutterFlowTheme.of(context).titleMedium.override(
                fontFamily: 'SFProText',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadPdfToDownloads, // Скачивание в "Загрузки"
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ],
      ),
      body: SizedBox(
        width: widget.width,
        height: widget.height,
        child: _pdfController == null
            ? const Center(child: CircularProgressIndicator())
            : PdfViewPinch(controller: _pdfController!),
      ),
    );
  }
}
