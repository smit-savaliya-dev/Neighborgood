import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:neighborgood_assignment/utils/app_constant/app_constants.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_snackbar_helper.dart';

class PostProvider with ChangeNotifier {

  bool _isButtonEnabled = false;
  bool _isLoading = false;
  File? _pickedImage;
  final picker = ImagePicker();


  bool get isLoading => _isLoading;
  bool get isButtonEnabled => _isButtonEnabled;
  File? get pickedImage => _pickedImage;


  void checkButtonEnabled(String title, String description) {

    _isButtonEnabled = title.isNotEmpty &&
        description.isNotEmpty && _pickedImage != null ;
    notifyListeners();
  }


  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadPost(String title, String description) async {
    print(pickedImage?.path);

    if (pickedImage == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final storageRef = FirebaseStorage.instance.ref().child('Posts');
      final uniqueKey = DateTime.now().millisecondsSinceEpoch.toString();
      final uploadTask = await storageRef.child(uniqueKey).putFile(pickedImage!);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      final postRef = FirebaseDatabase.instance.ref().child('Posts').push();
      await postRef.set({
        'id': postRef.key,
        'title': title,
        'description': description,
        'image': imageUrl,
      });

      showCustomSnackBarHelper('Post uploaded successfully!', isError: false);

      _isLoading = false;
      _pickedImage = null;
      notifyListeners();
    } catch (e) {
      print(e);
      // Handle error
      _isLoading = false;
      notifyListeners();
      showCustomSnackBarHelper('Failed to upload post. Please try again.', isError: true);
    }
  }
}
