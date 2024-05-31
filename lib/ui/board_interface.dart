import 'package:flutter/material.dart';

class BoardInterface extends StatelessWidget {
  const BoardInterface({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Board.png"),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8889,
              height: MediaQuery.of(context).size.width * 0.8889,
              child: GridView.count(
                crossAxisCount: 8,
                children: List.generate(64, (index) {
                  return Container(
                    color: getSquareColor(index),
                    child: DragTarget(
                      builder:
                          (context, List<String?> candidateData, rejectedData) {
                        return index == 1 ? const Placeholder() : Container();
                      },
                      onWillAcceptWithDetails: (data) {
                        return true;
                      },
                      onAcceptWithDetails: (data) {},
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialColor getSquareColor(int index) {
    bool evenRow = ((index + 1) / 8).ceil() % 2 == 0;
    if (index % 2 == (evenRow ? 0 : 1)) {
      return Colors.brown;
    } else {
      return Colors.yellow;
    }
  }
}
