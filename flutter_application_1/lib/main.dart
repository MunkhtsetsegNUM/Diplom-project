import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  late Interpreter _interpreter;
  final List<String> characters = [
    'ENFP', 'ISFP', 'INFJ', 'ISTP', 'ENFJ', 'INTJ', 'ENTI', 'ESFP', 
    'INFP', 'INTP', 'ISTI', 'ENTP', 'ISFJ', 'ESTI', 'ESTP', 'ESFJ'
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/converted_model.tflite');
    setState(() {});
  }

  List<double> padSequence(List<double> sequence, int maxlen) {
    List<double> padded = List.filled(maxlen, 0.0);
    for (int i = 0; i < sequence.length; i++) {
      if (i < maxlen) {
        padded[i] = sequence[i];
      }
    }
    return padded;
  }

  Future<void> predictCharacter() async {
    if (_interpreter == null) {
      return;
    }

    List<double> X_test_custom = [
      0, 0, -1, 0, 2, 0, 1, 0, 1, 0, 0, -2, 2, -2, 1, -1, -2, 1, 2, 2, 
      0, -1, 0, 0, 0, -2, -2, 0, 1, -1, 0, 0, 2, 0, -1, 0, -3, 0, 2, 
      -1, -1, -3, 0, -2, -2, 0, -2, 0, 1, 0, 0, 0, 0, 0, -1, -1, 0, -2, 0, 1
    ];

    List<double> paddedSequence = padSequence(X_test_custom, 60);

    var input = List.generate(60, (index) => [paddedSequence[index]]);
    var output = List.filled(1, List.filled(characters.length, 0.0));


    _interpreter.run(input, output);

    int predictedIndex = output[0].indexWhere((element) => element == output[0].reduce((curr, next) => curr > next ? curr : next));

    print("The most probable character is: ${characters[predictedIndex]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character Prediction"),
      ),
      body: Center(
        child: _interpreter == null
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: predictCharacter,
                child: Text("Predict Character"),
              ),
      ),
    );
  }
}

extension ReshapeExtension on List {
  List<List<T>> reshape<T>(List<int> shape) {
    int total = shape.reduce((value, element) => value * element);
    if (total != this.length) throw ArgumentError("Shape is incompatible with list length");

    List<List<T>> result = [];
    for (int i = 0; i < shape[0]; i++) {
      List<T> subList = [];
      for (int j = 0; j < shape[1]; j++) {
        subList.add(this[i * shape[1] + j] as T);
      }
      result.add(subList);
    }
    return result;
  }
}
