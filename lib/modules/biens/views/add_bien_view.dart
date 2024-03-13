import 'package:date_time_picker/date_time_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:get/get.dart';
import '../../../services/datetime_format.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../components/container_round.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../controllers/biens_controller.dart';

class AddBienView extends GetView<BiensController> {
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  AddBienView(
      {super.key, Map<String, dynamic>? errors, Map<String, dynamic>? oldData})
      : errors = errors ?? Get.arguments?['errors'],
        oldData = oldData ?? Get.arguments?['oldData'];
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BiensController());
    print(errors);
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "Enregistrement d'une moto",
          size: 20,
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: AddBienForm(
            controller: controller,
            errors: errors,
            oldData: oldData,
          ),
        ),
      ),
    );
  }
}

class AddBienForm extends StatefulWidget {
  final BiensController controller;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? oldData;
  const AddBienForm({required this.controller, this.errors, this.oldData});
  @override
  State<AddBienForm> createState() => _AddBienFormState();
}

class _AddBienFormState extends State<AddBienForm> {
  late TextEditingController nomBien;
  late TextEditingController numChassis;
  late TextEditingController numPlaque;
  late TextEditingController adresse;
  DateTime? selectedDate;
  bool basiquePromotion = false;
  late String? couverture;
  File? _file;
  bool _fileSelected = false;
  String? _extension;

  @override
  void initState() {
    if (widget.oldData != null) {
      nomBien = TextEditingController(text: widget.oldData!['nom_bien']);
      numChassis = TextEditingController(text: widget.oldData!['num_chassis']);
      numPlaque = TextEditingController(text: widget.oldData!['num_plaque']);
      adresse = TextEditingController(text: widget.oldData!['num_chassis']);
      if (widget.oldData!['date_acquisition'] != "") {
        selectedDate = dateTimeFormat(widget.oldData!['date_acquisition']);
      }
    } else {
      nomBien = TextEditingController();
      numChassis = TextEditingController();
      numPlaque = TextEditingController();
      adresse = TextEditingController();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddBienForm oldWidget) {
    if (widget.oldData != null) {
      nomBien = TextEditingController(text: widget.oldData!['nom_bien']);
      numChassis = TextEditingController(text: widget.oldData!['num_chassis']);
      numPlaque = TextEditingController(text: widget.oldData!['num_plaque']);
      adresse = TextEditingController(text: widget.oldData!['num_chassis']);
      if (widget.oldData!['date_acquisition'] != "") {
        selectedDate = dateTimeFormat(widget.oldData!['date_acquisition']);
      }
    } else {
      nomBien = TextEditingController();
      numChassis = TextEditingController();
      numPlaque = TextEditingController();
      adresse = TextEditingController();
    }
    super.didUpdateWidget(oldWidget);
  }

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
                if (widget.errors != null && widget.errors!['nom_bien'] != null)
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextComponent(
                      text: widget.errors!['nom_bien'][0],
                      textAlign: TextAlign.left,
                      color: Colors.red,
                    ),
                  ),
                SizedBox(
                  height: 30,
                ),
                DateTimePicker(
                  initialValue: selectedDate.toString(),
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
                if (widget.errors != null &&
                    widget.errors!['date_acquisition'] != null)
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextComponent(
                      text: widget.errors!['date_acquisition'][0],
                      textAlign: TextAlign.left,
                      color: Colors.red,
                    ),
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
                if (widget.errors != null &&
                    widget.errors!['num_chassis'] != null)
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextComponent(
                      text: widget.errors!['num_chassis'][0],
                      textAlign: TextAlign.left,
                      color: Colors.red,
                    ),
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
                if (widget.errors != null &&
                    widget.errors!['num_plaque'] != null)
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextComponent(
                      text: widget.errors!['num_plaque'][0],
                      textAlign: TextAlign.left,
                      color: Colors.red,
                    ),
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
                if (widget.errors != null && widget.errors!['file'] != null)
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextComponent(
                      text: widget.errors!['file'][0],
                      textAlign: TextAlign.left,
                      color: Colors.red,
                    ),
                  ),
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
                      'date_acquisition':
                          (selectedDate == null) ? "" : selectedDate.toString(),
                      'num_plaque': numPlaque.text,
                      'num_chassis': numChassis.text,
                      'extension': _extension,
                      'file': _file,
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
