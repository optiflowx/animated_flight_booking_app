import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/view_provider.dart';
import 'confirmation_button.dart';

class ButtonNavigationView extends StatelessWidget {
  const ButtonNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final currentView = ref.watch(viewProvider);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          padding: EdgeInsets.only(
            bottom: bottom,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: currentView == 0 ? 10 : 25,
                spreadRadius: currentView == 0 ? 10 : 25,
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: ConfirmationButton(),
        );
      },
    );
  }
}
