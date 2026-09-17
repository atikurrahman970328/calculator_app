import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/history_local_datasource.dart';
import '../../data/models/history_model.dart';
import '../../domain/usecases/evaluate_expression.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final EvaluateExpression evaluateExpression;
  final HistoryLocalDataSource historyDataSource;

  CalculatorBloc({
    required this.evaluateExpression,
    required this.historyDataSource,
  }) : super(CalculatorState.initial()) {
    on<NumberPressed>(_onNumberPressed);
    on<OperatorPressed>(_onOperatorPressed);
    on<CalculateResult>(_onCalculateResult);
    on<ClearDisplay>(_onClearDisplay);
    on<DeleteLastInput>(_onDeleteLastInput);
    on<LoadHistoryEvent>(_onLoadHistory);
    on<ClearHistoryEvent>(_onClearHistory);
  }

  void _onNumberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    final updatedInput = state.input + event.number;
    emit(state.copyWith(input: updatedInput));
  }

  void _onOperatorPressed(OperatorPressed event, Emitter<CalculatorState> emit) {
    if (state.input.isEmpty && event.operator != '-') return;
    final updatedInput = state.input + event.operator;
    emit(state.copyWith(input: updatedInput));
  }

  void _onCalculateResult(CalculateResult event, Emitter<CalculatorState> emit) async {
    if (state.input.isEmpty) return;

    final resultStr = evaluateExpression(state.input);
    
    // সফল হিসাব হলে হিস্ট্রিতে সেভ করা
    if (resultStr != 'Invalid Expression' && resultStr != 'Cannot divide by zero') {
      final historyItem = HistoryModel(
        expression: state.input,
        result: resultStr,
        timestamp: DateTime.now(),
      );
      await historyDataSource.addHistory(historyItem);
    }

    final updatedHistory = historyDataSource.getHistory();
    emit(state.copyWith(
      result: resultStr,
      history: updatedHistory,
    ));
  }

  void _onClearDisplay(ClearDisplay event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(input: '', result: '0'));
  }

  void _onDeleteLastInput(DeleteLastInput event, Emitter<CalculatorState> emit) {
    if (state.input.isNotEmpty) {
      final updatedInput = state.input.substring(0, state.input.length - 1);
      emit(state.copyWith(input: updatedInput));
    }
  }

  void _onLoadHistory(LoadHistoryEvent event, Emitter<CalculatorState> emit) {
    final history = historyDataSource.getHistory();
    emit(state.copyWith(history: history));
  }

  void _onClearHistory(ClearHistoryEvent event, Emitter<CalculatorState> emit) async {
    await historyDataSource.clearHistory();
    emit(state.copyWith(history: []));
  }
}