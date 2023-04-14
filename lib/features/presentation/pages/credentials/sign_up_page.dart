import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miload/consts.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:flutter_miload/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/credential/cubit/credential_cubit.dart';
import 'package:flutter_miload/features/presentation/pages/credentials/utils/auth_helper.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/main_screen.dart';
import 'package:flutter_miload/features/presentation/widgets/auth_form_widgets.dart';
import 'package:flutter_miload/features/presentation/widgets/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSigningUp = false;

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (credentialState is CredentialFailure) {
              Fluttertoast.showToast(msg: "Invalid email or password");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                } else {
                  return bodyWidget(context);
                }
              });
            }
            return bodyWidget(context);
          },
        ),
      ),
    );
  }

  Padding bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //         height: 180,
          //         child: SvgPicture.asset(
          //           'assets/images/auth_logo_image.png',
          //         ),
          //       ),
          sizeVer(30),
          // Center(
          //   child: Stack(children: [
          //     Container(
          //       height: 60,
          //       width: 60,
          //       decoration: BoxDecoration(
          //         color: greyColor,
          //         borderRadius: BorderRadius.circular(30)
          //       ),
          //       child: Image.asset(''),
          //     )
          //   ],),
          // ),
          sizeVer(15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Sign Up',
                style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
          ),
          sizeVer(15),
          AuthenticationFormField(
            isPasswordField: false,
            prefix: 'Email',
            controller: emailController,
            validator: AuthenticationHelper.validateEmail,
          ),
          AuthenticationFormField(
            isPasswordField: false,
            prefix: 'Username',
            controller: userNameController,
            validator: AuthenticationHelper.validateName,
          ),
          AuthenticationFormField(
            isPasswordField: true,
            prefix: 'Password',
            controller: passwordController,
            validator: AuthenticationHelper.validatePass,
          ),
           AuthenticationFormField(
            isPasswordField: true,
            prefix: 'Password again',
            validator: (val) {
                    if (val != passwordController.text.trim()) {
                      return 'Password is not same!';
                    }
                    return null;
                  },
          ),
          sizeVer(15),
          _isSigningUp
              ? const CircularProgressIndicator(
                  color: primaryColor,
                )
              : ButtonWidget(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    _signUpUser();
                  },
                  color: primaryColor),
          sizeVer(8),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "I already have an Account! ",
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  text: "Sign In",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'signInPage', (route) => false);
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const SignInPage()),
                      //     (route) => false);
                    },
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUpUser() async {
    if(_formKey.currentState!.validate()) {

    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
            user: UserEnitity(
          email: emailController.text.trim(),
          username: userNameController.text.trim(),
          password: passwordController.text.trim(),
        ))
        .then((value) => _clear());
  }
    }

  void _clear() {
    setState(() {
      emailController.clear();
      userNameController.clear();
      passwordController.clear();
      _isSigningUp = false;
    });
  }
}
