import 'package:autocare/src/modules/controllers/biens_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';

class AddBienView extends GetView<BiensController> {
  const AddBienView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: TextComponent(
          text: "Ajouter un bien",
          color: Colors.white,
        ),
        actions: [
          InkWell(
            child: Container(
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 20),
            ),
          )
        ],
        backgroundColor: AppColors.backgroundColor,
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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                child: TextComponent(
                  text:
                      "Cher partenaire, enregistrez votre voiture ou votre motocyclette,et retrouvez les plus facilement en cas de vol.",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  size: 15,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldsComponent(
                hintText: "Nom du bien",
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
                hintText: "Numéro de la plaque",
                prefixIcon: Icons.backpack,
                controller: numPlaque,
                textInputType: TextInputType.name,
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
                hintText: "Domicile",
                prefixIcon: Icons.place,
                controller: adresse,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Map<String, dynamic> data = {
                    'nom_bien': nomBien.text,
                    'date_acquisition': selectedDate.toString(),
                    'num_plaque': numPlaque.text,
                    'num_chassis': numChassis.text,
                    'adresse': adresse.text,
                    'acteur': widget.controller.acteur!.code
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
                    text: "Ajouter le bien",
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
