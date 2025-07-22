import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/database/backup_service.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';

class BackupPage extends StatefulWidget {
  final BackupService backupService;

  const BackupPage({Key? key, required this.backupService}) : super(key: key);

  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _availableLocations = [];
  List<Map<String, dynamic>> _availableBackups = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableLocations();
    _loadAvailableBackups();
  }

  Future<void> _loadAvailableLocations() async {
    try {
      List<Map<String, dynamic>> locations =
          await widget.backupService.getAvailableSaveLocations();
      setState(() {
        _availableLocations = locations;
      });
    } catch (e) {
      _showErrorMessage('خطأ في تحميل أماكن الحفظ: $e');
    }
  }

  Future<void> _loadAvailableBackups() async {
    try {
      List<Map<String, dynamic>> backups =
          await widget.backupService.getAvailableBackups();
      setState(() {
        _availableBackups = backups;
      });
    } catch (e) {
      _showErrorMessage('خطأ في تحميل النسخ الاحتياطية: $e');
    }
  }

  Future<void> _createBackupWithUserChoice() async {
    setState(() => _isLoading = true);
    try {
      Map<String, dynamic> result = await widget.backupService.saveBackupToFile(
        allowUserToChoosePath: true,
      );
      if (result['success']) {
        _showSuccessMessage('تم إنشاء النسخة الاحتياطية بنجاح\n'
            'الملف: ${result['file_path']}\n'
            'الحجم: ${widget.backupService.fileManager.formatFileSize(result['file_size'])}');
        await _loadAvailableBackups();
      } else {
        _showErrorMessage(result['message']);
      }
    } catch (e) {
      _showErrorMessage('خطأ في إنشاء النسخة الاحتياطية: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createBackupAtLocation(SaveLocation location) async {
    setState(() => _isLoading = true);
    try {
      Map<String, dynamic> result = await widget.backupService.saveBackupToFile(
        allowUserToChoosePath: false,
        defaultLocation: location,
      );
      if (result['success']) {
        _showSuccessMessage('تم إنشاء النسخة الاحتياطية بنجاح\n'
            'الملف: ${result['file_path']}\n'
            'الحجم: ${widget.backupService.fileManager.formatFileSize(result['file_size'])}');
        await _loadAvailableBackups();
      } else {
        _showErrorMessage(result['message']);
      }
    } catch (e) {
      _showErrorMessage('خطأ في إنشاء النسخة الاحتياطية: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _restoreBackup({String? filePath}) async {
    bool? confirmed = await _showConfirmationDialog(
      'تأكيد الاستعادة',
      'هل أنت متأكد من استعادة النسخة الاحتياطية؟\nسيتم مسح جميع البيانات الحالية.',
    );
    if (confirmed != true) return;

    setState(() => _isLoading = true);
    try {
      Map<String, dynamic> result = await widget.backupService.restoreFromFile(
        filePath: filePath,
      );
      if (result['success']) {
        Map<String, int> restoredRecords = result['restored_records'];
        _showSuccessMessage('تم استعادة النسخة الاحتياطية بنجاح\n'
            'المعلمون: ${restoredRecords['teachers']}\n'
            'الطلاب: ${restoredRecords['students']}\n'
            'الاشتراكات: ${restoredRecords['subscriptions']}\n'
            'الغياب: ${restoredRecords['absences']}');
      } else {
        _showErrorMessage(result['message']);
      }
    } catch (e) {
      _showErrorMessage('خطأ في استعادة النسخة الاحتياطية: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createAutoBackup() async {
    setState(() => _isLoading = true);
    try {
      Map<String, dynamic> result =
          await widget.backupService.createAutoBackup();
      if (result['success']) {
        _showSuccessMessage('تم إنشاء النسخة التلقائية بنجاح');
        await _loadAvailableBackups();
      } else {
        _showErrorMessage(result['message']);
      }
    } catch (e) {
      _showErrorMessage('خطأ في إنشاء النسخة التلقائية: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'النسخ الاحتياطية',
          style: TextManagement.alexandria18RegularBlack,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Create Backup Section
                  _buildSectionTitle('إنشاء نسخة احتياطية'),
                  SizedBox(height: 0.02.sh),
                  ContainerShadow(
                    child: ElevatedButton.icon(
                      onPressed: _createBackupWithUserChoice,
                      icon: Icon(Icons.folder_open, size: 20.sp),
                      label: Text(
                        'اختيار مكان الحفظ',
                        style: TextManagement.alexandria16RegularWhite,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.02.sh),
                  ContainerShadow(
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Text(
                        'أو اختر مكان افتراضي:',
                        style: TextManagement.alexandria16RegularBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01.sh),
                  ..._availableLocations.map(
                    (location) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: ContainerShadow(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              _createBackupAtLocation(location['location']),
                          icon: _getLocationIcon(location['icon']),
                          label: Text(
                            location['name'],
                            style: TextManagement.alexandria16RegularWhite,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity, 45.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 0.03.sh),

                  // Restore Backup Section
                  _buildSectionTitle('استعادة نسخة احتياطية'),
                  SizedBox(height: 0.02.sh),
                  ContainerShadow(
                    child: ElevatedButton.icon(
                      onPressed: () => _restoreBackup(),
                      icon: Icon(Icons.upload_file, size: 20.sp),
                      label: Text(
                        'اختيار ملف للاستعادة',
                        style: TextManagement.alexandria16RegularWhite,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 0.03.sh),

                  // Available Backups Section
                  _buildSectionTitle('النسخ الاحتياطية المتاحة'),
                  SizedBox(height: 0.02.sh),
                  if (_availableBackups.isEmpty)
                    ContainerShadow(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Text(
                          'لا توجد نسخ احتياطية متاحة',
                          style: TextManagement.alexandria16RegularBlack,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    ..._availableBackups.map(
                      (backup) => ContainerShadow(
                        child: ListTile(
                          leading: Icon(Icons.backup,
                              color: Colors.blue, size: 24.sp),
                          title: Text(
                            backup['file_name'],
                            style: TextManagement.alexandria16RegularBlack,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الحجم: ${backup['formatted_size']}',
                                style: TextManagement.alexandria14RegularBlack,
                              ),
                              Text(
                                'التاريخ: ${widget.backupService.formatDate(backup['created_at'])}',
                                style: TextManagement.alexandria14RegularBlack,
                              ),
                              if (backup['backup_info']['total_records'] !=
                                  null)
                                Text(
                                  'عدد السجلات: ${backup['backup_info']['total_records']}',
                                  style:
                                      TextManagement.alexandria14RegularBlack,
                                ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'restore') {
                                _restoreBackup(filePath: backup['file_path']);
                              } else if (value == 'delete') {
                                _deleteBackup(backup);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'restore',
                                child: Row(
                                  children: [
                                    Icon(Icons.restore,
                                        color: Colors.green, size: 20.sp),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'استعادة',
                                      style: TextManagement
                                          .alexandria16RegularBlack,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete,
                                        color: Colors.red, size: 20.sp),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'حذف',
                                      style: TextManagement
                                          .alexandria16RegularBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    ),

                  SizedBox(height: 0.03.sh),

                  // Additional Tools Section
                  _buildSectionTitle('أدوات إضافية'),
                  SizedBox(height: 0.02.sh),
                  ContainerShadow(
                    child: ElevatedButton.icon(
                      onPressed: _createAutoBackup,
                      icon: Icon(Icons.schedule, size: 20.sp),
                      label: Text(
                        'إنشاء نسخة تلقائية',
                        style: TextManagement.alexandria16RegularWhite,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        minimumSize: Size(double.infinity, 45.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01.sh),
                  ContainerShadow(
                    child: ElevatedButton.icon(
                      onPressed: _showDatabaseStats,
                      icon: Icon(Icons.analytics, size: 20.sp),
                      label: Text(
                        'إحصائيات قاعدة البيانات',
                        style: TextManagement.alexandria16RegularWhite,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        minimumSize: Size(double.infinity, 45.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextManagement.alexandria18RegularBlack,
    );
  }

  Icon _getLocationIcon(String iconName) {
    switch (iconName) {
      case 'download':
        return Icon(Icons.download, size: 20.sp);
      case 'folder':
        return Icon(Icons.folder, size: 20.sp);
      case 'storage':
        return Icon(Icons.storage, size: 20.sp);
      case 'app':
        return Icon(Icons.apps, size: 20.sp);
      default:
        return Icon(Icons.folder, size: 20.sp);
    }
  }

  Future<void> _deleteBackup(Map<String, dynamic> backup) async {
    bool? confirmed = await _showConfirmationDialog(
      'تأكيد الحذف',
      'هل أنت متأكد من حذف هذه النسخة الاحتياطية؟',
    );
    if (confirmed == true) {
      bool deleted = await widget.backupService.fileManager
          .deleteFile(backup['file_path']);
      if (deleted) {
        _showSuccessMessage('تم حذف النسخة الاحتياطية بنجاح');
        await _loadAvailableBackups();
      } else {
        _showErrorMessage('فشل في حذف النسخة الاحتياطية');
      }
    }
  }

  Future<void> _showDatabaseStats() async {
    Map<String, dynamic> stats = await widget.backupService.getDatabaseStats();
    if (stats.containsKey('error')) {
      _showErrorMessage(stats['error']);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'إحصائيات قاعدة البيانات',
          style: TextManagement.alexandria18RegularBlack,
        ),
        content: ContainerShadow(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('المعلمون: ${stats['teachers_count']}',
                    style: TextManagement.alexandria16RegularBlack),
                Text('الطلاب: ${stats['students_count']}',
                    style: TextManagement.alexandria16RegularBlack),
                Text('الاشتراكات: ${stats['subscriptions_count']}',
                    style: TextManagement.alexandria16RegularBlack),
                Text('الغياب: ${stats['absences_count']}',
                    style: TextManagement.alexandria16RegularBlack),
                Divider(height: 20.h),
                Text('إجمالي السجلات: ${stats['total_records']}',
                    style: TextManagement.alexandria16RegularBlack),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                Text('إغلاق', style: TextManagement.alexandria16RegularBlack),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(String title, String content) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextManagement.alexandria18RegularBlack),
        content: ContainerShadow(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child:
                Text(content, style: TextManagement.alexandria16RegularBlack),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:
                Text('إلغاء', style: TextManagement.alexandria16RegularBlack),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child:
                Text('تأكيد', style: TextManagement.alexandria16RegularWhite),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message) {
    AppSnackBars.showSuccessSnackBar(context: context, successMsg: message);
  }

  void _showErrorMessage(String message) {
    AppSnackBars.showErrorSnackBar(context: context, errorMsg: message);
  }
}
