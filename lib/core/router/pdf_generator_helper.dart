import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';

class PDFGeneratorHelper {
  static Future<void> generateStudentsByTeacherPDF(
    BuildContext context,
    String teacherName,
    List<StudentReport> students,
  ) async {
    if (students.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'لا يوجد بيانات لتقرير الطلبة حسب المعلم',
            style: TextManagement.alexandria16RegularWhite,
          ),
          backgroundColor: ColorManagement.accentOrange,
        ),
      );
      return;
    }

    final pdf = pw.Document();
    final font = await PdfGoogleFonts.amiriRegular();
    final dateFormat = DateFormat('dd MMMM yyyy', 'ar');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'تقرير الطلبة حسب المعلم',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'تاريخ التقرير: ${dateFormat.format(DateTime.now())}',
                  style: pw.TextStyle(font: font, fontSize: 14),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'المعلم: ${teacherName}',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
                textDirection: pw.TextDirection.rtl,
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FractionColumnWidth(0.4),
                  1: const pw.FractionColumnWidth(0.2),
                  2: const pw.FractionColumnWidth(0.2),
                  3: const pw.FractionColumnWidth(0.2),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#2051E5'),
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'اسم الطالب',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'الاشتراك (جنيه)',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'المدفوع (جنيه)',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'المتبقي (جنيه)',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  ...students.map((student) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            student.name,
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            student.subscription.toString(),
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            student.totalPaid.toString(),
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            student.remaining.toString(),
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/student_report.pdf');
    await file.writeAsBytes(await pdf.save());
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'student_report.pdf',
    );
  }

  static Future<void> generateStudentPaymentsPDF(
    BuildContext context,
    List<StudentPayment> payments,
  ) async {
    if (payments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'لا توجد مدفوعات لتصديرها',
            style: TextManagement.alexandria16RegularWhite,
          ),
          backgroundColor: ColorManagement.accentOrange,
        ),
      );
      return;
    }

    final pdf = pw.Document();
    final font = await PdfGoogleFonts.amiriRegular();
    final dateFormat = DateFormat('dd MMMM yyyy', 'ar');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'تقرير مدفوعات الطالب',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'تاريخ التقرير: ${dateFormat.format(DateTime.now())}',
                  style: pw.TextStyle(font: font, fontSize: 14),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'الطالب: ${payments.first.studentName}',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
                textDirection: pw.TextDirection.rtl,
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FractionColumnWidth(0.3),
                  1: const pw.FractionColumnWidth(0.3),
                  2: const pw.FractionColumnWidth(0.2),
                  3: const pw.FractionColumnWidth(0.2),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#2051E5'),
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'اسم الطالب',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'اسم المعلم',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'المدفوع (جنيه)',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'التاريخ',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  ...payments.map((payment) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            payment.studentName,
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            payment.teacherName,
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            payment.moneyPaid.toString(),
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            dateFormat.format(payment.date),
                            style: pw.TextStyle(font: font),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/student_payments_report.pdf');
    await file.writeAsBytes(await pdf.save());
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'student_payments_report.pdf',
    );
  }
}