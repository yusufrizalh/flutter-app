import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menus/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool visible = false;
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  String userImage = "";

  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController userEmailCtrl = TextEditingController();
  final TextEditingController userPhoneCtrl = TextEditingController();
  final TextEditingController userAddressCtrl = TextEditingController();
  final TextEditingController userPasswordCtrl = TextEditingController();
  final TextEditingController userImageCtrl = TextEditingController();

  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future signupUser(ImageSource media) async {
    const String apiUrl = "http://192.168.1.12/flutter-api/users/signup.php";
    var img = await picker.pickImage(source: media);

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    if (img != null) {
      var pic = await http.MultipartFile.fromPath("image", img.path);
      request.fields["user_name"] = userNameCtrl.text;
      request.fields["user_email"] = userEmailCtrl.text;
      request.fields["user_phone"] = userPhoneCtrl.text;
      request.fields["user_address"] = userAddressCtrl.text;
      request.fields["user_password"] = userPasswordCtrl.text;
      request.files.add(pic);

      await request.send().then((result) {
        http.Response.fromStream(result).then((response) {
          var respCheck = convert.json.decode(response.body);
          if (respCheck["status"] == "OK") {
            final mySnackbar = SnackBar(
              content: Text(respCheck["message"]),
              backgroundColor: Colors.orange,
              elevation: 4,
              margin: const EdgeInsets.all(12),
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              dismissDirection: DismissDirection.down,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(mySnackbar);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      hintText: "Please enter your user name",
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "User Email",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  TextField(
                    controller: userEmailCtrl,
                    decoration: InputDecoration(
                      hintText: "Please enter your email address",
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "User Phone",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  TextField(
                    controller: userPhoneCtrl,
                    decoration: InputDecoration(
                      hintText: "Please enter your phone number",
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "User Address",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  TextField(
                    controller: userAddressCtrl,
                    decoration: InputDecoration(
                      hintText: "Please enter your address",
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.streetAddress,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "User Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  TextField(
                    controller: userPasswordCtrl..text = "Pa\$\$w0rd",
                    decoration: InputDecoration(
                      hintText: "Please enter your password",
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "User Image",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  GestureDetector(
                    onTap: () => openPickImage(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Pick an Image",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            // GestureDetector(
            //   onTap: () => debugPrint("TEST"),
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 50,
            //     width: MediaQuery.of(context).size.width / 3,
            //     decoration: BoxDecoration(
            //       color: Colors.orange,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: const Text(
            //       "Signup",
            //       style: TextStyle(color: Colors.white, fontSize: 16),
            //     ),
            //   ),
            // ),
            // const Padding(padding: EdgeInsets.only(top: 12)),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Already have account? Signin here",
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Visibility(
              visible: visible,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  List images = [];
  void openPickImage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Please choose media to select"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    signupUser(ImageSource.gallery);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      Padding(padding: EdgeInsets.only(right: 30)),
                      Text("From Gallery"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    signupUser(ImageSource.camera);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.camera),
                      Padding(padding: EdgeInsets.only(right: 30)),
                      Text("From Camera"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
