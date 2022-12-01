import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ValidPlates extends StatefulWidget {
  const ValidPlates({Key? key}) : super(key: key);

  @override
  State<ValidPlates> createState() => _ValidPlatesState();
}

class Plates {
  String model = '';
  String name = '';
  String plate = '';
}

class _ValidPlatesState extends State<ValidPlates> {
  var db = FirebaseFirestore.instance;
  var plate = Plates();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var collectionLogs = db.collection('validPlates').snapshots();

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
                  'Placas Válidas:',
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: collectionLogs,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Algo deu errado.');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        plate.name = data['name'];
                        plate.model = data['model'];
                        plate.plate = data['plate'];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                plate.plate,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              subtitle: Text(
                                'Dono da Placa: ${plate.name}\nModelo do carro: ${plate.model}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
