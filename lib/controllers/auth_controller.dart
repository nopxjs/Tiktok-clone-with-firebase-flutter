import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toktik/constants.dart';
import 'package:toktik/views/screens/homeScreen.dart';
import 'package:toktik/models/user.dart' as model;
import 'package:toktik/views/screens/auth/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitalScreen);
  }

  _setInitalScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          "You have seccessfully selected your profile picture!");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload to firebase function
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // register the user
  void registerUser(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          image != null) {
        // save out user and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //store the image
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
          email: email,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      }
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          image == null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //store the image

        model.User user = model.User(
          name: username,
          profilePhoto:
              'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
          uid: cred.user!.uid,
          email: email,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (password.isNotEmpty && email.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        // Get.snackbar('Logged in', 'Logged in Successfully!');
      } else {
        Get.snackbar('Error Login', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error Login', e.toString());
    }
  }
}
