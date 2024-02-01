import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'datas/models/deamende_attestaion.dart';

Future<Uint8List> generatePDF(
  DemandeAttestation demandeAttestation,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat(250, 200, marginAll: 3),
      build: (context) {
        return pw.Center(
          child: pw.Container(
            width: 250,
            height: 200,
            padding: pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
              borderRadius: pw.BorderRadius.circular(5),
            ),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  // decoration: pw.BoxDecoration(
                  //   border: pw.Border.all(),
                  // ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.SizedBox(height: 10),
                            pw.Text(
                              demandeAttestation.bien.acteur.prenoms +
                                  " " +
                                  demandeAttestation.bien.acteur.nom,
                              style: pw.TextStyle(
                                color: PdfColor.fromHex("#000000"),
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              "Perdu le " +
                                  DateFormat("dd/MM/yyyy")
                                      .format(demandeAttestation.datePerte),
                              style: pw.TextStyle(
                                color: PdfColor.fromHex("#000000"),
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              "Numéro plaque : " +
                                  demandeAttestation.bien.numPlaque,
                              style: pw.TextStyle(
                                color: PdfColor.fromHex("#000000"),
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.BarcodeWidget(
                        textStyle: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                        ),
                        data: "Fabrice",
                        drawText: false,
                        barcode: pw.Barcode.qrCode(),
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Text(
                  'Fait le ' +
                      DateFormat("dd/MM/yyyy")
                          .format(demandeAttestation.createdAt),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return pdf.save();
}

pw.Widget _row(String label, String value) {
  return pw.Row(children: [
    pw.Text(
      label,
      style: pw.TextStyle(
        color: PdfColor.fromHex("#000000"),
        fontWeight: pw.FontWeight.bold,
      ),
    ),
    pw.SizedBox(height: 10),
    pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex("#000000"),
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  ]);
}
