import 'dart:async';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:smarterchat/helpers/app_helper.dart';
import 'package:smarterchat/helpers/camera_helper.dart';
import 'package:smarterchat/helpers/tflite_helper.dart';
import 'package:smarterchat/models/result.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DetectScreen extends StatefulWidget {
  String meetingId;
  String username;
  DetectScreen(
      {Key? key,
      required this.title,
      required this.meetingId,
      required this.username})
      : super(key: key);

  final String title;
  @override
  _DetectScreenState createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  Animation? _colorTween;
  final FlutterTts flutterTts = FlutterTts();
  StreamSubscription<List<Result>>? listener;
  List<Result> outputs = [];
  String previousPresentation = "";
  void initState() {
    super.initState();

    TFLiteHelper.loadModel().then((value) {
      setState(() {
        TFLiteHelper.modelLoaded = true;
      });
    });

    CameraHelper.initializeCamera();

    listener = TFLiteHelper.tfLiteResultsController.stream.listen(
        (value) {
          outputs = value;

          if (CameraHelper.isDetecting)
            setState(() {
              CameraHelper.isDetecting = false;
            });
          print(outputs
              .reduce((a, b) => a.confidence > b.confidence ? a : b)
              .label);

          FirebaseFirestore.instance
              .collection("meetings")
              .doc(widget.meetingId)
              .update({
            "sign":
                "${widget.username} Says: ${outputs.reduce((a, b) => a.confidence > b.confidence ? a : b).label} \n (Detected By SmarterChat)"
          });
        },
        onDone: () {},
        onError: (error) {
          AppHelper.log("listen", error);
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: CameraHelper.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              width: width,
              child: CameraPreview(
                CameraHelper.camera!,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    CameraHelper.camera!.dispose();
    AppHelper.log("dispose", "Clear resources.");
    super.dispose();
  }

  Widget _buildResultsWidget(double width, List<Result> outputs) {
    Future speak(String s) async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(s);
    }

    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 200.0,
          width: width,
          color: Colors.white,
          child: outputs != null && outputs.isNotEmpty
              ? ListView.builder(
                  itemCount: outputs.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text(
                          outputs[index].label,
                          style: TextStyle(
                            color: _colorTween!.value,
                            fontSize: 20.0,
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              speak("${outputs[index].label}");
                            },
                            child: Icon(
                              Icons.play_arrow,
                              size: 60,
                              color: Color(0xff375079),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
              : Center(
                  child: Text("Wating for model to detect..",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ))),
        ),
      ),
    );
  }
}
