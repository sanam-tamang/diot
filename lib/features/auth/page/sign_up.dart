import '../models/user_registration_model.dart';
import '../widgets/email_text_field.dart';
import '../widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/route/route_name.dart';
import '../../../core/utils/custom_circualr_dialog.dart';
import '../../../core/widgets/app_logo.dart';
import '../../internet_checker/widgets/internet_checker_widget.dart';
import '../../../core/widgets/message_with_button.dart';
import '../../../core/widgets/primary_gradient_button.dart';
import '../../../core/utils/toast_message.dart';
import '../blocs/registration_cubit/registration_cubit.dart';
import '../widgets/full_name_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();

    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InternetCheckerWidget(
          child: Form(
            key: _form,
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppLogo(
                      center: true,
                    ),
                    _customGap(),
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    _customGap(),
                    FullNameTextField(
                      hintText: 'Enter your full name',
                      controller: nameController,
                      label: 'Full Name',
                    ),
                    _customGap(),
                    EmailTextField(
                      hintText: 'Enter your email',
                      controller: emailController,
                      label: 'Email',
                    ),
                    _customGap(),
                    PasswordTextField(
                      hintText: 'Enter your password',
                      controller: passwordController,
                      label: 'Password',
                    ),
                    _customGap(48),
                    BlocConsumer<RegistrationCubit, RegistrationState>(
                      listener: (context, state) {
                        if (state is RegisterSucess) {
                          Navigator.of(context).pop();

                          toastMessage(content: state.message.toString());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRouteName.verificationPage, (route) => false);
                        }
                        if (state is RegisterFailure) {
                          Navigator.of(context).pop();
                          toastMessage(content: state.message.toString());
                        }

                        if (state is RegisterLoading) {
                          circularLoadingDialog(context);
                        }
                      },
                      builder: (context, state) {
                        return PrimaryGradientButton(
                          onPress: () => _signUpPage(),
                          label: "Sign Up",
                        );
                      },
                    ),
                    _customGap(),
                    Center(
                      child: MessageWithButton(
                          message: "Already have an account?",
                          navigateTo: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  AppRouteName.login, (route) => false),
                          routeName: "Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _customGap([double? size = 24]) {
    return SizedBox(
      height: size,
    );
  }

  void _signUpPage() {
    if (_form.currentState?.validate() == true) {
      final user = UserRegistrationModel(
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        email: emailController.text.trim().toLowerCase(),
      );
      context.read<RegistrationCubit>().registerUser(user);
    }
  }
}
