import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData(context),
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
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

  Widget getTitles(double value, TitleMeta meta, BuildContext context) {
    final style = context.textStyles.bodyTextDescription.copyWith(fontSize: 12.appAdaptive);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData  titlesData(BuildContext context) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) => getTitles(value, meta, context),
          ),
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

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 8,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 10,
               
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 14,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 15,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 13,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              width: 30.appWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.appAdaptive),
                topRight: Radius.circular(12.appAdaptive),
              ),
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class GraphWidget extends StatefulWidget {
  const GraphWidget({super.key});

  @override
  State<StatefulWidget> createState() => GraphWidgetState();
}

class GraphWidgetState extends State<GraphWidget> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.9,
      child: _BarChart(),
    );
  }
}
