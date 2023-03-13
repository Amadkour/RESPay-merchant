import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/custom_back_button.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';
import 'package:res_pay_merchant/features/search/controller/search_cubit_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.child,
    required this.onChanged,
    required this.hint,
    this.enabled = true,
    this.onTap,
    this.onClear,
  });

  final Widget child;
  final ValueChanged<String> onChanged;
  final String hint;
  final bool enabled;

  final VoidCallback? onTap;
  final VoidCallback? onClear;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final SearchCubit searchCubit = SearchCubit();
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchCubit.onTextChanged(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>.value(
      value: searchCubit,
      child: MainScaffold(
        appBarWidget: AppBar(
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(10), child: SizedBox()),
          leading: const CustomBackButton(),
          title: BlocBuilder<SearchCubit, SearchCubitState>(
            builder: (BuildContext context, SearchCubitState state) =>
                SearchBar(
              hintText: widget.hint,
              controller: searchController,
              onChanged: (String value) {
                widget.onChanged(value);
              },
              onClear: () {
                searchController.text = '';
                widget.onClear?.call();
              },
              showClear: searchController.text.isEmpty,
            ),
          ),
        ),
        scaffold: widget.child,
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }
}
