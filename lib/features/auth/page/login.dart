import '../../../core/widgets/app_logo.dart';
import '../utils/nav_page_or_verification_page_distinguinter_page.dart';

import '../widgets/email_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/config/route/route_name.dart';

import '../../../core/widgets/primary_gradient_button.dart';
import '../../../core/widgets/message_with_button.dart';

import '../../../core/utils/custom_circualr_dialog.dart';
import '../../internet_checker/widgets/internet_checker_widget.dart';
import '../../../core/utils/toast_message.dart';
import '../blocs/signin_cubit/signin_cubit.dart';
import '../widgets/password_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InternetCheckerWidget(
          child: BlocListener<SigninCubit, SigninState>(
            listener: (context, state) {
              if (state is SigninSuccess) {
                toastMessage(content: "Login Successful");
                Navigator.of(context).pop();
                navOrVerificationPageDistinguinter(context);
              } else if (state is SigninFailure) {
                toastMessage(content: state.errorMessage);
                Navigator.of(context).pop();
              } else if (state is SigninLoading) {
                circularLoadingDialog(context);
              }
            },
            child: Form(
              key: _form,
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    children: [
                     const  AppLogo(
                        center: true,
                      ),
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                    
                      _customGap(72),
                      // const Spacer(),
                      EmailTextField(
                        hintText: 'Enter your email',
                        controller: emailController,
                        label: "Email",
                      ),
                      _customGap(),
                      PasswordTextField(
                        hintText: 'Enter your passoword',
                        controller: passwordController,
                        label: "Password",
                      ),
                      _customGap(48),

              
                  
                      PrimaryGradientButton(
                          onPress: () => login(), label: "Login"),

                      _customGap(),

                      MessageWithButton(
                          message: "Don't have an account yet?",
                          navigateTo: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  AppRouteName.register, (route) => false),
                          routeName: "SignUp"),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _customGap([double? size=24]) {
    return  SizedBox(
      height: size,
    );
  }

  void login() {
    if (_form.currentState?.validate() == true) {
      context.read<SigninCubit>().signIn(
          email: emailController.text.trim().toLowerCase(),
          password: passwordController.text);
    }
  }
}
