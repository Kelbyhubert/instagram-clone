import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(File imageFile) async {
  try {
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
    
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl; 
    
  } catch (e) {
    return null;
  }
}