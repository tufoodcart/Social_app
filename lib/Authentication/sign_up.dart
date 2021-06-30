import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_app/Constants/constants.dart';
import 'package:social_app/Feed/feed_screen.dart';

class SignUpPageWidget extends StatefulWidget {
  SignUpPageWidget({Key key}) : super(key: key);

  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  Widget emailFormField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 0, 0, 20),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: GoogleFonts.getFont(
                'Open Sans',
                color: Color(0xFF455A64),
                fontWeight: FontWeight.normal,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 3,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: GoogleFonts.getFont(
              'Open Sans',
              color: Color(0xFF455A64),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordFormField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 20),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: passwordController,
            obscureText: !passwordVisibility,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: GoogleFonts.getFont(
                'Open Sans',
                color: Color(0xFF455A64),
                fontWeight: FontWeight.normal,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              suffixIcon: InkWell(
                onTap: () => setState(
                  () => passwordVisibility = !passwordVisibility,
                ),
                child: Icon(
                  passwordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 22,
                  color: kPrimaryColor,
                ),
              ),
            ),
            style: GoogleFonts.getFont(
              'Open Sans',
              color: Color(0xFF455A64),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> createAccountWithEmail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -1),
              child: Image.network(
                'https://picsum.photos/seed/484/300',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment(0, 0),
                    child: Container(
                      width: 0,
                      height: 0,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 60),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              emailFormField(),
                              passwordFormField(),
                              // Sign up button
                              Align(
                                alignment: Alignment(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: GestureDetector(
                                    onTap: () async {
                                      HapticFeedback.mediumImpact();
                                      final user = await createAccountWithEmail(
                                        context,
                                        emailController.text,
                                        passwordController.text,
                                      );
                                      if (user == null) {
                                        return;
                                      } else {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                                child: FeedPageWidget(),
                                                type: PageTransitionType.fade),
                                            (r) => false);
                                      }
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: kSecondaryColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      alignment: Alignment(0, 0),
                                      child: Align(
                                        alignment: Alignment(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 2),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 0, 0, 0),
                                                child: Text(
                                                  'Sign up with Email',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
