import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/invite_friend.dart';

import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/schedule_call_body.dart';

Future<dynamic> scheduleCallBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,

    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
          height: context.height*.65,
          child:
      const ScheduleCallBody());
    },
  );
}


Future<dynamic> inviteFriendBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
    context: context,
    elevation: 100,
    builder: (BuildContext context) {
      return const InviteFriendBottomSheetBody();
    },
  );
}
