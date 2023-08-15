import 'package:flutter/material.dart';

import '../../../core/config/route/route_name.dart';
import '../repositories/user_repository.dart';
///this will usully called after the login and registration profress
void navOrVerificationPageDistinguinter(BuildContext context){
                   UserRepository.getInstance().currentUser!.emailVerified
      ? Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouteName.navbar, (route) => false)
      : Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouteName.verificationPage, (route) => false);
                  

}