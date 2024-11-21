import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/features/payment/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceInputWidget extends StatelessWidget {
  final PaymentViewModel paymentViewModel;
  const PriceInputWidget({super.key, required this.paymentViewModel});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: context.textStyles.bodyTextBold.copyWith(
        fontSize: 38.appFont,
      ),
      validator: (value) {
        final numericValue =
            double.tryParse(value?.replaceAll(RegExp(r'[^\d.]'), '') ?? '');

        if (numericValue == null || numericValue <= 0) {
          return 'Valor deve ser maior que 0';
        }
        paymentViewModel.value = numericValue;
        return null;
      },
      onChanged: (value) {
        final formattedValue = value.replaceAll(RegExp(r'[^\d,.]'), '');

        final normalizedValue = formattedValue.replaceAll(',', '.');

        final numericValue = double.tryParse(normalizedValue);

        if (numericValue == null || numericValue <= 0) {
          paymentViewModel.value = 0;
        } else {
          paymentViewModel.value = numericValue;
        }
      },
      decoration: const InputDecoration(
        hintText: 'R\$ 00,00',
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter()
      ],
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
