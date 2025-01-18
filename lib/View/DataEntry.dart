import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/CreateAccountFuncs.dart';
import '../main.dart';
import 'create_account.dart';

const String baseUrl = "https://example.com/api";

class InfoAccount extends StatefulWidget {
  const InfoAccount({super.key});

  @override
  State<InfoAccount> createState() => _InfoAccountState();
}

class _InfoAccountState extends State<InfoAccount> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController paymentMethod = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  File? image;
  final ImagePicker _picker = ImagePicker();
  bool isImageTapped = false;
  @override
  void initState() {
    super.initState();
    _loadImage();
  }


  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        image = File(imagePath);
      });
    }
  }

  Future<void> getImage() async {
    final pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      // Save the image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', pickedFile.path);

      // Call the profile method with the selected image
      await profile(image!);
    } else {
      print('No image selected.');
    }
  }

  Future<void> profile(File image) async {

    final token = userData?.getString('token');
    if (token == null) {
      print('No token found.');
      return;
    }
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request =
      http.MultipartRequest('POST', Uri.parse('$back_url/update/photo'));

      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseString);

        // Check if response has 'user' object and 'image' field
        if (jsonResponse.containsKey('user') &&
            jsonResponse['user'].containsKey('image')) {
          var imagePath = jsonResponse['user']['image'];
          print('Image uploaded successfully: $imagePath');
        } else {
          print(
              'Image uploaded, but response format is unexpected: $jsonResponse');
        }
      } else {
        var responseString = await response.stream.bytesToString();
        print('Failed to upload image: ${response.reasonPhrase}');
        print('Response body: $responseString');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> _deleteImage() async {

    final token = userData?.getString('token');
    if (token == null) {
      print('No token found.');
      return;
    }

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var request = http.Request('GET', Uri.parse('$back_url/deleteImage'));

      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseString);

        print('Response body: $responseString');

        if(jsonResponse['massage '] == "Deleted photo successfully") {
          await userData?.remove('profileImage');
          setState(() {
            image = null;
          });
          print('Image deleted successfully');
        } else {
          print('Failed to delete image: ${jsonResponse['massage ']}');
        }
      } else {
        var responseString = await response.stream.bytesToString();
        print('Failed to delete image: ${response.reasonPhrase}');
        print('Response body: $responseString');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Form(
    key: formState,
    child: SingleChildScrollView(
    child: Column(
    children: [
    const SizedBox(height: 50),
    ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
    colors: [
    const Color.fromARGB(255, 238, 226, 113),
    Colors.black
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ).createShader(bounds),
    child: Text(
    'Account Details',
    style: TextStyle(
    fontSize: 35,
    letterSpacing: 3,
    color: Colors.white,
    ),
    ),
    ),
    const SizedBox(height: 30),
    GestureDetector(
    onTap: getImage,
    child: Stack(
    alignment: Alignment.center,
    children: [
    CircleAvatar(
    radius: 100,
    backgroundImage:
    image != null ? FileImage(image!) : null,
    backgroundColor:
    image == null ? Color(0xffF6EC97) : Colors.black,
    child: image == null
    ? Icon(
    Icons.camera_alt,
    size: 50,
    color: Colors.black,
    )
        : null,
    ),
    if (image != null)
    Positioned(
    bottom: -7.5,
    child: ElevatedButton(
    onPressed: getImage,
    style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xffF6EC97),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(200),
    ),
    padding: EdgeInsets.symmetric(
    horizontal: 12, vertical: 6),
    minimumSize: Size(50, 30),
    ),
    child: const Text(
    'change',
    style: TextStyle(color: Colors.black),
    ),
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 30),
    Row(
    children: [
    Expanded(
    child: TextFormField(
    controller: firstName,
    validator: (value) {
    if (value!.length < 2) {
    return 'First Name should be at least 2 characters';
    }
    return null;
    },
    keyboardType: TextInputType.name,
    decoration: const InputDecoration(
    labelText: "Enter your first name",
    labelStyle: TextStyle(color: Colors.black),
    enabledBorder: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black),
    ),
    errorBorder: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.red),
    ),
    ),
    ),
    ),
    const SizedBox(width: 30),
    Expanded(
    child: TextFormField(
    controller: lastName,
    validator: (value) {
    if (value!.length < 2) {
    return 'Last Name should be at least 2 characters';
    }
    return null;
    },
    keyboardType: TextInputType.name,
    decoration: const InputDecoration(
    labelText: "Enter your last name",
    labelStyle: TextStyle(color: Colors.black),
    enabledBorder: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black),
    ),
    errorBorder: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.red),
    ),
    ),
    ),
    ),
    ],
    ),
    const SizedBox(height: 30),
    TextFormField(
    controller: location,
    validator: (value) {
    if (value!.isEmpty) {
    return 'Location is required. Please enter it.';
    }
    return null;
    },
    keyboardType: TextInputType.name,
    decoration: const InputDecoration(
    labelText: "Enter your location",
    labelStyle: TextStyle(color: Colors.black),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black),
    ),
    errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.red),
    ),
    ),
    ),
    const SizedBox(height: 30),
    TextFormField(
    controller: paymentMethod,
    validator: (value) {
    if (value!.isEmpty) {
    return 'Payment method is required. Please enter it.';
    }
    return null;
    },
    keyboardType: TextInputType.name,
    decoration: const InputDecoration(
    labelText: "Enter your payment method",
    labelStyle: TextStyle(color: Colors.black),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black),
    ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    ),
      const SizedBox(height: 30),
      SizedBox(
        width: 450,
        height: 40,
        child: MaterialButton(
          onPressed: () async{
            if (formState.currentState!.validate())  {

             controller.card_number=paymentMethod.text;
             controller.location=location.text;
             controller.first_name=firstName.text;
             controller.last_name=lastName.text;
             userData?.setString('first_name', firstName.text);
             userData?.setString('last_name', lastName.text);
             userData?.setString('location', location.text);
             userData?.setString('phone', controller.number);
             //photo
              await CreateAccountFuncs.dataEntry();
              if(userData?.getString('token')!=null)
                Get.toNamed("/delivery");
              else
                print('unexpected errpr occured');
            }
          },
          color: Color(0xffF6EC97),
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            'Save',
            style: TextStyle(fontSize: 20),
          ),
        ),
      )
    ],
    ),
    ),
    ),
        ),
    );
  }
}
