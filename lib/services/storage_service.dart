import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
Future<String?> getImageUrl(File image, String location) async {
  try {
    final Reference storageReference =await FirebaseStorage.instance.ref().child(location);
    final UploadTask uploadTask = storageReference.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final url = await taskSnapshot.ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    return null;
  }
}