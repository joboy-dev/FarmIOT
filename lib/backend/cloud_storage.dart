// ignore_for_file: avoid_print

import 'dart:io';

import 'package:FarmIOT/backend/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorage {
  // IMAGES
  String imageUrl = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  // get image from CAMERA
  Future imageFromCamera() async {
    // initialize image picker
    ImagePicker imagePicker = ImagePicker();

    // images need a variable type of XFile to hold them as variables
    // Through this you can get imformation about the image

    // set up the source where the file will be gotten from
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1000.0,
      maxWidth: 1000.0,
    );
    print(file?.path); // we can get the path of the file from here

    if (file == null) return;

    // UPLOAD FILE TO FIREBASE STORAGE
    // get a reference to storage root before doing anything else
    Reference root = FirebaseStorage.instance.ref();

    // create a new directory in the root directory by referencing it
    Reference rootChild = root.child('users');

    // create unique file name based on yser id
    String fileName = auth.currentUser!.uid;

    // upload a file into the users folder created above and use the unique
    // file name created previously as the name of the file
    Reference imageFile = rootChild.child(fileName);

    // handle errors
    try {
      // upload xfile file to imageFile folder
      await imageFile.putFile(File(file.path));

      // Success: get download url so it can be used in firestore
      imageUrl = await imageFile.getDownloadURL();

      // get current user in firebase
      String userId = auth.currentUser!.uid;

      // store image url in firestore based on current user id
      Database(uid: userId).addProfilePicture(imageUrl);
      return imageUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // get image from GALLERY
  Future imageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000.0,
      maxWidth: 1000.0,
    );

    if (file == null) return;

    Reference root = FirebaseStorage.instance.ref();

    Reference rootChild = root.child('users');

    String fileName = auth.currentUser!.uid;

    Reference imageFile = rootChild.child(fileName);

    try {
      await imageFile.putFile(File(file.path));

      imageUrl = await imageFile.getDownloadURL();

      String userId = auth.currentUser!.uid;

      Database(uid: userId).addProfilePicture(imageUrl);
      return imageUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
