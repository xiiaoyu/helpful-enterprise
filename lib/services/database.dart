import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  uploadNewPatientInfo(patientData) {
    FirebaseFirestore.instance.collection('patients').add(patientData);
  }

  // uploadImage(String imageUrl) async {
  //   final _storage = FirebaseStorage.instance;
  //   final _picker = ImagePicker();
  //   PickedFile image;
  //
  //   //check permission
  //   await Permission.photos.request();
  //
  //   var permissionStatus = await Permission.phone.status;
  //
  //   if (permissionStatus.isGranted) {
  //     //select images
  //     await _picker.getImage(source: ImageSource.gallery);
  //     // await _picker.getImage(source: ImageSource.camera);
  //
  //     var file = File(image.path);
  //
  //     if (image != null) {
  //       //upload to firebase
  //       var snapshot = await _storage.ref().child('symptomFolder/imageName').putFile(file).whenComplete(() => null);
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //       imageUrl = downloadUrl;
  //     } else {
  //       print('No path receive');
  //     }
  //   } else {
  //     print('Grant Permission and try again');
  //   }
  // }
}
