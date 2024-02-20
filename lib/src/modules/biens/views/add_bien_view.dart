import 'package:date_time_picker/date_time_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/container_round.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../controllers/biens_controller.dart';

class AddBienView extends GetView<BiensController> {
  const AddBienView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: "Enregistrement d'une moto",
            size: 20,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: AddBienForm(controller: controller),
        ),
      ),
    );
  }
}

class AddBienForm extends StatefulWidget {
  final BiensController controller;
  const AddBienForm({required this.controller});
  @override
  State<AddBienForm> createState() => _AddBienFormState();
}

class _AddBienFormState extends State<AddBienForm> {
  TextEditingController nomBien = TextEditingController();
  TextEditingController numChassis = TextEditingController();
  TextEditingController numPlaque = TextEditingController();
  TextEditingController adresse = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  bool basiquePromotion = false;
  String? couverture;
  File? _file;
  bool _fileSelected = false;
  String? _extension;
  void handleSelectValue(String? selectedValue) {
    for (var couv in widget.controller.typesCouvertures) {
      if (selectedValue == couv.libelle) {
        couverture = couv.codeReference;
        break;
      }
    }
    if (couverture == Constants.TYPE_COUVERTURE_BASIQUE) {
      widget.controller.showPromo(true);
    } else {
      widget.controller.showPromo(false);
    }
  }

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
    return GetBuilder<BiensController>(
      builder: (controller) => Form(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ComtainerRoundComponent(
                  icon: Icons.hourglass_bottom,
                  height: 75,
                  borderColor: Colors.transparent,
                  width: 75,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldsComponent(
                  hintText: "Nom de la moto",
                  prefixIcon: Icons.list_alt,
                  controller: nomBien,
                  textInputType: TextInputType.name,
                ),
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
                    hintText: "Date d'acquisition",
                    label: TextComponent(text: "Date acquisition"),
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
                  hintText: "Numéro chassis",
                  prefixIcon: Icons.backpack,
                  controller: numChassis,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldsComponent(
                  hintText: "Numéro de la plaque",
                  prefixIcon: Icons.backpack,
                  controller: numPlaque,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(text: "Carte grise/Papier d'achat"),
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
                // SizedBox(
                //   height: 30,
                // ),
                // SelectFieldsWidget(
                //   hintText: "Niveau de couverture",
                //   icon: Icons.notes_sharp,
                //   label: "Niveau de couverture",
                //   items: controller.couvertures,
                //   onValueChanged: handleSelectValue,
                // ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Map<String, dynamic> data = {
                      'nom_bien': nomBien.text,
                      'date_acquisition': selectedDate.toString(),
                      'num_plaque': numPlaque.text,
                      'num_chassis': numChassis.text,
                      'adresse': adresse.text,
                      'acteur': widget.controller.acteur!.code,
                      // 'promotion': basiquePromotion,
                      // 'couverture': couverture,
                      'file': _file,
                      'extension': _extension,
                    };
                    widget.controller.add(data);
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
                      text: "Enregistrer",
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
