import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileManagerService {
  /// اختيار مجلد لحفظ الملفات
  Future<String?> pickSaveDirectory() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      return selectedDirectory;
    } catch (e) {
      print('خطأ في اختيار المجلد: $e');
      return null;
    }
  }

  /// اختيار ملف للاستعادة
  Future<String?> pickBackupFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      );

      if (result == null || result.files.single.path == null) {
        return null;
      }

      String selectedPath = result.files.single.path!;
      
      // التحقق من امتداد الملف
      if (!selectedPath.toLowerCase().endsWith('.json')) {
        throw Exception('يجب اختيار ملف بصيغة JSON');
      }

      return selectedPath;
    } catch (e) {
      print('خطأ في اختيار الملف: $e');
      rethrow;
    }
  }

  /// اختيار عدة ملفات
  Future<List<String>> pickMultipleFiles({
    List<String>? allowedExtensions,
    FileType fileType = FileType.any,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: allowedExtensions,
        allowMultiple: true,
      );

      if (result == null) {
        return [];
      }

      return result.files
          .where((file) => file.path != null)
          .map((file) => file.path!)
          .toList();
    } catch (e) {
      print('خطأ في اختيار الملفات: $e');
      return [];
    }
  }

  /// الحصول على المجلدات الافتراضية
  Future<Map<String, String>> getDefaultDirectories() async {
    Map<String, String> directories = {};
    
    try {
      // مجلد التطبيق
      Directory? appDir = await getApplicationDocumentsDirectory();
      directories['app_documents'] = appDir.path;
      
      // مجلد التخزين الخارجي
      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        directories['external_storage'] = externalDir.path;
      }
      
      // مجلد التنزيلات (للأندرويد)
      if (Platform.isAndroid) {
        String downloadsPath = '/storage/emulated/0/Download';
        if (await Directory(downloadsPath).exists()) {
          directories['downloads'] = downloadsPath;
        }
      }
      
      // مجلد المستندات (للأندرويد)
      if (Platform.isAndroid) {
        String documentsPath = '/storage/emulated/0/Documents';
        if (await Directory(documentsPath).exists()) {
          directories['documents'] = documentsPath;
        }
      }
      
    } catch (e) {
      print('خطأ في الحصول على المجلدات الافتراضية: $e');
    }
    
    return directories;
  }

  /// إنشاء مجلد إذا لم يكن موجوداً
  Future<bool> createDirectoryIfNotExists(String path) async {
    try {
      Directory directory = Directory(path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        return true;
      }
      return true;
    } catch (e) {
      print('خطأ في إنشاء المجلد: $e');
      return false;
    }
  }

  /// التحقق من وجود المجلد وإمكانية الكتابة فيه
  Future<bool> canWriteToDirectory(String path) async {
    try {
      Directory directory = Directory(path);
      if (!await directory.exists()) {
        return false;
      }
      
      // اختبار الكتابة بإنشاء ملف مؤقت
      String testFilePath = '$path/.write_test_${DateTime.now().millisecondsSinceEpoch}';
      File testFile = File(testFilePath);
      await testFile.writeAsString('test');
      await testFile.delete();
      
      return true;
    } catch (e) {
      print('لا يمكن الكتابة في المجلد: $e');
      return false;
    }
  }

  /// الحصول على معلومات الملف
  Future<Map<String, dynamic>?> getFileInfo(String filePath) async {
    try {
      File file = File(filePath);
      if (!await file.exists()) {
        return null;
      }
      
      FileStat stat = await file.stat();
      
      return {
        'path': filePath,
        'name': filePath.split('/').last,
        'size': stat.size,
        'modified': stat.modified,
        'type': stat.type.toString(),
      };
    } catch (e) {
      print('خطأ في الحصول على معلومات الملف: $e');
      return null;
    }
  }

  /// الحصول على قائمة الملفات في مجلد
  Future<List<Map<String, dynamic>>> getFilesInDirectory(
    String directoryPath, {
    List<String>? extensions,
    bool includeHidden = false,
  }) async {
    try {
      Directory directory = Directory(directoryPath);
      if (!await directory.exists()) {
        return [];
      }
      
      List<FileSystemEntity> entities = directory.listSync();
      List<Map<String, dynamic>> files = [];
      
      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          String fileName = entity.path.split('/').last;
          
          // تجاهل الملفات المخفية إذا لم يُطلب تضمينها
          if (!includeHidden && fileName.startsWith('.')) {
            continue;
          }
          
          // تصفية حسب الامتدادات
          if (extensions != null && extensions.isNotEmpty) {
            bool hasValidExtension = extensions.any(
              (ext) => fileName.toLowerCase().endsWith(ext.toLowerCase())
            );
            if (!hasValidExtension) {
              continue;
            }
          }
          
          Map<String, dynamic>? fileInfo = await getFileInfo(entity.path);
          if (fileInfo != null) {
            files.add(fileInfo);
          }
        }
      }
      
      // ترتيب الملفات حسب تاريخ التعديل (الأحدث أولاً)
      files.sort((a, b) => 
        (b['modified'] as DateTime).compareTo(a['modified'] as DateTime)
      );
      
      return files;
    } catch (e) {
      print('خطأ في قراءة محتويات المجلد: $e');
      return [];
    }
  }

  /// حذف ملف
  Future<bool> deleteFile(String filePath) async {
    try {
      File file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('خطأ في حذف الملف: $e');
      return false;
    }
  }

  /// نسخ ملف
  Future<bool> copyFile(String sourcePath, String destinationPath) async {
    try {
      File sourceFile = File(sourcePath);
      File destinationFile = File(destinationPath);
      
      if (!await sourceFile.exists()) {
        return false;
      }
      
      await sourceFile.copy(destinationPath);
      return true;
    } catch (e) {
      print('خطأ في نسخ الملف: $e');
      return false;
    }
  }

  /// نقل ملف
  Future<bool> moveFile(String sourcePath, String destinationPath) async {
    try {
      File sourceFile = File(sourcePath);
      
      if (!await sourceFile.exists()) {
        return false;
      }
      
      await sourceFile.rename(destinationPath);
      return true;
    } catch (e) {
      print('خطأ في نقل الملف: $e');
      return false;
    }
  }

  /// تنسيق حجم الملف
  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// التحقق من صحة امتداد الملف
  bool isValidFileExtension(String filePath, List<String> allowedExtensions) {
    String fileName = filePath.split('/').last.toLowerCase();
    return allowedExtensions.any((ext) => fileName.endsWith(ext.toLowerCase()));
  }

  /// إنشاء اسم ملف فريد لتجنب التداخل
  Future<String> generateUniqueFileName(String directoryPath, String fileName) async {
    String baseName = fileName.split('.').first;
    String extension = fileName.contains('.') ? '.${fileName.split('.').last}' : '';
    
    String uniqueFileName = fileName;
    int counter = 1;
    
    while (await File('$directoryPath/$uniqueFileName').exists()) {
      uniqueFileName = '${baseName}_$counter$extension';
      counter++;
    }
    
    return uniqueFileName;
  }
}