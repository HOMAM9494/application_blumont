import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<List<Object?>> fetchDataFromFirestore() async {
  // استرجاع مرجع لمجموعة المستندات في Firestore
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // استرجاع البيانات
  QuerySnapshot querySnapshot = await users.get();

  // تحويل البيانات المسترجعة إلى List<Map<String, dynamic>>
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

Future<void> saveDataToFile(List<Map<String, dynamic>> data) async {
  // الحصول على مسار المجلد الدائم للتطبيق
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

  // إنشاء ملف نصي في المجلد الدائم للتطبيق
  File file = File('${appDocumentsDirectory.path}/data.txt');

  // كتابة البيانات إلى الملف كنص
  await file.writeAsString(json.encode(data));
}

void shareFile(String filePath) {
  Share.shareFiles([filePath], text: 'مشاركة البيانات');
}

///////////////////////////////////////////////////////
void saveDataToFile01(String data) async {
  // الحصول على مسار مجلد الوثائق الخاص بالتطبيق
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String filePath = '${documentsDirectory.path}/data.txt';

  // كتابة البيانات إلى ملف النص
  File file = File(filePath);
  await file.writeAsString(data);

  // مشاركة الملف
  Share.shareFiles([filePath], text: 'مشاركة البيانات');
}
