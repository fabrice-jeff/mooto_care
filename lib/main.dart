import 'package:autocare/utils/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'routes/pages.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor2),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPage.INITIAL,
      getPages: AppPage.routes,
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MainSreenState();
// }

// class _MainSreenState extends State<MyApp> with WidgetsBindingObserver {
//   bool isPermissionGranted = false;
//   late Future<void> _future;
//   CameraController? _cameraController;
//   TextRecognizer _textRecognizer = TextRecognizer();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addObserver(this);
//     _future = _requestCameraPermission();
//   }

//   @override
//   dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//     stopCamera();
//     _textRecognizer.close();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (_cameraController == null || _cameraController!.value.isInitialized) {
//       return;
//     }
//     if (state == AppLifecycleState.inactive) {
//       stopCamera();
//     } else if (state == AppLifecycleState.resumed &&
//         _cameraController != null &&
//         _cameraController!.value.isInitialized) {
//       _startCamera();
//     }
//   }

//   Future<void> _requestCameraPermission() async {
//     final status = await Permission.camera.request();
//     isPermissionGranted = status == PermissionStatus.granted;
//   }

//   void _startCamera() {
//     if (_cameraController != null) {
//       _cameraSelected(_cameraController!.description);
//     }
//   }

//   void stopCamera() {
//     if (_cameraController != null) {
//       _cameraController?.dispose();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FutureBuilder(
//         future: _future,
//         builder: ((context, snapshot) {
//           return Stack(
//             children: [
//               if (isPermissionGranted)
//                 FutureBuilder(
//                   future: availableCameras(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       initCameraController(snapshot.data!);
//                       return Center(
//                         child: CameraPreview(_cameraController!),
//                       );
//                     } else {
//                       return LinearProgressIndicator();
//                     }
//                   },
//                 ),
//               Scaffold(
//                 backgroundColor:
//                     isPermissionGranted ? Colors.transparent : null,
//                 appBar: AppBar(
//                   title: Text("Récupérer du text depuis une image"),
//                 ),
//                 body: isPermissionGranted
//                     ? Column(
//                         children: [
//                           Expanded(
//                             child: Container(),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(bottom: 30),
//                             child: Center(
//                               child: ElevatedButton(
//                                 onPressed: _scanImage,
//                                 child: Text('Scan text'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : Center(
//                         child: Text(
//                           (isPermissionGranted)
//                               ? "Camera perms"
//                               : "Caméra denied",
//                         ),
//                       ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   void initCameraController(List<CameraDescription> cameras) {
//     if (_cameraController != null) {
//       return;
//     }

//     CameraDescription? camera;
//     for (var i = 0; i < cameras.length; i++) {
//       final CameraDescription current = cameras[i];
//       if (current.lensDirection == CameraLensDirection.back) {
//         camera = current;
//         break;
//       }
//     }

//     if (camera != null) {
//       _cameraSelected(camera);
//     }
//   }

//   Future<void> _cameraSelected(CameraDescription camera) async {
//     _cameraController = CameraController(
//       camera,
//       ResolutionPreset.max,
//       enableAudio: false,
//     );
//     await _cameraController?.initialize();
//     if (!mounted) {
//       return;
//     }
//     setState(() {});
//   }

//   Future<void> _scanImage() async {
//     if (_cameraController == null) {
//       return;
//     }
//     try {
//       final pictureFile = await _cameraController!.takePicture();
//       final file = File(pictureFile.path);
//       final inputImage = InputImage.fromFile(file);
//       final recognizedText = await _textRecognizer.processImage(inputImage);
//       await Get.to(ResultScan(text: recognizedText.text));
//     } catch (e) {
//       print('Bonjour');
//     }
//   }
// }


