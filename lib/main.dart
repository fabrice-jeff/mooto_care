import 'package:autocare/generated_qr_code.dart';
import 'package:autocare/scan_qr_code.dart';
import 'package:autocare/utils/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/pages.dart';
import 'utils/colors.dart';

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
      // home: const HomePage(),
      initialRoute: AppPage.INITIAL,
      getPages: AppPage.routes,
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Qr code Scanner and Generated"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const ScanQrCode(),
//                     ),
//                   );
//                 });
//               },
//               child: Text("Scan Qr Code"),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const GeneratedQrCode(),
//                     ),
//                   );
//                 });
//               },
//               child: Text("Generated Qr Code"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:autocare/services/pdf_viewer_screen.dart';
// import 'package:flutter/material.dart';

// import 'generated_attestation.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController urlController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Générer et Afficher un PDF'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 10, right: 10),
//               child: TextField(
//                 controller: urlController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your data",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   labelText: "Enter your data",
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // Générer le PDF
//               },
//               child: Text('Générer et Afficher le PDF'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
