// ignore_for_file: avoid_print

import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/filter_pages.dart';

import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class SearchInventory extends StatefulWidget {
  const SearchInventory({super.key});

  @override
  State<SearchInventory> createState() => _SearchInventoryState();
}

const String type = 'Category';

class _SearchInventoryState extends State<SearchInventory> {
  List<String> docIDs = [];
  @override
  void initState() {
    getclientstream();
    _searchcontroller.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchcontroller.text);
    searchResultList();
  }

  searchResultList() {
    var showresult = [];
    if (_searchcontroller.text != '') {
      for (var clientSnapShot in _allresults) {
        var modelname = clientSnapShot['Model Name'].toString().toLowerCase();
        var companyname = clientSnapShot['Company'].toString().toLowerCase();
        var categoryname = clientSnapShot['Category'].toString().toLowerCase();
        if (companyname.contains(_searchcontroller.text.toLowerCase())) {
          showresult.add(clientSnapShot);
        } else if (modelname.contains(_searchcontroller.text.toLowerCase())) {
          showresult.add(clientSnapShot);
        } else if (categoryname
            .contains(_searchcontroller.text.toLowerCase())) {
          showresult.add(clientSnapShot);
        } else {}
      }
    } else {
      showresult = List.from(_allresults);
    }
    setState(() {
      _resultlist = showresult;
    });
  }

  final TextEditingController _searchcontroller = TextEditingController();
  List _allresults = [];
  List _resultlist = [];
  getclientstream() async {
    var data = await FirebaseFirestore.instance
        .collection('cardetails')
        .orderBy(type)
        .get();
    setState(() {
      _allresults = data.docs;
    });
    searchResultList();
  }

  @override
  void didChangeDependencies() {
    getclientstream();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  final filternames = [
    'Category',
    'Price Per Day',
    'Transmission',
    'Fuel Type',
    'Model Name'
  ];
  final checktextstyle = const TextStyle(
      fontWeight: FontWeight.w400, color: Color.fromARGB(255, 110, 110, 110));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.filter_list,
              color: ProjectColors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const FilterPage()));
            },
          ),
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextFormField(
                cursorColor: Colors.black,
                cursorWidth: 1,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                controller: _searchcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Fill This Field !';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Search your inventory',
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300, color: Colors.grey),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  border: InputBorder.none,
                  disabledBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(15)),
                )),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _resultlist.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/animations/Animation - 1706182910823.json',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Text(
                                'Oops,No Inventory Found!',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 81, 81, 81),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final price = _resultlist[index]['Price Per Day']
                              .toString()
                              .toUpperCase();
                          return GestureDetector(
                            onTap: () {
                              final selectedDocument = _resultlist[index];
                              final documentID = selectedDocument.id;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      ParticularInventory(id: documentID)));
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                            Color.fromARGB(31, 86, 86, 86),
                                            Color.fromARGB(115, 255, 255, 255),
                                            Colors.black12,
                                          ])),
                                    ),
                                    Positioned(
                                      top: 200,
                                      left: 10,
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0))),
                                              child: Center(
                                                child: RowSearch(
                                                  image:
                                                      'assets/carTypes/engine.png',
                                                  Texts:
                                                      ' ${_resultlist[index]['Maximum Power']}',
                                                  last: 'hp',
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0))),
                                                child: Center(
                                                    child: RowSearch(
                                                        image:
                                                            'assets/carTypes/seat.png',
                                                        last: 'Person',
                                                        Texts:
                                                            '  ${_resultlist[index]['Seating Capacity']}'))),
                                            Container(
                                                height: 40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0))),
                                                child: Center(
                                                  child: RowSearch(
                                                    last: '',
                                                    image:
                                                        'assets/carTypes/fuel.png',
                                                    Texts:
                                                        '${_resultlist[index]['Fuel Type']}',
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -45,
                                      left: MediaQuery.of(context).size.width *
                                          .025,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .18,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.center,
                                                _resultlist[index]['Company']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: GoogleFonts.robotoFlex(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Positioned(
                                      top: -50,
                                      left: MediaQuery.of(context).size.width *
                                          .57,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .18,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.center,
                                                "₹ ${_resultlist[index]['Price Per Day']}/day",
                                                style: GoogleFonts.robotoFlex(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Positioned(
                                      top: -13,
                                      left: MediaQuery.of(context).size.width *
                                          .02,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .18,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BorderedText(
                                                strokeWidth: 2,
                                                strokeColor:
                                                    const Color.fromARGB(
                                                        121, 88, 161, 216),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  _resultlist[index]
                                                          ['Model Name']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: GoogleFonts.robotoFlex(
                                                    color: Colors.transparent,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .08,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    MainImage(
                                      resultlist: _resultlist,
                                      image: _resultlist[index]['MainImage'],
                                    ),
                                  ],
                                )),
                          );
                        },
                        itemCount: _resultlist.length,
                      ),
              ),
            ],
          ),
        ));
  }
}

class MainImage extends StatelessWidget {
  final String image;
  const MainImage({
    super.key,
    required List resultlist,
    required this.image,
  }) : _resultlist = resultlist;

  final List _resultlist;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .25,
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}

class RowSearch extends StatelessWidget {
  final String image;
  final String last;
  final String Texts;
  const RowSearch(
      {super.key,
      required this.image,
      required this.last,
      required this.Texts});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          '$image',
          color: Colors.black,
          width: MediaQuery.of(context).size.width * .07,
        ),
        Text(
          '${Texts.toString().toUpperCase()} $last',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
