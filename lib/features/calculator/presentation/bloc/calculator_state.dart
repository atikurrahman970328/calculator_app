import 'package:equatable/equatable.dart';
import '../../data/models/history_model.dart';

class CalculatorState extends Equatable {
  final String input;
  final String result;
  final List<HistoryModel> history;

  const CalculatorState({
    required this.input,
    required this.result,
    required this.history,
  });

  factory CalculatorState.initial() {
    return const CalculatorState(
      input: '',
      result: '0',
      history: [],
    );
  }

  CalculatorState copyWith({
    String? input,
    String? result,
    List<HistoryModel>? history,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [input, result, history];
}