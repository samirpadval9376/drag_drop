import 'package:drag_drop/controllers/guess_controller.dart';
import 'package:drag_drop/utils/animal_utils.dart';
import 'package:drag_drop/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guess Game",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Consumer<GuessController>(builder: (context, provider, child) {
            int i = provider.i;
            print("=====================================");
            print("Index: $i");
            print("=====================================");

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      Animal.animals[i]['name'].length,
                      (index) => DragTarget(
                        builder: (context, _, __) {
                          return Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.all(5),
                            color: Colors.grey,
                            child: provider.accepted[index]
                                ? Image.asset(
                                    "assets/images/pieces/${Animal.animals[i]['name'][index].toLowerCase()}.png")
                                : null,
                          );
                        },
                        onWillAccept: (data) {
                          print("=============================");
                          print(
                              "DATA: ${Animal.animals[i]['name'][index]} & data: $data");
                          print("=============================");
                          return data == Animal.animals[i]['name'][index];
                        },
                        onAccept: (data) {
                          setState(() {
                            provider.accepted[index] = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        26,
                        (index) => LongPressDraggable(
                          data: String.fromCharCode(
                            index + 97,
                          ),
                          feedback: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.all(10),
                            color: Colors.grey,
                          ),
                          child: Image.asset(
                            "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
    ;
  }
}
