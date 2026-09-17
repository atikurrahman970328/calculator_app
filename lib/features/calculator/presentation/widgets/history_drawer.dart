import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';

class HistoryDrawer extends StatelessWidget {
  const HistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppConstants.historyTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      context.read<CalculatorBloc>().add(ClearHistoryEvent());
                    },
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  if (state.history.isEmpty) {
                    return const Center(
                      child: Text(
                        AppConstants.noHistoryText,
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      final item = state.history[index];
                      return ListTile(
                        title: Text(
                          item.expression,
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        subtitle: Text(
                          '= ${item.result}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}