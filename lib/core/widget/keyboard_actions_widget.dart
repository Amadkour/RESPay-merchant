import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';

class KeyboardActionsWidget extends StatelessWidget {
  const KeyboardActionsWidget({
    super.key,
    required this.child,
    required this.focusNodeModels,
  });

  final Widget child;
  final List<FocusNodeModel> focusNodeModels;

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: KeyboardActionsConfig(
          keyboardBarColor: Colors.grey[200],
          actions: <KeyboardActionsItem>[
            ...List<KeyboardActionsItem>.generate(
              focusNodeModels.length,
              (int index) => KeyboardActionsItem(
                focusNode: focusNodeModels[index].focusNode,
                onTapAction: focusNodeModels[index].onTap
              ),
            )
          ]),
      child: child,
    );
  }
}
