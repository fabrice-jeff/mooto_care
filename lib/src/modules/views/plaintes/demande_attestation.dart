import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../components/container_round.dart';
import '../../../components/text.dart';
import '../../../components/text_form_field.dart';
import '../../controllers/plaintes_controller.dart';

class DemandeAttestationView extends GetView<PlaintesController> {
  const DemandeAttestationView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: 'Demande d\'attesttion',
            size: 20,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: DemandeAttestationForm(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class DemandeAttestationForm extends StatefulWidget {
  final PlaintesController controller;
  const DemandeAttestationForm({super.key, required this.controller});

  @override
  State<DemandeAttestationForm> createState() => _DemandeAttestationFormState();
}

class _DemandeAttestationFormState extends State<DemandeAttestationForm> {
  TextEditingController numeroPlaque = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController prenoms = TextEditingController();
  var reasonValidation = true;
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ComtainerRoundComponent(
                icon: Icons.add_task,
                height: 100,
                width: 100,
              ),
              Container(
                alignment: Alignment.center,
                child: TextComponent(
                  text:
                      "Vous n'avez pas encore signaler la perte de votre moto à la police?",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  size: 15,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldsComponent(
                hintText: "Nom",
                prefixIcon: Icons.list_alt,
                controller: nom,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldsComponent(
                hintText: "Prenoms",
                prefixIcon: Icons.list_alt,
                controller: prenoms,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldsComponent(
                hintText: "Numéro de plaque du bien",
                prefixIcon: Icons.list_alt,
                controller: numeroPlaque,
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
                  hintText: "Date de perte",
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
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextFormField(
                  controller: description,
                  maxLines: 7,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Entrer une description",
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
                    border: OutlineInputBorder(),
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: TextComponent(
                        text: "Description des ciconstances de perte"),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Map<String, dynamic> data = {
                    'nom': nom.text,
                    'prenoms': prenoms.text,
                    'numero_plaque': numeroPlaque.text,
                    'date_perte': selectedDate.toString(),
                    'description': description.text,
                  };
                  widget.controller.addDemandeAttestation(data);
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
                    text: "Faire une demande",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
