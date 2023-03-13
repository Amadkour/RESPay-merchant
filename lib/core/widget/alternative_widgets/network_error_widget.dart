import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/error_widget.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key, required this.callback});

  final Future<void> Function() callback;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        scaffold: Scaffold(
            body: MyErrorWidget(
      message: '',
      image: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Icon(
              CupertinoIcons.wifi_slash,
              size: 50,
            ),
            const Text(
              'NETWORK ERROR',
            ),
            LoadingButton(
              isLoading: false,
              title: 'reload',
              onTap: () async {
                APIConnection.instance.networkError = false;

                CustomNavigator.instance.pop();
                await callback();
              },
            )
          ],
        ),
      ),
    )));
  }
}
