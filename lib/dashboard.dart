import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class Logs {
  DateTime dateHour = DateTime.now();
  String plate = '';
}

class _DashboardState extends State<Dashboard> {
  var db = FirebaseFirestore.instance;
  var log = Logs();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var collectionLogs = db.collection('logs').orderBy('dateHour', descending: true).snapshots();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.green,
          title: const Text(
            'Leitor de Placas',
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
                height: height * .1,
                width: width,
              ),
              SizedBox(
                width: width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 170,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/validPlates');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.clipboardList,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            const Text(
                              'Placas\nCadastradas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 170,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/addPlate');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.fileCirclePlus,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            const Text(
                              'Cadastrar\nPlacas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                height: height * .03,
                width: width * .9,
                child: const Text(
                  'Logs:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: height * .53,
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
                        log.plate = data['plate'];
                        Timestamp timestamp = data['dateHour'] as Timestamp;
                        log.dateHour = DateTime.parse(timestamp.toDate().toString());
                        return ListTile(
                          title: Text(
                            log.plate,
                            style: const TextStyle(fontSize: 15),
                          ),
                          subtitle: Text(
                            '${DateFormat('dd/MM/yyyy').format(log.dateHour)} - ${DateFormat('HH:mm:ss').format(log.dateHour)}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
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
