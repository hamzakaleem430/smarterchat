import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarterchat/pages/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool _hidePassword = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenUtilInit(
          designSize: Size(300, 500),
          builder: () => Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(.06.sh),
                        child: Text(
                          'SmarterChat',
                          style: GoogleFonts.hurricane(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      height: .03.sh,
                    ),
                    Text(
                      'WELCOME',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Login with details',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: .06.sh,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: .01.sh,
                    ),
                    TextFormField(
                      validator: (value) {},
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: .3),
                            borderRadius: BorderRadius.zero),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              width: .7, color: Theme.of(context).primaryColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: .03.sh,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: .01.sh,
                    ),
                    TextFormField(
                      obscureText: _hidePassword,
                      validator: (value) {},
                      controller: _passwordController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_hidePassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: .3),
                              borderRadius: BorderRadius.zero),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                                width: .7,
                                color: Theme.of(context).primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text('Forgot Password?'),
                        style: TextButton.styleFrom(primary: Colors.grey[800]),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/forgotpassword');
                        },
                      ),
                    ),
                    SizedBox(
                      height: .015.sh,
                    ),
                    // _loginResponse == LoginResponse.EmailNotVerified
                    //     ?
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Email Not Verified.',
                    //       style: TextStyle(color: Colors.red),
                    //     ),
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         'Resend Verification Email',
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // : SizedBox(),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: loading
                            ? null
                            : () {
                                // setState(() {
                                //   _loginResponse = null;
                                // });
                                // if (_formKey.currentState!.validate()) {
                                //   setState(() {
                                //     loading = true;
                                //   });
                                //   _authServices
                                //       .login(
                                //           email: _emailController.text,
                                //           password: _passwordController.text)
                                //       .then((value) {
                                //     if (value ==
                                //         LoginResponse.LogInSuccessful) {
                                //       Navigator.pushReplacementNamed(
                                //           context, '/home');
                                //     } else {
                                //       setState(() {
                                //         loading = false;
                                //         _loginResponse = value;
                                //       });
                                //       _formKey.currentState!.validate();
                                //     }
                                //   });
                                // }
                              },
                        child: loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Login'),
                        style: ElevatedButton.styleFrom(
                            onSurface: Theme.of(context).primaryColor,
                            primary: Theme.of(context).primaryColor,
                            textStyle: TextStyle(fontSize: 12.sp),
                            fixedSize: Size(1.sw, .07.sh),
                            elevation: 0,
                            shape: loading
                                ? CircleBorder()
                                : BeveledRectangleBorder()),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            }));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.grey[800],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
