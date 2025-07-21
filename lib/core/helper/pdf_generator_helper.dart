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
import 'package:tasneem_sba7ie/feature/reports/data/models/teacher_salary_report_model.dart';

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
                'المعلم: $teacherName',
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

  static Future<void> generateAllStudentPaymentsPDF(
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
    final paymentDateFormat = DateFormat('dd/MM/yyyy');

    // حساب إجمالي المدفوعات
    final totalPaid =
        payments.fold<int>(0, (sum, payment) => sum + payment.moneyPaid);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // العنوان الرئيسي
              pw.Center(
                child: pw.Text(
                  'تقرير جميع المدفوعات',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 10),

              // تاريخ التقرير
              pw.Center(
                child: pw.Text(
                  'تاريخ التقرير: ${dateFormat.format(DateTime.now())}',
                  style: pw.TextStyle(font: font, fontSize: 14),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 20),

              // معلومات إضافية
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'إجمالي عدد المدفوعات: ${payments.length}',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'إجمالي المبلغ: ${totalPaid} جنيه',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#10B981'), // لون أخضر
                    ),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ],
              ),
              pw.SizedBox(height: 15),

              // جدول البيانات
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FractionColumnWidth(0.25), // اسم الطالب
                  1: const pw.FractionColumnWidth(0.25), // اسم المدرس
                  2: const pw.FractionColumnWidth(0.2), // المبلغ
                  3: const pw.FractionColumnWidth(0.2), // التاريخ
                  4: const pw.FractionColumnWidth(0.1), // رقم الطالب
                },
                children: [
                  // رأس الجدول
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#2051E5'),
                    ),
                    children: [
                      _buildTableHeader('اسم الطالب', font),
                      _buildTableHeader('اسم المدرس', font),
                      _buildTableHeader('المبلغ (جنيه)', font),
                      _buildTableHeader('التاريخ', font),
                      _buildTableHeader('رقم الطالب', font),
                    ],
                  ),

                  // صفوف البيانات
                  ...payments.map((payment) {
                    return pw.TableRow(
                      children: [
                        _buildTableCell(payment.studentName, font),
                        _buildTableCell(payment.teacherName, font),
                        _buildTableCell(
                          payment.moneyPaid.toString(),
                          font,
                          color: PdfColor.fromHex('#10B981'), // لون أخضر للمبلغ
                          bold: true,
                        ),
                        _buildTableCell(
                            paymentDateFormat.format(payment.date), font),
                        _buildTableCell(payment.studentId.toString(), font),
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

    // حفظ ومشاركة الملف
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/all_student_payments_report.pdf');
    await file.writeAsBytes(await pdf.save());
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'تقرير_جميع_المدفوعات.pdf',
    );
  }

  /// Generate PDF report for all teachers salary in a specific month
  static Future<void> generateTeacherSalaryReportPDF(
    BuildContext context,
    List<TeacherSalaryReportModel> salaryReports,
    String monthYear,
  ) async {
    if (salaryReports.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'لا توجد تقارير رواتب لتصديرها',
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

    // Calculate totals
    final totalBaseSalary =
        salaryReports.fold<int>(0, (sum, report) => sum + report.salary);
    final totalNetSalary =
        salaryReports.fold<int>(0, (sum, report) => sum + report.netSalary);
    final totalDeductions =
        salaryReports.fold<int>(0, (sum, report) => sum + report.discounts);
    final totalAbsentDays =
        salaryReports.fold<int>(0, (sum, report) => sum + report.daysAbsent);
    final teachersWithDeductions =
        salaryReports.where((report) => report.hasDeductions).length;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // العنوان الرئيسي
              pw.Center(
                child: pw.Text(
                  'تقرير رواتب المدرسين',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 5),

              // شهر التقرير
              pw.Center(
                child: pw.Text(
                  'شهر: $monthYear',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#2051E5'),
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 5),

              // تاريخ التقرير
              pw.Center(
                child: pw.Text(
                  'تاريخ التقرير: ${dateFormat.format(DateTime.now())}',
                  style: pw.TextStyle(font: font, fontSize: 14),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: 20),

              // ملخص إحصائي
              _buildStatisticsSummary(
                font,
                salaryReports.length,
                totalBaseSalary,
                totalNetSalary,
                totalDeductions,
                totalAbsentDays,
                teachersWithDeductions,
              ),
              pw.SizedBox(height: 20),

              // جدول البيانات
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FractionColumnWidth(0.25), // اسم المدرس
                  1: const pw.FractionColumnWidth(0.15), // الراتب الأساسي
                  2: const pw.FractionColumnWidth(0.1), // أيام الغياب
                  3: const pw.FractionColumnWidth(0.15), // الخصومات
                  4: const pw.FractionColumnWidth(0.15), // صافي الراتب
                  5: const pw.FractionColumnWidth(0.2), // ملاحظات
                },
                children: [
                  // رأس الجدول
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#2051E5'),
                    ),
                    children: [
                      _buildTableHeader('اسم المدرس', font),
                      _buildTableHeader('الراتب الأساسي', font),
                      _buildTableHeader('أيام الغياب', font),
                      _buildTableHeader('خصومات إضافية', font),
                      _buildTableHeader('صافي الراتب', font),
                      _buildTableHeader('ملاحظات', font),
                    ],
                  ),

                  // صفوف البيانات
                  ...salaryReports.map((report) {
                    // ignore: unused_local_variable
                    final deductionAmount =
                        (report.daysAbsent * report.daySalary).toInt();
                    final notes = _getTeacherNotes(report);

                    return pw.TableRow(
                      children: [
                        _buildTableCell(report.teacherName, font),
                        _buildTableCell('${report.salary} جنيه', font),
                        _buildTableCell(
                          report.daysAbsent.toString(),
                          font,
                          color: report.daysAbsent > 0
                              ? PdfColor.fromHex('#F59E0B')
                              : null,
                          bold: report.daysAbsent > 0,
                        ),
                        _buildTableCell(
                          '${report.discounts} جنيه',
                          font,
                          color: report.discounts > 0
                              ? PdfColor.fromHex('#EF4444')
                              : null,
                          bold: report.discounts > 0,
                        ),
                        _buildTableCell(
                          '${report.netSalary} جنيه',
                          font,
                          color: report.netSalary < report.salary
                              ? PdfColor.fromHex('#EF4444')
                              : PdfColor.fromHex('#10B981'),
                          bold: true,
                        ),
                        _buildTableCell(notes, font),
                      ],
                    );
                  }).toList(),

                  // صف الإجمالي
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#F3F4F6'),
                    ),
                    children: [
                      _buildTableCell(
                        'الإجمالي',
                        font,
                        bold: true,
                        color: PdfColor.fromHex('#374151'),
                      ),
                      _buildTableCell(
                        '$totalBaseSalary جنيه',
                        font,
                        bold: true,
                        color: PdfColor.fromHex('#2563EB'),
                      ),
                      _buildTableCell(
                        totalAbsentDays.toString(),
                        font,
                        bold: true,
                        color: totalAbsentDays > 0
                            ? PdfColor.fromHex('#F59E0B')
                            : null,
                      ),
                      _buildTableCell(
                        '$totalDeductions جنيه',
                        font,
                        bold: true,
                        color: totalDeductions > 0
                            ? PdfColor.fromHex('#EF4444')
                            : null,
                      ),
                      _buildTableCell(
                        '$totalNetSalary جنيه',
                        font,
                        bold: true,
                        color: PdfColor.fromHex('#10B981'),
                      ),
                      _buildTableCell('', font),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // حفظ ومشاركة الملف
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/teacher_salary_report_$monthYear.pdf');
    await file.writeAsBytes(await pdf.save());
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'تقرير_رواتب_المدرسين_$monthYear.pdf',
    );
  }

  static String _getTeacherNotes(TeacherSalaryReportModel report) {
    if (!report.hasDeductions) return 'لا توجد خصومات';

    List<String> notes = [];
    if (report.daysAbsent > 0) notes.add('غياب ${report.daysAbsent} أيام');
    if (report.discounts > 0) notes.add('خصم ${report.discounts} جنيه');

    return notes.join(' - ');
  }

  static pw.Widget _buildStatisticsSummary(
    pw.Font font,
    int totalTeachers,
    int totalBaseSalary,
    int totalNetSalary,
    int totalDeductions,
    int totalAbsentDays,
    int teachersWithDeductions,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#F0F9FF'),
        border: pw.Border.all(color: PdfColor.fromHex('#0EA5E9')),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'ملخص إحصائي',
            style: pw.TextStyle(
              font: font,
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('عدد المدرسين', totalTeachers.toString(), font),
              _buildStatItem('إجمالي الرواتب', '$totalBaseSalary جنيه', font),
              _buildStatItem('إجمالي الصافي', '$totalNetSalary جنيه', font),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('إجمالي الخصومات', '$totalDeductions جنيه', font),
              _buildStatItem(
                  'إجمالي أيام الغياب', totalAbsentDays.toString(), font),
              _buildStatItem(
                  'مدرسين بخصومات', teachersWithDeductions.toString(), font),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildStatItem(String title, String value, pw.Font font) {
    return pw.Column(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(font: font, fontSize: 10),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: font,
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeader(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: font,
          fontWeight: pw.FontWeight.bold,
          color: PdfColor.fromHex('#FFFFFF'),
          fontSize: 12,
        ),
        textDirection: pw.TextDirection.rtl,
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildTableCell(
    String text,
    pw.Font font, {
    PdfColor? color,
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: font,
          color: color ?? PdfColors.black,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: 10,
        ),
        textDirection: pw.TextDirection.rtl,
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}
