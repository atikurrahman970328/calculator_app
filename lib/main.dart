import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'features/calculator/data/models/history_model.dart';
import 'features/calculator/data/datasources/history_local_datasource.dart';
import 'features/calculator/domain/usecases/evaluate_expression.dart';
import 'features/calculator/presentation/bloc/calculator_bloc.dart';
import 'features/calculator/presentation/pages/calculator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Local Storage initialization
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryModelAdapter());
  
  final historyDataSource = HistoryLocalDataSource();
  await historyDataSource.init();

  runApp(CalculatorApp(historyDataSource: historyDataSource));
}

class CalculatorApp extends StatelessWidget {
  final HistoryLocalDataSource historyDataSource;

  const CalculatorApp({super.key, required this.historyDataSource});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalculatorBloc>(
          create: (context) => CalculatorBloc(
            evaluateExpression: EvaluateExpression(),
            historyDataSource: historyDataSource,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Professional Calculator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const CalculatorPage(),
      ),
    );
  }
}