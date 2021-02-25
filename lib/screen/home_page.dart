import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var entries = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  bool turn1 = true;
  int winner = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic tac toe"),
        backgroundColor: HexColor("#310f7a"),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(10),
          color: HexColor('#551eba'),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 3,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(9, (index) {
                  return GestureDetector(
                    onTap: () {
                      print('winner is ${winner.toString()}');
                      if (entries[index] != 0 || winner != 0) {
                        return;
                      }
                      setState(() {
                        entries[index] = turn1 ? 1 : 2;
                        turn1 = !turn1;
                      });
                      checkResult(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#49169c"),
                        borderRadius: BorderRadius.circular(1.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: entries[index] == 0
                          ? SizedBox()
                          : (entries[index] == 1
                              ? Image(image: AssetImage('assets/x.jpg'))
                              : Image(image: AssetImage('assets/o.jpg'))),
                    ),
                  );
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Text(
                          "Player 1",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/x.jpg'),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Text(
                          "Player 2",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/o.jpg'),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.grey[200],
              ),
              Center(
                child: turn1
                    ? Text(
                        "Player 1 turn",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        "Player 2 turn",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    entries = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                    turn1 = true;
                    winner = 0;
                  });
                },
                child: Icon(Icons.restore_outlined),
              ),
              Divider(),
              winner == 0
                  ? SizedBox()
                  : Text(
                      "Winner is player" + winner.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void showWinner(BuildContext context, player) {
    if (player == 0) {
      return;
    }
    setState(() {
      winner = player;
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Winner is player ' + player.toString()),
        duration: const Duration(seconds: 5),
        backgroundColor: HexColor("#3d198a"),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Reset?",
          onPressed: () {
            setState(
              () {
                entries = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                turn1 = true;
                winner = 0;
              },
            );
          },
        ),
      ),
    );
  }

  void checkResult(BuildContext context) {
    if (entries[0] == entries[1] && entries[0] == entries[2]) {
      showWinner(context, entries[0]);
    } else if (entries[3] == entries[4] && entries[3] == entries[5]) {
      showWinner(context, entries[4]);
    } else if (entries[6] == entries[7] && entries[6] == entries[8]) {
      showWinner(context, entries[7]);
    } else if (entries[0] == entries[3] && entries[3] == entries[6]) {
      showWinner(context, entries[0]);
    } else if (entries[1] == entries[4] && entries[4] == entries[7]) {
      showWinner(context, entries[1]);
    } else if (entries[2] == entries[5] && entries[2] == entries[8]) {
      showWinner(context, entries[2]);
    } else if (entries[0] == entries[4] && entries[0] == entries[8]) {
      showWinner(context, entries[0]);
    } else if (entries[2] == entries[4] && entries[2] == entries[6]) {
      showWinner(context, entries[2]);
    } else if (entries.where((entry) => entry == 0).length == 0) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('The game is draw '),
          duration: const Duration(seconds: 5),
          backgroundColor: HexColor("#3d198a"),
          action: SnackBarAction(
            textColor: Colors.white,
            label: "Reset?",
            onPressed: () {
              setState(() {
                entries = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                turn1 = true;
                winner = 0;
              });
            },
          ),
        ),
      );
    }
  }
}
