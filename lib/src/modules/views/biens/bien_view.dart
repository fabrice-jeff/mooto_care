import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../datas/models/bien.dart';
import '../../../../utils/colors.dart';
import '../../../components/text.dart';
import 'assure_bien_view.dart';

class BienView extends StatelessWidget {
  final Bien bien;
  const BienView({required this.bien});

  Widget _infoUser({required String libelle, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: TextComponent(
              text: libelle,
              size: 16,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: TextComponent(
                textAlign: TextAlign.start,
                text: value,
                size: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextComponent(
            text: 'Motos enregistrées',
            size: 20,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/user.webp",
                      ),
                    ),
                  ),
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Divider(),
                    _infoUser(libelle: "Nom de la moto:", value: bien.nomBien),
                    _infoUser(
                        libelle: "Date d'acqusition:",
                        value: bien.dateAcquisition.toString()),
                    _infoUser(
                        libelle: "Numéro de série:", value: bien.numChassis),
                    _infoUser(libelle: "Numéro plaque:", value: bien.numPlaque),
                    _infoUser(
                        libelle: "Niveau de couverture:",
                        value: (bien.typeCouverture == null)
                            ? "Pas assurée"
                            : bien.typeCouverture!.libelle),
                    _infoUser(libelle: "Carte grise:", value: "0"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextComponent(
                          text: "Modifier",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          AssureBienView(
                            bien: bien,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextComponent(
                          text: "Assurer",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
