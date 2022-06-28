import 'dart:html';
import 'dart:typed_data';
import 'package:dvic_label_generator/components/label_generator.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  final _formKey = GlobalKey<FormState>();
  final urlProject = TextEditingController();
  final urlThumbnail = TextEditingController();
  final title = TextEditingController();
  final subtitle = TextEditingController();
  final abstract = TextEditingController();
  final group = TextEditingController();

  Uint8List? bytes;
  Transform? generatedLabel;
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    generatedLabel = generateLabelLayout1(
      "https://dvic.devinci.fr/api/v3/img/thumbnail/9c3bmr1txthmg7ez1dc3lkg5en0ucr.jpg",
      "https://dvic.devinci.fr/projects/educationnal-billard",
      "Interactive Pool",
      group: "Artificial Lives",
      subtitle: "Math and Physics Playful Learning",
      abstract:
          "The interactive pool is a mathematics and physics learning platform using gamification. The research raised the efficiency of games and lives experiences in the learning process. A projector, a camera and an artificial intelligence transform any pool table into an augmented reality platform. Players discover physics and maths concepts with theoretical exercises applied on pool playing. This pedagogic platform can integrate classrooms to enhance students' motivation and learning.",
      authors: ['Maxime BROUSSART', 'Louis GEISLER', 'Axel THEVENOT'],
      supervisors: ['Clément DUHART'],
    );
  }

  @override
  void dispose() {
    urlProject.dispose();
    urlThumbnail.dispose();
    title.dispose();
    subtitle.dispose();
    abstract.dispose();
    super.dispose();
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Text('Project Label Generator',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              ),
              Form(
                key: _formKey,
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: urlProject,
                        decoration:
                            const InputDecoration(labelText: 'Project URL'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the project's URL";
                          } else if (!Uri.tryParse(value)!.isAbsolute) {
                            return 'Enter a valid URL';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: urlThumbnail,
                        decoration:
                            const InputDecoration(labelText: 'Thumbnail URL'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the project's thumbnail URL";
                          } else if (!Uri.tryParse(value)!.isAbsolute) {
                            return 'Enter a valid URL';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField(
                        value: dropdownValue,
                        decoration: const InputDecoration(labelText: 'Group'),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'None',
                          'Artificial Lives',
                          'Human Learning',
                          'Resilient Futures'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: subtitle,
                        decoration:
                            const InputDecoration(labelText: 'Subtitle'),
                      ),
                      TextFormField(
                        controller: abstract,
                        decoration:
                            const InputDecoration(labelText: 'Abstract'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <ElevatedButton>[
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    generatedLabel = generateLabelLayout1(
                                      urlThumbnail.text,
                                      urlProject.text,
                                      title.text,
                                      group: dropdownValue!,
                                      subtitle: subtitle.text,
                                      abstract: abstract.text,
                                    );
                                  }
                                });
                              },
                              child: const Text('Generate'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final controller = ScreenshotController();
                                final bytes =
                                    await controller.captureFromWidget(
                                  delay: const Duration(milliseconds: 10),
                                  Material(
                                    child: generatedLabel,
                                  ),
                                );
                                setState((() => this.bytes = bytes));
                                await FileSaver.instance.saveFile(
                                    '${title.text}_Label.png', bytes, 'png');
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
                child: generatedLabel,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
