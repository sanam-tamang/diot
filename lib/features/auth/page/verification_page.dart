import 'dart:async';
import 'dart:developer';

import 'package:devmandu/core/config/route/route_name.dart';
import 'package:devmandu/core/widgets/message_with_button.dart';
import 'package:devmandu/features/auth/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/toast_message.dart';
import '../../article/pages/home_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with AutomaticKeepAliveClientMixin<VerificationPage> {
  //firebase user
  User? _user;
  Timer? _thirtySecondTimer;
  int _thirtySecond = 30;
  Timer? _threeSecondTimerForFirstTimeToSendEmail;
  Timer? _threeSecondContinueTimer;
  bool isEmailVerified = false;
  @override
  void initState() {
    super.initState();
    _user = UserRepository.getInstance().currentUser;
    _sendEmailAfter3Second();
    _threeSecondContinueTimeFuc();
    log("I am at init-111");
  }

  void _threeSecondContinueTimeFuc() {
    _threeSecondContinueTimer =
        Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        setState(() {
          isEmailVerified = true;
          _threeSecondTimerForFirstTimeToSendEmail?.cancel();
          _thirtySecondTimer?.cancel();
          _threeSecondContinueTimer?.cancel();
          toastMessage(content: "Email is verified");
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouteName.navbar, (route) => false);
          return;
        });
      }
    });
  }

  void _start30SecondTimer() {
    // Create a timer that runs every 1 second
    _thirtySecondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_thirtySecond > 0) {
          // Decrease the remaining seconds by 1
          _thirtySecond--;
        } else {
          // Countdown is complete, cancel the timer
          _thirtySecondTimer?.cancel();
          _thirtySecond = 30;
        }
      });
    });
  }

  void _sendEmailAfter3Second() {
    _threeSecondTimerForFirstTimeToSendEmail =
        Timer(const Duration(seconds: 3), () {
      _sendVerificationEmail();
    });
  }

  // Function to send a verification email
  Future<void> _sendVerificationEmail() async {
    if (_user != null && !_user!.emailVerified) {
      _start30SecondTimer();
      toastMessage(content: 'Verification email sent. Check your inbox!');
      await _user?.sendEmailVerification();
    }
  }

  @override
  void dispose() {
    _threeSecondTimerForFirstTimeToSendEmail?.cancel();
    _thirtySecondTimer?.cancel();
    _threeSecondContinueTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_user == null) {
      return _buildUserError(context);
    } else {
      return _userHasData();
    }
  }

  Scaffold _buildUserError(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verification'),
          actions: [_gotoLogin()],
        ),
        body: MessageWithButton(
            message: "Please sign in to continue",
            navigateTo: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouteName.login, (route) => false);
            },
            routeName: 'Sign in'));
  }

  Widget _userHasData() {
    if (isEmailVerified == true) {
      return const HomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verification'),
          actions: [_gotoLogin()],
        ),
        body: IndexedStack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please verify your email address.',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Verification link has been sent to ${_user?.email}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed:
                            _thirtySecond == 30 ? _sendVerificationEmail : null,
                        child: const Text('Resend Verification Email'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      _thirtySecond == 30
                          ? const SizedBox.shrink()
                          : Text("After  $_thirtySecond second")
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  IconButton _gotoLogin() {
    return IconButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouteName.login, (route) => false);
        },
        icon: const Icon(Icons.close));
  }

  @override
  bool get wantKeepAlive => true;
}
