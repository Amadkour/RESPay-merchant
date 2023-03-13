import 'package:flutter/material.dart';

class TransferTypeTitle extends StatelessWidget {
  final String title;
  const TransferTypeTitle({
    super.key,required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(
        color: const Color(0xff2E3B4C).withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.w700,letterSpacing: 1
    ));
  }
}
