import 'package:bc_final_project/constants/r.dart';
import 'package:bc_final_project/helpers/shared_preference_helpers.dart';
import 'package:bc_final_project/helpers/user_email.dart';
import 'package:bc_final_project/models/responses.dart';
import 'package:bc_final_project/models/user_model.dart';
import 'package:bc_final_project/repositories/api.dart';
import 'package:bc_final_project/views/main_screen.dart';
import 'package:bc_final_project/widgets/buttons/buttons.dart';
import 'package:bc_final_project/widgets/forms/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String route = "register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum Gender { lakilaki, perempuan }

class _RegisterScreenState extends State<RegisterScreen> {
  List<String> classes = ["10", "11", "12"];

  String gender = "Laki-laki";
  String selectedClass = "10";
  final emailController = TextEditingController();
  final schoolNameController = TextEditingController();
  final fullnameController = TextEditingController();

  onTapGender(Gender selected) {
    if (selected == Gender.lakilaki) {
      gender = "Lak-laki";
    } else {
      gender = "Perempuan";
    }

    setState(() {});
  }

  initDataUser() {
    emailController.text = UserEmail.getUserEmail()!;
    fullnameController.text = UserEmail.getUserDisplayName()!;
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
      backgroundColor: Color(0xfff0f3f5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Yuk isi data diri",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: ButtonCustom(
            handler: () async {
              final json = {
                "email": emailController.text,
                "nama_lengkap": fullnameController.text,
                "nama_sekolah": schoolNameController.text,
                "kelas": selectedClass,
                "gender": gender,
                "foto": UserEmail.getUserPhotoUrl(),
              };
              final result = await ApiHandler().postRegister(json);
              if (result.status == Status.success) {
                final registerResult = UserModel.fromJson(result.data!);
                if (registerResult.status == 1) {
                  await SharedPreferenceHelper().setUserData(registerResult);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainScreen.route, (context) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(registerResult.message!),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Terjadi kesalahan, silahkan ulangi kembali"),
                  ),
                );
              }
            },
            backgroundColor: R.colors.primary,
            borderColor: R.colors.primary,
            child: Text(
              R.strings.daftar,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: emailController,
                hintText: 'Email Anda',
                title: "Email",
                enabled: false,
              ),
              CustomTextField(
                hintText: 'Nama Lengkap Anda',
                title: "Nama Lengkap",
                controller: fullnameController,
              ),
              SizedBox(height: 5),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Laki-laki"
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.lakilaki);
                        },
                        child: Text(
                          "Laki-laki",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Laki-laki"
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
              SizedBox(height: 5),
              Text(
                "Kelas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
              CustomTextField(
                hintText: 'Nama Sekolah',
                title: "Nama Sekolah",
                controller: schoolNameController,
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
