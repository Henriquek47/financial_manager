import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/models/response/breakdown_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  final List<BreakdownModel> breakdown;

  const _BarChart(this.breakdown);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData(context, breakdown),
        borderData: borderData,
        barGroups: barGroups(breakdown),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 10000, // Definindo maxY dinamicamente
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
              ),
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

  List<BarChartGroupData> barGroups(List<BreakdownModel> list) => list
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
          showingTooltipIndicators: [0],
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
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: _BarChart(widget.breakdown),
    );
  }
}
