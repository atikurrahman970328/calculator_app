import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';

class KeypadWidget extends StatelessWidget {
  const KeypadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'AC', '⌫', '÷', '×',
      '7', '8', '9', '-',
      '4', '5', '6', '+',
      '1', '2', '3', '=',
      '0', '.', '(', ')'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.displayAreaColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final btn = buttons[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _getButtonColor(btn),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () => _handleButtonTap(context, btn),
            child: Text(
              btn,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getTextColor(btn),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getButtonColor(String btn) {
    if (['÷', '×', '-', '+', '='].contains(btn)) {
      return AppTheme.accentButtonColor;
    }
    if (['AC', '⌫'].contains(btn)) {
      return AppTheme.secondaryButtonColor;
    }
    return AppTheme.primaryButtonColor;
  }

  Color _getTextColor(String btn) {
    if (['AC', '⌫'].contains(btn)) {
      return Colors.redAccent;
    }
    return Colors.white;
  }

  void _handleButtonTap(BuildContext context, String btn) {
    final bloc = context.read<CalculatorBloc>();
    if (btn == 'AC') {
      bloc.add(ClearDisplay());
    } else if (btn == '⌫') {
      bloc.add(DeleteLastInput());
    } else if (btn == '=') {
      bloc.add(CalculateResult());
    } else if (['÷', '×', '-', '+'].contains(btn)) {
      bloc.add(OperatorPressed(btn));
    } else {
      bloc.add(NumberPressed(btn));
    }
  }
}