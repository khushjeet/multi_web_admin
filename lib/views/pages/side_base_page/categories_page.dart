import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_web_admin/views/pages/widgets/categories_widget.dart';

class CategoriesPage extends StatefulWidget {
  static const String routeName = "/CategoriesPage";
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  dynamic _productImage;

  String? fileName;

  String? categoryName; //simiar to late

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _productImage = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

//is uploaded the image to firebase and take as url
  _uploadCategoryToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('categoryImages').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//new creates
  uploadCategoryFormFiels() async {
    EasyLoading.show();
    if (_formKey.currentState!.validate()) {
      String imageUrl = await _uploadCategoryToStorage(_productImage);
      await _firestore.collection('categories').doc(fileName).set({
        'image': imageUrl,
        'categoryName': categoryName,
      }).whenComplete(() => EasyLoading.dismiss());
      setState(() {
        _productImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border.all(color: Colors.green.shade800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _productImage != null
                            ? Image.memory(_productImage)
                            : const Center(
                                child: Text("categories"),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _pickImage();
                          },
                          child: const Text("Upload Image")),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: SizedBox(
                    width: 170,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Categories Name must be field";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Enter Category Name",
                          hintText: "Enter categories Name"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      uploadCategoryFormFiels();
                      //uploadToFirebaseStore();
                    },
                    child: const Text("Save"))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Categories",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
