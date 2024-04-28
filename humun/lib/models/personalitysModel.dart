import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class PersonalityModel {
  late Interpreter _interpreter;
  bool _isInterpreterInitialized = false;

  PersonalityModel({required String modelPath}) {
    _initializeInterpreter(modelPath);
  }

  Future<void> _initializeInterpreter(String modelPath) async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
      _isInterpreterInitialized = true;
    } catch (e) {
      print("Error initializing interpreter: $e");
      _isInterpreterInitialized = false;
      throw Exception("Failed to initialize interpreter: $e");
    }
  }

  Future<List<double>> predict(List<double> input) async {
    if (!_isInterpreterInitialized) {
      throw Exception("Interpreter is not initialized.");
    }

    List<double> processedInput = _preprocessInput(input);
    Float32List inputBuffer = Float32List.fromList(processedInput);
    Float32List outputBuffer = Float32List(16);
    
    try {
      _interpreter.run([inputBuffer], [outputBuffer]);
    } catch (e) {
      print("Error running interpreter: $e");
      throw Exception("Failed to run interpreter: $e");
    }

    return outputBuffer.toList();
  }

  List<double> _preprocessInput(List<double> input) {
    List<double> normalizedInput = input.map((e) => e / 255.0).toList();
    List<double> reshapedInput = normalizedInput.expand((e) => [e, 1.0]).toList();
    return reshapedInput;
  }
  

  void close() {
    _interpreter.close();
  }

}
