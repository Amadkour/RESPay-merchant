import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';

// ignore: must_be_immutable
class DateTextField extends StatefulWidget {
  late TextEditingController dateController;
  late String dateControllerError;
  FocusNode? focusNode;
  late bool fromSupAccount;
  String? dateTitle;
  String? dateHint;
  bool? readOnly;
  Color? color;
  late bool hasClearButton;
  VoidCallback? onClear;
  Key? clearButtonKey;
  Key? textFieldKey;
  void Function()? onChanged;
  bool _isFilter = false;

  DateTextField({
    super.key,
    this.onChanged,
    required this.dateController,
    this.focusNode,
    required this.dateControllerError,
    this.clearButtonKey,
    this.textFieldKey,
    this.readOnly = false,
    this.fromSupAccount = false,
    this.dateTitle,
    this.dateHint,
    this.color,
    this.hasClearButton = false,
    this.onClear,
  });

  DateTextField.filter({
    this.onClear,
    required this.dateController,
    this.clearButtonKey,
    this.textFieldKey,
    this.dateHint,
    this.dateTitle,
    this.focusNode,
  }) {
    fromSupAccount = false;
    hasClearButton = true;
    dateControllerError = '';
    color = AppColors.backgroundColor;
    readOnly = false;
    _isFilter = true;
  }

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  void initState() {
    widget.focusNode!.addListener(() {
      if (!widget.readOnly! && widget.focusNode!.hasFocus) {
        dateSheet(
            context: context,
            dateController: widget.dateController,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            mustAdult: !widget.hasClearButton);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentTextField(
      key: widget.textFieldKey,
      controller: widget.dateController,
      fillColor: widget.color,
      keyboardType: TextInputType.none,
      hint: tr(widget.dateHint!),
      focusNode: widget.focusNode,
      readOnly: true,
      title: tr(widget.dateTitle!),
      error: widget.dateControllerError,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MyImage.svgAssets(
            url: 'assets/images/registration/calendar.svg',
            key: const ValueKey<String>('register_Date_icon'),
            height: 20,
            width: 20,
            fit: BoxFit.none,
          ),
          if (widget.hasClearButton)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
              child: InkWell(
                key: widget.clearButtonKey,
                onTap: () {
                  widget.dateController.text = '';
                  widget.onClear?.call();
                },
                child: const Icon(
                  Icons.close_sharp,
                  color: Colors.grey,
                ),
              ),
            )
        ],
      ),
      validator: !widget._isFilter
          ? (String? value) {
              if (value != null) {
                if (DateTime.tryParse(value)?.isUnderAge() == false) {
                  return null;
                } else {
                  return "birth data must be upper than 18 years";
                }
              }
              return null;
            }
          : null,
    );
  }
}

void dateSheet(
        {required BuildContext context,
        required TextEditingController dateController,
        VoidCallback? onChanged,
        FocusNode? focusNode,
        required bool mustAdult}) =>
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            height: MediaQuery.of(context).copyWith().size.height / 2.5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      key: datePickedButtonKey,
                      onPressed: () {
                        if (dateController.text == '') {
                          if (mustAdult) {
                            dateController.text = DateFormat('yyyy-MM-dd')
                                .format(DateTime.now().subtract(
                                    const Duration(days: 6574, hours: 2)));
                          } else {
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(DateTime.now());
                          }
                        }
                        CustomNavigator.instance.pop();
                        focusNode?.nextFocus();
                      },
                      icon: Icon(
                        Icons.done,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    key: const Key("date_picker"),
                    initialDateTime: dateController.text == ''
                        ? DateTime.now()
                            .subtract(const Duration(days: 6574, hours: 2))
                        : DateTime.tryParse(dateController.text) != null
                            ? DateTime.parse(dateController.text)
                            : DateTime.parse(
                                sl<ProfileCubit>().profileModel!.dob!),
                    onDateTimeChanged: (DateTime newDate) {
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(newDate);

                      onChanged?.call();
                    },
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                  ),
                ),
              ],
            ),
          );
        }).whenComplete(() => focusNode?.nextFocus());
