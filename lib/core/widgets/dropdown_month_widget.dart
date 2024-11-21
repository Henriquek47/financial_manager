import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:flutter/material.dart';

class DropdownMonthWidget extends StatefulWidget {
  final int selected;
  const DropdownMonthWidget({super.key, required this.selected});

  @override
  State<DropdownMonthWidget> createState() => _DropdownMonthWidgetState();
}

class _DropdownMonthWidgetState extends State<DropdownMonthWidget> {
  Map<int, String> months = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
  };


  MapEntry<int, String>? _selected;

  @override
  void initState() {
    super.initState();
     int currentMonth = DateTime.now().month;
       _selected = months.entries.firstWhere((month) => month.key == currentMonth);
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.neutralShade400,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6.appAdaptive),
      ),
      child: DropdownButton<int>(
        underline: const SizedBox.shrink(),
        padding: EdgeInsets.symmetric(vertical: 2.appHeight),
        isDense: true,
        value: _selected!.key,
        items: months.entries
            .map(
              (e) => DropdownMenuItem<int>(
                value: e.key,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.appWidth),
                  child: Text(
                    e.value,
                    style: context.textStyles.bodyText
                        .copyWith(fontSize: 11.appFont, height: 1),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            _selected = months.entries.firstWhere(
              (entry) => entry.key == value,
            );
          });
        },
      ),
    );
  }
}
