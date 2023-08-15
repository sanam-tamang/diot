import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploaderRepository {
  ImageUploaderRepository._();
  static  ImageUploaderRepository getInstance()=> ImageUploaderRepository._();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  Future<String> uploadToFirebase(Uint8List image) async {
    
    Reference ref =
        _storage.ref(_auth.currentUser?.uid).child(_auth.currentUser?.uid??"user").child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
