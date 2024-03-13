import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text.dart';

final List<String> promotions = [
  'Promotion Basique',
  'Promotion Gold',
  'Promotion VIP',
];

class TarifsView extends GetView {
  const TarifsView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: "Niveau de protection",
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite,
                  child: DataTable(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: TableBorder.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: TextComponent(
                          text: "Promotion",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: TextComponent(
                          text: "Prix(FCFA)",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(cells: const <DataCell>[
                        DataCell(
                          Text("BASIQUE"),
                        ),
                        DataCell(
                          Text("1000"),
                        ),
                      ]),
                      DataRow(cells: const <DataCell>[
                        DataCell(
                          Text("GOLD"),
                        ),
                        DataCell(
                          Text("25000"),
                        ),
                      ]),
                      DataRow(cells: const <DataCell>[
                        DataCell(
                          Text("VIP"),
                        ),
                        DataCell(
                          Text("50000"),
                        ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: "Autres tarifs",
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: DataTable(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: TableBorder.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: TextComponent(
                          text: "Services",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: TextComponent(
                          text: "Prix(FCFA)",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(cells: const <DataCell>[
                        DataCell(
                          Text("Demande attestation de perte"),
                        ),
                        DataCell(
                          Text("200"),
                        ),
                      ]),
                      DataRow(cells: const <DataCell>[
                        DataCell(
                          Text("Dépot de plainte"),
                        ),
                        DataCell(
                          Text("100"),
                        ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text: "Avis de non-responsabilité",
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextComponent(
                    text:
                        "Ceci est une clause de non-responsabilité, nous en avons besoin pour nous conformer aux dispositions légales",
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
