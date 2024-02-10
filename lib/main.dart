// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'File Picker Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FilePickerDemo(),
//     );
//   }
// }

// class FilePickerDemo extends StatefulWidget {
//   @override
//   _FilePickerDemoState createState() => _FilePickerDemoState();
// }

// class _FilePickerDemoState extends State<FilePickerDemo> {
//   File? _file;

//   void _openFileExplorer() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'], // Extensions autorisées
//     );

//     if (result != null) {
//       setState(() {
//         _file = File(result.files.single.path!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Picker Demo'),
//       ),
//       body: Center(
//         child: _file != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Fichier sélectionné:',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 20),
//                   if (_file!.path
//                       .toLowerCase()
//                       .endsWith('.pdf')) // Vérifier si c'est un PDF
//                     Text(
//                       'PDF sélectionné: ${_file!.path}',
//                       style: TextStyle(fontSize: 16),
//                     )
//                   else // Sinon, afficher l'image
//                     Image.file(
//                       _file!,
//                       height: 200,
//                     ),
//                 ],
//               )
//             : Text(
//                 'Aucun fichier sélectionné.',
//                 style: TextStyle(fontSize: 20),
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openFileExplorer,
//         tooltip: 'Sélectionner un fichier',
//         child: Icon(Icons.attach_file),
//       ),
//     );
//   }
// }

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
      initialRoute: AppPage.INITIAL,
      getPages: AppPage.routes,
    );
  }
}
