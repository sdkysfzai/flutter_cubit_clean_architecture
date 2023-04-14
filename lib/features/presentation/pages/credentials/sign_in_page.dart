import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miload/consts.dart';
import 'package:flutter_miload/features/presentation/cubits/auth/cubit/auth_cubit.dart';
import 'package:flutter_miload/features/presentation/cubits/credential/cubit/credential_cubit.dart';
import 'package:flutter_miload/features/presentation/pages/credentials/utils/auth_helper.dart';
import 'package:flutter_miload/features/presentation/pages/main_screen/main_screen.dart';
import 'package:flutter_miload/features/presentation/widgets/auth_form_widgets.dart';
import 'package:flutter_miload/features/presentation/widgets/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigninIn = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            } else if (credentialState is CredentialFailure) {
              Fluttertoast.showToast(msg: "Invalid email or password");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                } else  {
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Sign In',
                style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
          ),
          AuthenticationFormField(
            isPasswordField: false,
            prefix: 'Email',
            controller: _emailController,
            validator:   AuthenticationHelper.validateEmail
          ),
          AuthenticationFormField(
            isPasswordField: true,
            prefix: 'Password',
            controller: _passwordController,
            validator: AuthenticationHelper.validatePass,
          ),
          sizeVer(15),
     
          _isSigninIn
              ? const CircularProgressIndicator(
                  color: primaryColor,
                )
              : ButtonWidget(
                  buttonText: 'Sign In',
                  onPressed: () => _signInUser(),
                  color: primaryColor),
          sizeVer(8),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "I don't have an account! ",
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  text: "Sign Up",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          PageConsts.signUpPage, (route) => false);
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const SignUpPage()),
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

   

  Future<void> _signInUser() async {
     if (_formKey.currentState!.validate()) {

    setState(() {
      _isSigninIn = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signInUser(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((value) => _clear());
  }
     }

  void _clear() {
    setState(() {
  
      _isSigninIn = false;
    });
  }
}
