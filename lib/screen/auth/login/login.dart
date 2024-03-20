import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/image_container/image_container.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/image_path/image_path.dart';

class Login extends StatefulWidget {
  final Function? toggleView;
  const Login({super.key, required this.toggleView});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  ImagePath imaPath = ImagePath();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageContainer(
                            isUrl: false,
                            width: 205.0,
                            height: 60.0,
                            url: imaPath.path('innwa_logo.png')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Welcome Back",
                          style: GoogleFonts.roboto(
                              fontSize: 30.0, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign in to Continue",
                          style: GoogleFonts.roboto(
                              fontSize: 18.0, color: Colors.black45),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFormField(
                          needBackground: true,
                          label: "Email",
                          onSaved: () => {},
                          pass: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFormField(
                          needBackground: true,
                          label: "Password",
                          onSaved: () => {},
                          pass: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 9.0),
                            child: TextButton(
                              onPressed: () => {},
                              child: Text(
                                "Forget Password?",
                                style: GoogleFonts.roboto(
                                    fontSize: 15.0,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          () => {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => MyApp(api: ,)),
                                //   )
                              };
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                          child: Center(
                              child: Text(
                            'Login',
                            style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          "or",
                          style: GoogleFonts.roboto(
                              color: Colors.black54, fontSize: 18.0),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageContainer(
                                  isUrl: false,
                                  width: 50,
                                  height: 50,
                                  url: imaPath.path('google_logo.png')),
                              Text(
                                'Login In with Google',
                                style: GoogleFonts.roboto(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 20.0, top: 45.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RobotoText(
                                    fontSize: 15.0,
                                    fontColor: Colors.black,
                                    text: "Don't Have Account?"),
                                InkWell(
                                    onTap: () => {widget.toggleView!()},
                                    child: RobotoText(
                                        fontSize: 15.0,
                                        fontColor: primaryColor,
                                        text: "Register Here"))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.black54)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }
}
