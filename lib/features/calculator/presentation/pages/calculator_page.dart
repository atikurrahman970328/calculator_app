import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';
import '../widgets/keypad_widget.dart';
import '../widgets/history_drawer.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<CalculatorBloc>().add(LoadHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HistoryDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // টপ বার (হিস্ট্রি বাটন)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.history, color: Colors.white, size: 28),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  const Text(
                    'Pro Calculator',
                    style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 48), // স্পেসিং ব্যালেন্স করার জন্য
                ],
              ),
            ),
            
            // ডিসপ্লে স্ক্রিন
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Text(
                            state.input.isEmpty ? '0' : state.input,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Text(
                            state.result,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            
            // কিপ্যাড প্যানেল
            const KeypadWidget(),
          ],
        ),
      ),
    );
  }
}