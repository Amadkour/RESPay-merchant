import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final double width = 16;
  bool isDummy = false;
  Map<String, dynamic> displayData = <String, dynamic>{};
  @override
  void initState() {
    super.initState();
    displayData.clear();
    displayData.addAll(widget.data);
    isDummy = widget.data.isEmpty;
    if (displayData.isEmpty) {
      displayData.addAll(<String, dynamic>{
        "Jan": 120,
        "Feb": 400,
        "Mar": 20,
        "Apr": 160,
        "May": 80,
        "Jun": 300,
      });
    }
    if (displayData.length < 3) {
      displayData.addAll(<String, dynamic>{
        "dummy": 0,
        "dummy1": 0,
        "dummy2": 0,
        "dummy3": 0,
        "dummy4": 0,
        "dummy5": 0,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(globalKey.currentContext!).size;
    double maxY = 0;

    maxY = (displayData.values.reduce(
                (dynamic value, dynamic element) => max<double>((value as num).toDouble(), (element as num).toDouble()))
            as num)
        .toDouble();

    return SizedBox(
      height: size.height * .30,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (BarChartGroupData a, int b, BarChartRodData c, int d) => null,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: maxY > 100000
                    ? 100000
                    : maxY > 10000
                        ? 5000
                        : maxY > 1000
                            ? 600
                            : maxY > 100
                                ? 100
                                : 10,
                getTitlesWidget: (double value, TitleMeta meta) => leftTitles(value, meta, maxY),
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
                reservedSize: 42,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: List<BarChartGroupData>.generate(displayData.length, (int index) {
            return makeGroupData(index, 0, (displayData.values.elementAt(index) as num).toDouble());
          }),
          gridData: FlGridData(
            show: false,
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta, double maxY) {
    const TextStyle style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    if (value.toInt() + meta.appliedInterval >= maxY && value.toInt() != maxY) {
      return const SizedBox();
    } else {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(
          meta.formattedValue,
          style: style,
        ),
      );
    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      displayData.keys.elementAt(value.toInt()).contains('dummy') ? "" : displayData.keys.elementAt(value.toInt()),
      style: TextStyle(
        color: isDummy ? AppColors.greyColor : AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 16,
      x: x,
      barRods: <BarChartRodData>[
        BarChartRodData(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(5),
          ),
          toY: y2,
          color: isDummy ? AppColors.greyColor : AppColors.blueColor,
          width: width,
        ),
      ],
    );
  }
}
