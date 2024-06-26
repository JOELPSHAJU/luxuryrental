// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ProjectColors.primarycolor1,
        title: Text(
          'Notification',
          style: GoogleFonts.signikaNegative(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ProjectColors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: ProjectColors.white,
            )),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('notification')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Row> clientwidgets = [];

                  if (snapshot.hasData) {
                    final clients = snapshot.data?.docs.reversed.toList();
                    if (clients!.isEmpty) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/bg/note.png',
                            width: MediaQuery.of(context).size.height * .1,
                          ),
                          Text(
                            'No New Notifications!',
                            style: GoogleFonts.signikaNegative(
                                fontSize:
                                    MediaQuery.of(context).size.width * .04,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 81, 81, 81)),
                          )
                        ],
                      ));
                    }
                    for (var client in clients) {
                      final clientwidget = Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    color: ProjectUtils().listcolor),
                                width: MediaQuery.of(context).size.width * .93,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    client['note'],
                                    style: GoogleFonts.gowunBatang(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .02,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                          ),
                        ],
                      );
                      clientwidgets.add(clientwidget);
                    }
                  }
                  return Expanded(
                      child: ListView(
                    children: clientwidgets,
                  ));
                })
          ],
        ),
      ),
    );
  }
}
