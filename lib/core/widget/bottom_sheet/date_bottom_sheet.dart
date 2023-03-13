import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';

Future<void> showActiveDateSheet(
  BuildContext context,
  void Function(String) onChange,
  String? date,
) {
  String month = "01";
  String year = (DateTime.now().year).toString();
  if (date != null && date.isNotEmpty) {
    month = date.split("/").first;
    year = date.split("/").last;
  }
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).nextFocus();

                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close,
                              color: Colors.black, size: 15),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                              flex: 2,
                              child: months(
                                context,
                                (String v) {
                                  month = v;
                                },
                                month,
                              )),
                          Expanded(
                              flex: 2,
                              child: years(
                                context,
                                (String v) {
                                  year = v;
                                },
                                year,
                              )),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: LoadingButton(
                            key: confirmDateKey,
                            topPadding: 0,
                            isLoading: false,
                            title: tr("done"),
                            onTap: () {
                              final String date = '$month/$year';
                              onChange(date);

                              CustomNavigator.instance.pop();
                              FocusScope.of(context).nextFocus();
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )).whenComplete(() => FocusScope.of(context).nextFocus());
}

Widget months(
    BuildContext context, ValueChanged<String> onMonthChanged, String month) {
  final List<String> monthValue = <String>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  final int index = monthValue.indexOf(month);

  final List<String> sub = monthValue.sublist(0, index);
  monthValue.removeRange(0, index);
  monthValue.addAll(sub);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        tr('month'),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoPicker(
          key: const ValueKey<String>('month'),
          itemExtent: 50,
          looping: true,
          onSelectedItemChanged: (int index) {
            onMonthChanged(monthValue[index]);
          },
          children: monthValue.map((String i) {
            return Center(
              key: ValueKey<String>(i),
              child: Text(i, style: const TextStyle(fontSize: 24)),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget years(
    BuildContext context, ValueChanged<String> onYearChanged, String year) {
  final List<int> yearValues =
      List<int>.generate(100, (int index) => DateTime.now().year + index);

  return Column(
    key: yearsDateListKey,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        tr('year'),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: CupertinoPicker(
          key: const ValueKey<String>('year'),
          itemExtent: 50,
          looping: true,
          useMagnifier: true,
          onSelectedItemChanged: (int index) {
            onYearChanged(yearValues[index].toString());
          },
          children: yearValues.map((int i) {
            return Center(
              child: Text(
                i.toString(),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}
