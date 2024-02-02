import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/AdminPanel/viewrentalrules.dart';

import 'package:luxurycars/Universaltools.dart';

// ignore: must_be_immutable
class ViewSingleInventory extends StatefulWidget {
  String id;
  ViewSingleInventory({super.key, required this.id});

  @override
  State<ViewSingleInventory> createState() => _ViewSingleInventoryState();
}

class _ViewSingleInventoryState extends State<ViewSingleInventory> {
  final String collectionName = 'cardetails';

  Widget details({required label, required data, required addons}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.star_border_purple500_outlined,
            size: 15,
            color: Color.fromARGB(255, 49, 49, 49),
          ),
          Text(
            '  $label : ',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 40, 40, 40)),
          ),
          Text(
            '$data $addons',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 35,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: ProjectColors.primarycolor1,
              )),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(widget.id)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error fetching data: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  DocumentSnapshot<Map<String, dynamic>> docSnapshot =
                      snapshot.data!;
                  if (docSnapshot.exists) {
                    Map<String, dynamic> data = docSnapshot.data()!;
                    String docsid = widget.id;
                    String company = data['Company'];
                    String category = data['Category'];
                    String modelname = data['Model Name'];
                    String mainimage = data['MainImage'];
                    String engine = data['Engine Displacement'];
                    String fueltank = data['Fuel Tank Capacity'];
                    String fueltype = data['Fuel Type'];
                    String gearbox = data['Gearbox'];
                    String groundclearence = data['Ground Clearence'];
                    List<dynamic> images = data['Image Urls'];
                    String maxpower = data['Maximum Power'];
                    String maxtorque = data['Maximum Torque'];

                    String overview = data['Overview'];
                    String price = data['Price Per Day'].toString();
                    String seatingcapacity = data['Seating Capacity'];
                    String transmission = data['Transmission'];
                    String zerotohundred = data['Zero To Hundred'];
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * .99,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            child: FractionallySizedBox(
                              heightFactor: 95.0,
                              child: CarouselSlider(
                                items: images.map((url) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: CachedNetworkImage(
                                      imageUrl: url,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: ProjectColors.primarycolor1,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  aspectRatio: 19 / 10,
                                  enableInfiniteScroll: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      '$company\n$modelname',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .023,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .99,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Overview',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .023,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Text(
                                      overview,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 211, 211, 211),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5, bottom: 5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 158, 74, 74),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                  'assets/max/logo.png',
                                                ),
                                                fit: BoxFit.cover)),
                                        child: const Center(),
                                        height: 56,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.width,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'GO DRIVE LUXURY RENTALS',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .017,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.star),
                                                  Text('5.0',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .016,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              ViewRental()));
                                                },
                                                child: const Text(
                                                  'Rental Rules',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Technical Specification',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .023,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: details(
                                      label: 'Engine Displacement',
                                      data: engine,
                                      addons: 'cc'),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: details(
                                      label: 'Maximum Power',
                                      data: maxpower,
                                      addons: 'hp'),
                                ),
                                Container(
                                  height: 50,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: details(
                                      label: 'Maximum Torque',
                                      data: maxtorque,
                                      addons: 'nm'),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: details(
                                      label: 'Transmission',
                                      data: transmission,
                                      addons: ''),
                                ),
                                Container(
                                  height: 50,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: details(
                                      label: 'Gearbox',
                                      data: gearbox,
                                      addons: 'speed'),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: details(
                                      label: 'Zero to Hundred',
                                      data: zerotohundred,
                                      addons: 'seconds'),
                                ),
                                Container(
                                  height: 50,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: details(
                                      label: 'Fuel Type',
                                      data: fueltype,
                                      addons: ''),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: details(
                                      label: 'Fuel Tank Capacity',
                                      data: fueltank,
                                      addons: 'ltrs'),
                                ),
                                Container(
                                  height: 50,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: details(
                                      label: 'Seating Capacity',
                                      data: seatingcapacity,
                                      addons: ''),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: details(
                                      label: 'Ground Clearence',
                                      data: groundclearence,
                                      addons: ''),
                                ),
                                Container(
                                  height: 50,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: details(
                                      label: 'Category',
                                      data: category,
                                      addons: ''),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          SizedBox(
                              height: 130,
                              width: MediaQuery.of(context).size.width * .99,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'from',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '₹' + '$price',
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .03,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text(
                                                  ' / day',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'popular inventories')
                                                  .add({
                                                'Id': docsid,
                                                'Image': mainimage,
                                                'Model Name': modelname,
                                                'Company': company,
                                                'Category': category,
                                                'Price': price
                                              });
                                              snackbar();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black),
                                            child: Text(
                                              'Add to Popular',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .025,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )))
                        ],
                      ),
                    );
                  } else {
                    return const Text('Document does not exist');
                  }
                }

                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: const CircularProgressIndicator()));
              },
            ),
          ),
        ),
      ),
    );
  }

  snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      content: Text('Added To Popular Inventories'),
      duration: Duration(seconds: 3),
    ));
  }
}
