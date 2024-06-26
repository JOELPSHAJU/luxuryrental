// ignore_for_file: unused_local_variable, sized_box_for_whitespace, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

class AdvertisementGome extends StatefulWidget {
  const AdvertisementGome({super.key});

  @override
  State<AdvertisementGome> createState() => AdvertisementGomeState();
}

const textst = TextStyle(
    fontWeight: FontWeight.w500, color: Color.fromARGB(255, 124, 124, 124));

class AdvertisementGomeState extends State<AdvertisementGome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      height: MediaQuery.of(context).size.height * .24,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection(
              'advertisements',
            )
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .5,
                        child: Image.asset(
                          'assets/carTypes/placeholder6.png',
                          fit: BoxFit.cover,
                        )),
                    Text(
                      'No Advertisement Found!',
                      style: GoogleFonts.signikaNegative(
                          fontSize: MediaQuery.of(context).size.width * .04,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  String documentId = doc.id;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Card(
                        color: Color.fromARGB(255, 244, 244, 244),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * .16,
                                width: MediaQuery.of(context).size.width * .7,
                                child: CachedNetworkImage(
                                  imageUrl: doc['image'],
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: ProjectColors.primarycolor1,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
