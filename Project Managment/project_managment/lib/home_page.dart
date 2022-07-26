import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String count = "";
  final tileText = ["OneText", "TwoText", "ThreeText"];
  final tileLabel = ["OneLabel", "TwoLabel", "ThreeLabel"];
  List tileValues = ["", "", ""];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home Page')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Item Count : $count"),
              Text("Value of first  text feild " + tileValues[1]),
              Expanded(
                child: ListView.builder(
                  itemCount: tileText.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTilePage(tileLabel[index], tileText[index],
                            (receivedValue) {
                          setState(() {
                            tileValues[index] = receivedValue;
                          });
                        }),
                        ListTilePage(tileLabel[index], tileText[index],
                            (receivedValue) {
                          setState(() {
                            tileValues[index] = receivedValue;
                          });
                        })
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListTilePage extends StatelessWidget {
  final String tilelabel;
  final String tileText;
  String tileValue = "";

  Function provideValueCallback;

  ListTilePage(this.tilelabel, this.tileText, this.provideValueCallback);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: tileText,
          hintText: tilelabel),
      onChanged: (text) {
        tileValue = text;
        provideValueCallback(tileValue);
      },
    );
  }
}
