import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DVIC - Label Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? bytes;

  Card generateLabelLayout1(
    String urlImg,
    String urlQR,
    String title,
    String abstract, {
    double titleFontSize = 24,
    String subtitle = "",
    double labelCornerRadius = 60,
    double labelMargin = 50,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(labelCornerRadius),
          side: BorderSide(color: Colors.grey.shade500)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(labelMargin),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(labelCornerRadius - labelMargin),
                    child: Image.network(
                      urlImg,
                      height: 300,
                    ),
                  ),
                  SizedBox(width: labelMargin / 2),
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: QrImage(
                      data: urlQR,
                      version: QrVersions.auto,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: labelMargin / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                      child: Image.asset('assets/favicon.png'),
                    ),
                    SizedBox(width: labelMargin / 2),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: '$title\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: subtitle,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: titleFontSize - 3,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  abstract,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: titleFontSize - 5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text('Project Label Generator',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26)),
                  ),
                  Form(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please add a title';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Subtitle'),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Abstract'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please add a title';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <ElevatedButton>[
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Generate'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final controller = ScreenshotController();
                                    final bytes =
                                        await controller.captureFromWidget(
                                      Material(
                                        child: generateLabelLayout1(
                                          "https://dvic.devinci.fr/api/v3/img/thumbnail/9c3bmr1txthmg7ez1dc3lkg5en0ucr.jpg",
                                          "https://dvic.devinci.fr/projects/educationnal-billard",
                                          "Interactive Pool",
                                          "The interactive pool is a mathematics and physics learning platform using gamification. The research raised the efficiency of games and lives experiences in the learning process. A projector, a camera and an artificial intelligence transform any pool table into an augmented reality platform. Players discover physics and maths concepts with theoretical exercises applied on pool playing. This pedagogic platform can integrate classrooms to enhance students' motivation and learning.",
                                          subtitle:
                                              "Math and Physics Playful Learning",
                                        ),
                                      ),
                                    );
                                    setState((() => this.bytes = bytes));
                                    await FileSaver.instance
                                        .saveFile('projectLabel', bytes, 'png');
                                    print('saved');
                                  },
                                  child: const Text('Download'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: generateLabelLayout1(
                  "https://dvic.devinci.fr/api/v3/img/thumbnail/9c3bmr1txthmg7ez1dc3lkg5en0ucr.jpg",
                  "https://dvic.devinci.fr/projects/educationnal-billard",
                  "Interactive Pool",
                  "The interactive pool is a mathematics and physics learning platform using gamification. The research raised the efficiency of games and lives experiences in the learning process. A projector, a camera and an artificial intelligence transform any pool table into an augmented reality platform. Players discover physics and maths concepts with theoretical exercises applied on pool playing. This pedagogic platform can integrate classrooms to enhance students' motivation and learning.",
                  subtitle: "Math and Physics Playful Learning",
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
