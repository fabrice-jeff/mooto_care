import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatelessWidget {
  final Uint8List pdfData;

  PdfViewerScreen({required this.pdfData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visionneuse PDF'),
      ),
      body: PDFView(
        filePath: null,
        pdfData: pdfData,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onRender: (pages) {
          print("Nombre de pages: $pages");
        },
        onError: (error) {
          print(error.toString());
        },
      ),
    );
  }
}
