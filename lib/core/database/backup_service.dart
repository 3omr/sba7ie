import 'dart:io';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';
import 'package:tasneem_sba7ie/core/helper/file_manager_service.dart';

class BackupService {
  final Db database;
  final FileManagerService fileManager;

  BackupService(this.database) : fileManager = FileManagerService();

  //--------------- Backup Methods -------------------------

  /// إنشاء نسخة احتياطية من قاعدة البيانات
  Future<Map<String, dynamic>> createBackup() async {
    try {
      // استخراج بيانات جميع الجداول
      Map<String, dynamic> backupData = {};

      // نسخ احتياطي لجدول المعلمين
      List<Map> teachers = await database.readData('teachers');
      backupData['teachers'] = teachers.cast<Map<String, dynamic>>();

      // نسخ احتياطي لجدول الطلاب
      List<Map> students = await database.readData('students');
      backupData['students'] = students.cast<Map<String, dynamic>>();

      // نسخ احتياطي لجدول الاشتراكات
      List<Map> subscriptions = await database.readData('subscriptions');
      backupData['subscriptions'] = subscriptions.cast<Map<String, dynamic>>();

      // نسخ احتياطي لجدول الغياب
      List<Map> absences = await database.readData('absences');
      backupData['absences'] = absences.cast<Map<String, dynamic>>();

      // إضافة معلومات النسخة الاحتياطية
      backupData['backup_info'] = {
        'version': 2,
        'created_at': DateTime.now().toIso8601String(),
        'app_name': 'Tasneem Sba7ie',
        'tables_count': 4,
        'total_records': teachers.length +
            students.length +
            subscriptions.length +
            absences.length,
      };

      return {
        'success': true,
        'data': backupData,
        'message': 'تم إنشاء النسخة الاحتياطية بنجاح'
      };
    } catch (e) {
      return {
        'success': false,
        'data': null,
        'message': 'فشل في إنشاء النسخة الاحتياطية: $e'
      };
    }
  }

  /// حفظ النسخة الاحتياطية مع اختيار المستخدم للمكان
  Future<Map<String, dynamic>> saveBackupToFile({
    bool allowUserToChoosePath = true,
    String? customPath,
    SaveLocation? defaultLocation,
  }) async {
    try {
      // طلب الإذن للكتابة في التخزين
      if (!await _requestStoragePermission()) {
        return {'success': false, 'message': 'يجب منح إذن الوصول للتخزين'};
      }

      // إنشاء النسخة الاحتياطية
      Map<String, dynamic> backupResult = await createBackup();
      if (!backupResult['success']) {
        return backupResult;
      }

      // تحديد مسار الحفظ
      String? filePath = await _determineSavePath(
        allowUserToChoose: allowUserToChoosePath,
        customPath: customPath,
        defaultLocation: defaultLocation,
      );

      if (filePath == null) {
        return {'success': false, 'message': 'لم يتم اختيار مكان الحفظ'};
      }

      // تحويل البيانات إلى JSON
      String jsonData = jsonEncode(backupResult['data']);

      // التأكد من إمكانية الكتابة في المجلد
      String directoryPath = filePath.substring(0, filePath.lastIndexOf('/'));
      if (!await fileManager.canWriteToDirectory(directoryPath)) {
        return {
          'success': false,
          'message': 'لا يمكن الكتابة في المجلد المحدد'
        };
      }

      // حفظ الملف
      File backupFile = File(filePath);
      await backupFile.writeAsString(jsonData, encoding: utf8);

      return {
        'success': true,
        'message': 'تم حفظ النسخة الاحتياطية بنجاح',
        'file_path': filePath,
        'file_size': await backupFile.length(),
        'backup_info': backupResult['data']['backup_info'],
      };
    } catch (e) {
      return {'success': false, 'message': 'فشل في حفظ النسخة الاحتياطية: $e'};
    }
  }

  /// تحديد مسار الحفظ بناءً على اختيار المستخدم
  Future<String?> _determineSavePath({
    bool allowUserToChoose = true,
    String? customPath,
    SaveLocation? defaultLocation,
  }) async {
    // إذا تم تمرير مسار مخصص
    if (customPath != null) {
      return customPath;
    }

    // إذا كان يُسمح للمستخدم بالاختيار
    if (allowUserToChoose) {
      String? userChosenDirectory = await fileManager.pickSaveDirectory();
      if (userChosenDirectory != null) {
        String timestamp =
            DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
        String fileName = await fileManager.generateUniqueFileName(
          userChosenDirectory,
          'tasneem_backup_$timestamp.json',
        );
        return '$userChosenDirectory/$fileName';
      }
    }

    // استخدام المكان الافتراضي
    return await _getDefaultSavePath(defaultLocation ?? SaveLocation.downloads);
  }

  /// الحصول على المسار الافتراضي للحفظ
  Future<String> _getDefaultSavePath(SaveLocation location) async {
    Map<String, String> directories = await fileManager.getDefaultDirectories();
    String timestamp =
        DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];

    switch (location) {
      case SaveLocation.downloads:
        String downloadsPath = directories['downloads'] ??
            directories['external_storage'] ??
            directories['app_documents']!;
        await fileManager.createDirectoryIfNotExists(downloadsPath);
        return '$downloadsPath/tasneem_backup_$timestamp.json';

      case SaveLocation.documents:
        String documentsPath = directories['documents'] ??
            directories['external_storage'] ??
            directories['app_documents']!;
        await fileManager.createDirectoryIfNotExists(documentsPath);
        return '$documentsPath/tasneem_backup_$timestamp.json';

      case SaveLocation.appDirectory:
        String appPath = directories['app_documents']!;
        String backupDir = '$appPath/backups';
        await fileManager.createDirectoryIfNotExists(backupDir);
        return '$backupDir/tasneem_backup_$timestamp.json';

      case SaveLocation.externalStorage:
        String externalPath =
            directories['external_storage'] ?? directories['app_documents']!;
        String backupDir = '$externalPath/Tasneem_Backups';
        await fileManager.createDirectoryIfNotExists(backupDir);
        return '$backupDir/tasneem_backup_$timestamp.json';
    }
  }

  //--------------- Restore Methods -------------------------

  /// استعادة النسخة الاحتياطية من ملف
  Future<Map<String, dynamic>> restoreFromFile({String? filePath}) async {
    try {
      String? selectedPath = filePath;

      // إذا لم يتم تمرير مسار، فتح منتقي الملفات
      if (selectedPath == null) {
        selectedPath = await fileManager.pickBackupFile();
        if (selectedPath == null) {
          return {'success': false, 'message': 'لم يتم اختيار أي ملف'};
        }
      }

      // قراءة وتحليل الملف
      Map<String, dynamic> backupData = await _readBackupFile(selectedPath);

      // التحقق من صحة النسخة الاحتياطية
      Map<String, dynamic> validationResult = _validateBackupData(backupData);
      if (!validationResult['valid']) {
        return {'success': false, 'message': validationResult['message']};
      }

      // استعادة البيانات
      return await restoreBackupData(backupData);
    } catch (e) {
      return {
        'success': false,
        'message': 'فشل في استعادة النسخة الاحتياطية: $e'
      };
    }
  }

  /// استعادة بيانات النسخة الاحتياطية إلى قاعدة البيانات
  Future<Map<String, dynamic>> restoreBackupData(
    Map<String, dynamic> backupData, {
    bool clearExistingData = true,
  }) async {
    try {
      var db = await database.db;

      // بدء المعاملة (Transaction) لضمان سلامة البيانات
      await db!.transaction((txn) async {
        if (clearExistingData) {
          // مسح البيانات الحالية (مع احترام ترتيب Foreign Keys)
          await txn.delete('absences');
          await txn.delete('subscriptions');
          await txn.delete('students');
          await txn.delete('teachers');
        }

        // استعادة بيانات المعلمين أولاً
        if (backupData.containsKey('teachers')) {
          List<Map<String, dynamic>> teachers =
              List<Map<String, dynamic>>.from(backupData['teachers']);
          for (Map<String, dynamic> teacher in teachers) {
            await txn.insert('teachers', teacher);
          }
        }

        // استعادة بيانات الطلاب
        if (backupData.containsKey('students')) {
          List<Map<String, dynamic>> students =
              List<Map<String, dynamic>>.from(backupData['students']);
          for (Map<String, dynamic> student in students) {
            await txn.insert('students', student);
          }
        }

        // استعادة بيانات الاشتراكات
        if (backupData.containsKey('subscriptions')) {
          List<Map<String, dynamic>> subscriptions =
              List<Map<String, dynamic>>.from(backupData['subscriptions']);
          for (Map<String, dynamic> subscription in subscriptions) {
            await txn.insert('subscriptions', subscription);
          }
        }

        // استعادة بيانات الغياب
        if (backupData.containsKey('absences')) {
          List<Map<String, dynamic>> absences =
              List<Map<String, dynamic>>.from(backupData['absences']);
          for (Map<String, dynamic> absence in absences) {
            await txn.insert('absences', absence);
          }
        }
      });

      return {
        'success': true,
        'message': 'تم استعادة النسخة الاحتياطية بنجاح',
        'backup_info': backupData['backup_info'],
        'restored_records': _countRestoredRecords(backupData),
      };
    } catch (e) {
      return {'success': false, 'message': 'فشل في استعادة البيانات: $e'};
    }
  }

  //--------------- Auto Backup Methods -------------------------

  /// إنشاء نسخة احتياطية تلقائية
  Future<Map<String, dynamic>> createAutoBackup() async {
    try {
      // تنظيف النسخ القديمة أولاً
      await cleanOldAutoBackups(keepCount: 5);

      return await saveBackupToFile(
        allowUserToChoosePath: false,
        defaultLocation: SaveLocation.appDirectory,
      );
    } catch (e) {
      return {'success': false, 'message': 'فشل في إنشاء النسخة التلقائية: $e'};
    }
  }

  /// تنظيف النسخ الاحتياطية القديمة
  Future<void> cleanOldAutoBackups({int keepCount = 5}) async {
    try {
      Map<String, String> directories =
          await fileManager.getDefaultDirectories();
      String backupDir = '${directories['app_documents']}/backups';

      List<Map<String, dynamic>> backupFiles = await fileManager
          .getFilesInDirectory(backupDir, extensions: ['json']);

      // ترتيب الملفات حسب تاريخ التعديل (الأحدث أولاً)
      backupFiles.sort((a, b) =>
          (b['modified'] as DateTime).compareTo(a['modified'] as DateTime));

      // حذف الملفات الزائدة
      if (backupFiles.length > keepCount) {
        for (int i = keepCount; i < backupFiles.length; i++) {
          await fileManager.deleteFile(backupFiles[i]['path']);
        }
      }
    } catch (e) {
      print('خطأ في تنظيف النسخ القديمة: $e');
    }
  }

  //--------------- Information Methods -------------------------

  /// الحصول على معلومات النسخ الاحتياطية المتوفرة
  Future<List<Map<String, dynamic>>> getAvailableBackups({
    String? directoryPath,
  }) async {
    try {
      String backupDir = directoryPath ??
          '${(await fileManager.getDefaultDirectories())['app_documents']}/backups';

      List<Map<String, dynamic>> backupFiles = await fileManager
          .getFilesInDirectory(backupDir, extensions: ['json']);

      List<Map<String, dynamic>> backupInfo = [];

      for (Map<String, dynamic> fileInfo in backupFiles) {
        try {
          Map<String, dynamic> backupData =
              await _readBackupFile(fileInfo['path']);

          backupInfo.add({
            'file_path': fileInfo['path'],
            'file_name': fileInfo['name'],
            'file_size': fileInfo['size'],
            'created_at': fileInfo['modified'],
            'backup_info': backupData['backup_info'] ?? {},
            'formatted_size': fileManager.formatFileSize(fileInfo['size']),
          });
        } catch (e) {
          // تجاهل الملفات التالفة
          continue;
        }
      }

      return backupInfo;
    } catch (e) {
      return [];
    }
  }

  /// الحصول على إحصائيات قاعدة البيانات الحالية
  Future<Map<String, dynamic>> getDatabaseStats() async {
    try {
      List<Map> teachers = await database.readData('teachers');
      List<Map> students = await database.readData('students');
      List<Map> subscriptions = await database.readData('subscriptions');
      List<Map> absences = await database.readData('absences');

      return {
        'teachers_count': teachers.length,
        'students_count': students.length,
        'subscriptions_count': subscriptions.length,
        'absences_count': absences.length,
        'total_records': teachers.length +
            students.length +
            subscriptions.length +
            absences.length,
      };
    } catch (e) {
      return {'error': 'فشل في الحصول على إحصائيات قاعدة البيانات: $e'};
    }
  }

  /// الحصول على قائمة الأماكن المتاحة للحفظ
  Future<List<Map<String, dynamic>>> getAvailableSaveLocations() async {
    Map<String, String> directories = await fileManager.getDefaultDirectories();
    List<Map<String, dynamic>> locations = [];

    if (directories.containsKey('downloads')) {
      locations.add({
        'name': 'مجلد التنزيلات',
        'path': directories['downloads'],
        'location': SaveLocation.downloads,
        'icon': 'download',
      });
    }

    if (directories.containsKey('documents')) {
      locations.add({
        'name': 'مجلد المستندات',
        'path': directories['documents'],
        'location': SaveLocation.documents,
        'icon': 'folder',
      });
    }

    if (directories.containsKey('external_storage')) {
      locations.add({
        'name': 'التخزين الخارجي',
        'path': directories['external_storage'],
        'location': SaveLocation.externalStorage,
        'icon': 'storage',
      });
    }

    locations.add({
      'name': 'مجلد التطبيق',
      'path': directories['app_documents'],
      'location': SaveLocation.appDirectory,
      'icon': 'app',
    });

    return locations;
  }

  //--------------- Private Helper Methods -------------------------

  /// طلب إذن الوصول للتخزين - تم تحسينه
  Future<bool> _requestStoragePermission() async {
    try {
      // للأندرويد 13+ (API 33+) استخدام الصلاحيات الجديدة
      if (Platform.isAndroid) {
        var androidInfo = await _getAndroidVersion();

        if (androidInfo >= 33) {
          // Android 13+ permissions
          var photoStatus = await Permission.photos.request();
          var videoStatus = await Permission.videos.request();
          var audioStatus = await Permission.audio.request();

          return photoStatus.isGranted ||
              videoStatus.isGranted ||
              audioStatus.isGranted ||
              await Permission.manageExternalStorage.isGranted;
        } else {
          // Android 12 and below
          var status = await Permission.storage.request();
          if (status.isDenied) {
            status = await Permission.manageExternalStorage.request();
          }
          return status.isGranted;
        }
      } else if (Platform.isIOS) {
        var status = await Permission.photos.request();
        return status.isGranted;
      }

      return false;
    } catch (e) {
      print('خطأ في طلب الصلاحيات: $e');
      return false;
    }
  }

  /// الحصول على إصدار الأندرويد
  Future<int> _getAndroidVersion() async {
    try {
      var androidInfo = await _getDeviceInfo();
      return androidInfo;
    } catch (e) {
      return 30; // افتراضي للإصدارات القديمة
    }
  }

  /// معلومات الجهاز (يمكن استخدام device_info_plus package)
  Future<int> _getDeviceInfo() async {
    // يمكن استخدام device_info_plus package هنا
    // للبساطة نفترض API 30
    return 33; // افتراضي للاختبار
  }

  /// قراءة ملف النسخة الاحتياطية
  Future<Map<String, dynamic>> _readBackupFile(String filePath) async {
    File backupFile = File(filePath);

    if (!await backupFile.exists()) {
      throw Exception('الملف غير موجود');
    }

    String jsonData = await backupFile.readAsString(encoding: utf8);
    return jsonDecode(jsonData) as Map<String, dynamic>;
  }

  /// التحقق من صحة بيانات النسخة الاحتياطية
  Map<String, dynamic> _validateBackupData(Map<String, dynamic> backupData) {
    if (!backupData.containsKey('backup_info')) {
      return {
        'valid': false,
        'message':
            'ملف النسخة الاحتياطية غير صالح - لا يحتوي على معلومات النسخة'
      };
    }

    Map<String, dynamic> backupInfo = backupData['backup_info'];

    if (backupInfo['app_name'] != 'Tasneem Sba7ie') {
      return {
        'valid': false,
        'message': 'هذا الملف ليس من تطبيق تسنيم الصباحية'
      };
    }

    List<String> requiredTables = [
      'teachers',
      'students',
      'subscriptions',
      'absences'
    ];
    for (String table in requiredTables) {
      if (!backupData.containsKey(table)) {
        return {
          'valid': false,
          'message': 'النسخة الاحتياطية غير كاملة - مفقود جدول $table'
        };
      }
    }

    return {'valid': true, 'message': 'النسخة الاحتياطية صالحة'};
  }

  /// حساب عدد السجلات المستعادة
  Map<String, int> _countRestoredRecords(Map<String, dynamic> backupData) {
    return {
      'teachers': (backupData['teachers'] as List?)?.length ?? 0,
      'students': (backupData['students'] as List?)?.length ?? 0,
      'subscriptions': (backupData['subscriptions'] as List?)?.length ?? 0,
      'absences': (backupData['absences'] as List?)?.length ?? 0,
    };
  }

  //--------------- Utility Methods -------------------------

  /// تنسيق التاريخ
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// تعداد أماكن الحفظ المختلفة
enum SaveLocation {
  downloads, // مجلد التنزيلات
  documents, // مجلد المستندات
  appDirectory, // مجلد التطبيق
  externalStorage, // التخزين الخارجي
}
