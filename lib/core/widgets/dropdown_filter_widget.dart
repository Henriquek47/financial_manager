import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:flutter/material.dart';

class DropdownFilterWidget extends StatefulWidget {
  final Function(int value) onTap;
  const DropdownFilterWidget({super.key, required this.onTap});

  @override
  State<DropdownFilterWidget> createState() => _DropdownFilterWidgetState();
}

class _DropdownFilterWidgetState extends State<DropdownFilterWidget> {
    Map<int, String> filter = {0: 'Semanal', 1: 'Mensal', 2: 'Anual'};
 


  MapEntry<int, String>? _selected;

  @override
  void initState() {
    super.initState();
       _selected = filter.entries.first;
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
        items: filter.entries
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
            _selected = filter.entries.firstWhere(
              (entry) => entry.key == value,
            );
          });
          widget.onTap.call(value!);
        },
      ),
    );
  }
}
