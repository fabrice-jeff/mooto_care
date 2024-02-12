import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';

import '../../../components/container_round.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../../controllers/plaintes_controller.dart';

class AddPlainteView extends GetView<PlaintesController> {
  const AddPlainteView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: 'Déposer une ',
            size: 20,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: AddPlainteForm(controller: controller),
        ),
      ),
    );
  }
}

class AddPlainteForm extends StatefulWidget {
  final PlaintesController controller;
  const AddPlainteForm({super.key, required this.controller});

  @override
  State<AddPlainteForm> createState() => _AddPlainteFormState();
}

class _AddPlainteFormState extends State<AddPlainteForm> {
  // TextEditingController nomBien = TextEditingController();
  TextEditingController datePerte = TextEditingController();
  TextEditingController numPlaque = TextEditingController();
  TextEditingController numChassis = TextEditingController();
  DateTime? selectedDate;
  File? _file;
  bool _fileSelected = false;
  String? _extension;

  // void startScan(BuildContext context) async {
  //   var image = await DocumentScannerFlutter.launch(context);
  //   if (image != null) {
  //     setState(() {
  //       _scannerImage = image;
  //     });
  //   }
  // }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'], // Extensions autorisées
    );

    if (result != null) {
      setState(() {
        var platformFile = result.files.single;
        _file = File(platformFile.path!);
        _extension = platformFile.extension; // Récupérer l'extension du fichier
        _fileSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ComtainerRoundComponent(
                icon: Icons.add_card,
                height: 100,
                width: 100,
              ),
              Container(
                alignment: Alignment.center,
                child: TextComponent(
                  text: "Vous cherchez votre voiture ou votre moto?",
                  fontWeight: FontWeight.bold,
                  size: 15,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: TextComponent(
                  text:
                      "Signalez-le, nous nous occuperons de retrouver votre bien.",
                  fontWeight: FontWeight.bold,
                  size: 15,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // TextFormFieldsComponent(
              //   hintText: "Nom du Bien",
              //   prefixIcon: Icons.list_alt,
              //   controller: nomBien,
              //   textInputType: TextInputType.name,
              // ),
              SizedBox(
                height: 30,
              ),
              DateTimePicker(
                type: DateTimePickerType.date,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: AppColors.inputColor,
                  ),
                  hintText: "Date de Perte",
                  label: TextComponent(text: "Date de Perte"),
                  hintStyle: TextStyle(color: AppColors.inputColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                dateMask: 'dd/MM/yyyy',
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                onChanged: (val) {
                  setState(() {
                    selectedDate = DateTime.parse(val);
                  });
                },
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldsComponent(
                hintText: "Numéro de Plaque",
                prefixIcon: Icons.confirmation_number_outlined,
                controller: numPlaque,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldsComponent(
                hintText: "Numéro Chassis",
                prefixIcon: Icons.confirmation_number_outlined,
                controller: numChassis,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: TextComponent(text: " Ajoutez l'attestation de perte"),
              ),
              InkWell(
                onTap: _openFileExplorer,
                child: DottedBorder(
                  color: Colors.black38,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: _fileSelected
                        ? Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: double.infinity,
                            child: Text(
                              'Fichier sélectionné',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        : Container(
                            height: 100,
                            width: double.infinity,
                            child: Icon(
                              Icons.attach_file,
                              color: Colors.black38,
                              size: 30,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Map<String, dynamic> data = {
                    'date_perte': selectedDate.toString(),
                    'numero_chassis': numChassis.text,
                    'numero_plaque': numPlaque.text,
                    // 'nom_bien': nomBien.text,
                    'attestation': _file,
                    'extension': _extension,
                  };

                  widget.controller.addPlainte(data);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextComponent(
                    text: "Ajouter la plainte",
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
