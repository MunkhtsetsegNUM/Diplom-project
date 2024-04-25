import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class PersonalityModel {
  late Interpreter _interpreter;
  bool _isInterpreterInitialized = false;

  PersonalityModel({required String modelPath}) {
    _initializeInterpreter(modelPath);
  }

  Future<void> _initializeInterpreter(String modelPath) async {
    _interpreter = await Interpreter.fromAsset(modelPath);
    _isInterpreterInitialized = true;
  }

  Future<List<double>> predict(List<double> input) async {
    if (!_isInterpreterInitialized) {
      throw Exception("Interpreter is not initialized.");
    }

    final inputBuffer = Float32List.fromList(input);
    final inputs = [inputBuffer];

    final outputs = <ByteBuffer>[];
    final outputBuffer = Float32List(16).buffer;
    outputs.add(outputBuffer);

    _interpreter.run(inputs, outputs);

    final List<double> outputList = Float32List.view(outputBuffer).toList();

    return outputList;
  }

  void close() {
    _interpreter.close();
  }
}
