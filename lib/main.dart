import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TicTacToe(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _matrix;
  late String _currentPlayer;
  late String _winner;
  late int _moves;

  @override
  void initState() {
    super.initState();
    _matrix = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'Messi';
    _winner = '';
    _moves = 0;
  }

  void _checkWinner(int row, int col) {
    for (int i = 0; i < 3; i++) {
      if (_matrix[i][0] == _matrix[i][1] &&
          _matrix[i][1] == _matrix[i][2] &&
          _matrix[i][0].isNotEmpty) {
        setState(() {
          _winner = _matrix[i][0];
        });
      }
      if (_matrix[0][i] == _matrix[1][i] &&
          _matrix[1][i] == _matrix[2][i] &&
          _matrix[0][i].isNotEmpty) {
        setState(() {
          _winner = _matrix[0][i];
        });
      }
    }
    if (_matrix[0][0] == _matrix[1][1] &&
        _matrix[1][1] == _matrix[2][2] &&
        _matrix[0][0].isNotEmpty) {
      setState(() {
        _winner = _matrix[0][0];
      });
    }
    if (_matrix[0][2] == _matrix[1][1] &&
        _matrix[1][1] == _matrix[2][0] &&
        _matrix[0][2].isNotEmpty) {
      setState(() {
        _winner = _matrix[0][2];
      });
    }
  }

  void _resetGame() {
    setState(() {
      _matrix = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'Messi';
      _winner = '';
      _moves = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Alu Plus',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                String assetName = _matrix[row][col].toLowerCase();

                return GestureDetector(
                  onTap: () {
                    if (_matrix[row][col].isEmpty && _winner.isEmpty) {
                      setState(() {
                        _matrix[row][col] = _currentPlayer;
                        _checkWinner(row, col);
                        _currentPlayer = (_currentPlayer == 'Messi') ? 'Ronaldo' : 'Messi';
                        _moves++;
                        if (_moves == 9 && _winner.isEmpty) {
                          _winner = 'Draw';
                        }
                      });
                    }
                  },
                  child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: _matrix[row][col].isNotEmpty
                          ? SvgPicture.asset('assets/$assetName.svg', width: 50, height: 50)
                          : const SizedBox(),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          _winner.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _winner == 'Draw' ? 'No Winner: Draw' : 'Winner: $_winner',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          )
              : Text(
            'Turn: $_currentPlayer',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          _winner.isNotEmpty
              ? ElevatedButton(
            onPressed: _resetGame,
            child: const Text(
              'Reset Game',
              style: TextStyle(fontSize: 20.0),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
