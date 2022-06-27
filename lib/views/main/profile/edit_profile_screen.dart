import 'package:bc_final_project/constants/r.dart';
import 'package:bc_final_project/helpers/shared_preference_helpers.dart';
import 'package:bc_final_project/helpers/user_email.dart';
import 'package:bc_final_project/models/user_model.dart';
import 'package:bc_final_project/widgets/buttons/buttons.dart';
import 'package:bc_final_project/widgets/forms/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static String route = "edit_profile_screen";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

enum Gender { lakilaki, perempuan }

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<String> classes = ["10", "11", "12"];

  String gender = "Laki-laki";
  String selectedClass = "10";
  final emailController = TextEditingController();
  final schoolController = TextEditingController();
  final fullnameController = TextEditingController();

  onTapGender(Gender selected) {
    if (selected == Gender.lakilaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() async {
    emailController.text = UserEmail.getUserEmail()!;
    final dataUser = await SharedPreferenceHelper().getUserData();
    fullnameController.text = dataUser!.data!.userName!;
    schoolController.text = dataUser.data!.userAsalSekolah!;
    gender = dataUser.data!.userGender!;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Edit Akun",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: ButtonCustom(
            radius: 8.0,
            handler: () async {
              // final json = {
              //   "email": emailCon
              // }
            },
            backgroundColor: R.colors.primary,
            borderColor: R.colors.primary,
            child: Text(
              R.strings.perbaharuiAkun,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldUnderline(
                title: "Email",
                hintText: "Email anda",
                enabled: false,
                controller: emailController,
              ),
              CustomTextFieldUnderline(
                title: "Nama Lengkap",
                hintText: "Nama lengkap anda",
                enabled: false,
                controller: fullnameController,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: R.colors.greySubtitle,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary:
                              gender.toLowerCase() == "Laki-laki".toLowerCase()
                                  ? R.colors.primary
                                  : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(
                            Gender.lakilaki,
                          );
                        },
                        child: Text(
                          "Laki-laki",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender.toLowerCase() ==
                                    "Laki-laki".toLowerCase()
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Perempuan"
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.perempuan);
                        },
                        child: Text(
                          "Perempuan",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Perempuan"
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Kelas",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.colors.greySubtitle),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: R.colors.greyBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedClass,
                      items: classes
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (String? val) {
                        selectedClass = val!;
                        setState(() {});
                      }),
                ),
              ),
              SizedBox(height: 5),
              CustomTextFieldUnderline(
                hintText: 'Nama Sekolah',
                title: "Nama Sekolah",
                controller: schoolController,
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
