
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../signin_up/screen_signin.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  var db = FirebaseFirestore.instance;
  late String documentId = '';
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  File? file;
  var url;

  Future<void> getImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? imageCamera = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (imageCamera!=null){
     file=File(imageCamera!.path);
     var nameimage=basename(imageCamera!.path);
     var refstorage=FirebaseStorage.instance.ref(nameimage);
     await refstorage.putFile(file!);
      url =await refstorage.getDownloadURL();

    }

    setState(() {


      // var imageName=basename(image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: db
            .collection('users')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((value){
          for (var dataId in value.docs) {
            String pre = dataId.id.toString();
            documentId = pre;
            print("${dataId.id} ");
          }
          return user.doc(documentId).get();

        }),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
          if (snap.hasError) {
            return const Text("Some thing went wrong");
          }
          if (snap.hasError && snap.data!.exists) {
            return const Text("Some thing went wrong");
          }
          if (snap.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snap.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Stack(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 75,
                          child: url == null
                              ? Image(
                                  image: AssetImage('assets/images/user.jpg'),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(75),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                   url!,
                                    fit: BoxFit.fill,
                                    height: 170,
                                    width: 170,
                                  ),
                                ),
                        ),
                        onTap: () {
                          getImage();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  itemProfile(
                      'الاسم', '${data['name']}', CupertinoIcons.person),
                  const SizedBox(height: 10),
                  itemProfile(
                      'الهاتف', '${data['phone']}', CupertinoIcons.phone),
                  const SizedBox(height: 10),
                  itemProfile(
                      'العنوان', '${data['address']}', CupertinoIcons.location),
                  const SizedBox(height: 10),
                  itemProfile(
                      'الإيميل', '${data['email']}', CupertinoIcons.mail),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email:
                                      "${FirebaseAuth.instance.currentUser!.email}")
                              .whenComplete(() {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const ScreenSignin();
                              }),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                        ),
                        child: const Text('تغيير كلمة السر')),
                  )
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(color: Colors.black, fontSize: 18)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: Colors.black45, fontSize: 16)),
        leading: Icon(iconData, color: Colors.deepOrange),
        trailing: const Icon(Icons.arrow_forward, color: Colors.deepOrange),
        tileColor: Colors.white,
      ),
    );
  }
}
