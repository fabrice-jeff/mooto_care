import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/pages.dart';
import 'modules/verifications/text_scanner.dart';
import 'utils/colors.dart';
import 'utils/share_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      // home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text(
            'Open Camera to scan',
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TextScanner()));
          },
        ),
      ),
    );
  }
}

// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/material.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String barcode = 'Tap  to scan';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               child: const Text('Scan Barcode'),
//               onPressed: () async {
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => AiBarcodeScanner(
//                       validator: (value) {
//                         return value.startsWith('https://');
//                       },
//                       canPop: false,
//                       onScan: (String value) {
//                         debugPrint(value);
//                         setState(() {
//                           barcode = value;
//                         });
//                       },
//                       onDetect: (p0) {},
//                       onDispose: () {
//                         debugPrint("Barcode scanner disposed!");
//                       },
//                       controller: MobileScannerController(
//                         detectionSpeed: DetectionSpeed.noDuplicates,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Text(barcode),
//           ],
//         ),
//       ),
//     );
//   }
// }

