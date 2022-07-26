import 'package:flutter/material.dart';
import 'package:bmi_app/second_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101639),
        ),
        scaffoldBackgroundColor: const Color(0xFF090F31),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("BMI Calculator"),
          ),
          body: const BMICard(),
        ),
      ),
    ),
  );
}

class BMICard extends StatefulWidget {
  const BMICard({Key? key}) : super(key: key);

  @override
  State<BMICard> createState() => _BMICardState();
}

class _BMICardState extends State<BMICard> {
  Color maleCardColor = const Color(0xFF272A4E);
  Color femaleCardColor = const Color(0xFF272A4E);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    maleCardColor = const Color.fromARGB(255, 44, 50, 116);
                    femaleCardColor = const Color(0xFF272A4E);
                  },
                );
              },
              child: GenderCard(
                const Text(
                  "Male",
                  style: TextStyle(color: Colors.grey),
                ),
                const Icon(
                  Icons.male,
                  size: 55,
                ),
                maleCardColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    femaleCardColor = const Color.fromARGB(255, 44, 50, 116);
                    maleCardColor = const Color(0xFF272A4E);
                  },
                );
              },
              child: GenderCard(
                const Text("Female", style: TextStyle(color: Colors.grey)),
                const Icon(
                  Icons.female,
                  size: 55,
                ),
                femaleCardColor,
              ),
            ),
          ],
        ),
        const DecoratedSlider(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [AgeBottomContainer(), WeightBottomContainer()],
        ),
        const BottomButton(),
      ],
    );
  }
}

class GenderCard extends StatelessWidget {
  final Text cardtext;
  final Icon cardicon;
  final Color cardColor;

  GenderCard(this.cardtext, this.cardicon, this.cardColor);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardicon,
          const SizedBox(height: 20),
          cardtext,
        ],
      ),
      cardColor,
      150,
    );
  }
}

class DecoratedSlider extends StatefulWidget {
  const DecoratedSlider({Key? key}) : super(key: key);

  @override
  State<DecoratedSlider> createState() => _DecoratedSliderState();
}

class _DecoratedSliderState extends State<DecoratedSlider> {
  double sliderValue = 100;
  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "HEIGHT",
            style: TextStyle(color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sliderValue.round().toString(),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                "cm",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
          SliderTheme(
              data: const SliderThemeData(
                  activeTrackColor: Color(0xFFEB1555),
                  inactiveTrackColor: Color(0xFF8D8E98),
                  thumbColor: Color(0xFFEB1555),
                  overlayColor: Color(0x29EB1555),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 7,
                  )),
              child: Slider(
                min: 100,
                max: 200,
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ))
        ],
      ),
      const Color(0xFF141A3B),
      340,
    );
  }
}

class AgeBottomContainer extends StatefulWidget {
  const AgeBottomContainer({Key? key}) : super(key: key);

  @override
  State<AgeBottomContainer> createState() => _AgeBottomContainerState();
}

class _AgeBottomContainerState extends State<AgeBottomContainer> {
  int ageValue = 15;
  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "AGE",
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          ageValue.toString(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF202745),
            child: IconButton(
              onPressed: () {
                setState(() {
                  ageValue--;
                });
              },
              icon: const Icon(Icons.remove),
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            backgroundColor: const Color(0xFF202745),
            child: IconButton(
              onPressed: () {
                setState(() {
                  ageValue++;
                });
              },
              icon: const Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ]),
      ]),
      const Color(0xFF141A3B),
      150,
    );
  }
}

class WeightBottomContainer extends StatefulWidget {
  const WeightBottomContainer({Key? key}) : super(key: key);

  @override
  State<WeightBottomContainer> createState() => _WeightBottomContainerState();
}

class _WeightBottomContainerState extends State<WeightBottomContainer> {
  int weightValue = 15;
  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "WEIGHT",
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          weightValue.toString(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF202745),
            child: IconButton(
              onPressed: () {
                setState(() {
                  weightValue--;
                });
              },
              icon: const Icon(Icons.remove),
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            backgroundColor: const Color(0xFF202745),
            child: IconButton(
              onPressed: () {
                setState(() {
                  weightValue++;
                });
              },
              icon: const Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ]),
      ]),
      const Color(0xFF141A3B),
      150,
    );
  }
}

class DecoratedCard extends StatelessWidget {
  final Column cardcolumn;
  final Color cardcolor;
  double cardwidth;

  DecoratedCard(this.cardcolumn, this.cardcolor, this.cardwidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardwidth,
      height: 125,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardcolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: cardcolumn),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SecondScreen();
            },
          ),
        );
      },
      child: Container(
        child: const Center(
          child: Text(
            'CALCULATE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: const Color(0xFFEB1555),
        margin: const EdgeInsets.only(top: 10.0),
        width: 330,
        height: 30,
      ),
    );
  }
}
