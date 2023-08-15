import '../../core/config/route/route_name.dart';
import '../auth/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/blocs/user_cubit/user_cubit.dart';


///this will help to redirect the page base on 
///user state
class LoadRQM extends StatefulWidget {
  const LoadRQM({super.key});

  @override
  State<LoadRQM> createState() => _LoadRQMState();
}

class _LoadRQMState extends State<LoadRQM> {
  @override
  void initState() {
    context.read<UserCubit>().currentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserAuthenticatedState) {
            UserRepository.getInstance().currentUser!.emailVerified
                ? Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouteName.navbar, (route) => false)
                : Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouteName.login, (route) => false);
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRouteName.login, (route) => false);
          }
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}
