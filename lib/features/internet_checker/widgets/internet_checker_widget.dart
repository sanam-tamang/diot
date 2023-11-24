import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/internet_state_enum.dart';
import '../../../core/widgets/primary_gradient_button.dart';
import '../blocs/internet_status_cubit/internet_status_cubit.dart';

class InternetCheckerWidget extends StatelessWidget {
  const InternetCheckerWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetStatusCubit, InternetStatusState>(
      listener: (context, state) {
        log(state.status.name.toString());
        if (state.status == InternetState.disConected ||
            state.status == InternetState.none) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const AlertDialog(
                    title: Text(
                      "Disconnected!",
                      textAlign: TextAlign.center,
                    ),
                    content: _Content(),
                  ));
        }
      },
      child: child,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'No Internet Connection',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: __TryAgainButton(),
        ),
      ],
    );
  }
}

class __TryAgainButton extends StatelessWidget {
  const __TryAgainButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetStatusCubit, InternetStatusState>(
      listener: (context, state) {
        if (state.status == InternetState.connected) {
          Navigator.of(context).pop();
          log("hello connected");
        }
      },
      builder: (context, state) {
        return PrimaryGradientButton(
            onPress: () {
              state.status == InternetState.connected
                  ? Navigator.of(context).pop()
                  : null;
            },
            label: 'Try again');
      },
    );
  }
}
