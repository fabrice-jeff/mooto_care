import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageToFirebase(File imageFile) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');
  UploadTask uploadTask = storageReference.putFile(imageFile);

  await uploadTask.whenComplete(() async {
    print('Image uploaded to Firebase Storage');
  });

  String imageUrl = await storageReference.getDownloadURL();
  return imageUrl;
}
