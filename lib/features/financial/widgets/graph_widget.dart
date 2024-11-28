import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/models/response/breakdown_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  final List<BreakdownModel> breakdown;
  final double maxValue;

  const _BarChart(this.breakdown, this.maxValue);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(),
        titlesData: titlesData(context, breakdown),
        borderData: borderData,
        barGroups: barGroups(breakdown),
        gridData: const FlGridData(show: true),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxValue,
      ),
      swapAnimationDuration: const Duration(milliseconds: 0),
    );
  }

  BarTouchData barTouchData() => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.white,
          tooltipPadding: EdgeInsets.all(8.appAdaptive),
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              'R\$ ${rod.toY.round()}',
                 TextStyle(color: Colors.blue, fontSize: 12.appFont, fontWeight: FontWeight.bold),
            );
          },
        ),
      );

  FlTitlesData titlesData(BuildContext context, List<BreakdownModel> list) =>
      FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (list[value.toInt()].period.length < 3) {
                  return Text(
                    list[value.toInt()].period,
                    style: context.textStyles.bodyText
                        .copyWith(fontSize: 10.appFont),
                  );
                } else {
                  return Text(
                    list[value.toInt()].period.substring(0, 3),
                    style: context.textStyles.bodyText
                        .copyWith(fontSize: 10.appFont),
                  );
                }
              }),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color(0xFF354C76),
          Color(0xFF60B3DD),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroups(List<BreakdownModel> list) => list.isEmpty
      ? []
      : list
          .asMap()
          .entries
          .map(
            (entry) => BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  width: 20.appWidth,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.appAdaptive),
                    topRight: Radius.circular(8.appAdaptive),
                  ),
                  toY: entry.value.totalSpent,
                  gradient: _barsGradient,
                )
              ],
            ),
          )
          .toList();
}

class GraphWidget extends StatefulWidget {
  final List<BreakdownModel> breakdown;

  const GraphWidget({super.key, required this.breakdown});

  @override
  State<StatefulWidget> createState() => GraphWidgetState();
}

class GraphWidgetState extends State<GraphWidget> {
  double maxValue = 0;

  @override
  void didUpdateWidget(covariant GraphWidget oldWidget) {
    maxValue = 0;
    for (var element in widget.breakdown) {
      if (maxValue < element.totalSpent) {
        maxValue = element.totalSpent;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: _BarChart(widget.breakdown, maxValue),
    );
  }
}
