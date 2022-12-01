import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPlate extends StatefulWidget {
  const AddPlate({Key? key}) : super(key: key);

  @override
  State<AddPlate> createState() => _AddPlateState();
}

class Plates {
  String model = '';
  String name = '';
  String plate = '';
}

class _AddPlateState extends State<AddPlate> {
  var db = FirebaseFirestore.instance;
  var newPlate = Plates();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var validPlates = db.collection('validPlates');

    Future<void> addPlate() {
      // Call the user's CollectionReference to add a new user
      return validPlates
          .add({
            'model': newPlate.model,
            'name': newPlate.name,
            'plate': newPlate.plate,
          })
          .then((value) => print("Placa Adicionada"))
          .catchError((error) => print("Falha ao adicionar placa: $error"));
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.green,
          title: const Text(
            'Placas Válidas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: height * .05,
                width: width,
              ),
              SizedBox(
                height: height * .05,
                width: width * .9,
                child: const Text(
                  'Adicionar Placa Válida:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(
                height: height * .8,
                width: width * .9,
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Placa',
                      ),
                      onChanged: (value) => newPlate.plate = value,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Nome do Proprietário',
                      ),
                      onChanged: (value) => newPlate.name = value,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Modelo do Carro',
                      ),
                      onChanged: (value) => newPlate.model = value,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: addPlate,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<MaterialColor>(Colors.green),
                      ),
                      child: const Text(
                        "Adicionar Placa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
