import 'package:base_project/core/localization/generated/l10n.dart';
import 'package:base_project/core/services/connectivity_check/cubit/connectivity_cubit.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../connectivity_check/cubit/connectivity_state.dart';

class AppLifecycleWrapper extends StatefulWidget {
  final Widget child;

  const AppLifecycleWrapper({super.key, required this.child});

  @override
  State<AppLifecycleWrapper> createState() => _AppLifecycleWrapperState();
}

class _AppLifecycleWrapperState extends State<AppLifecycleWrapper>
    with WidgetsBindingObserver {
  bool _hasShownSnackBar = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Called when app comes to foreground
        context.read<ConnectivityCubit>().checkConnectionOnResume();
        break;

      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state.status.isDisconnected && !_hasShownSnackBar) {
          _hasShownSnackBar = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: state.message ?? S.of(context).NoInternetConnection,
              ),
              duration: const Duration(days: 1),
            ),
          );
        } else if (state.status.isConnected) {
          _hasShownSnackBar = false;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: widget.child,
    );
  }
}
