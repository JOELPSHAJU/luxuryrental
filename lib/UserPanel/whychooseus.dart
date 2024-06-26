import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/UserHomePage.dart';

class Whychooseus extends StatelessWidget {
  const Whychooseus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Why We Are Different',
              style: GoogleFonts.roboto(
                  fontSize: 24, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Unlock The Road To Adventure With Our Diverse Fleet Of Our Luxury Rental Cars.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 125, 125, 125),
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                whychoose(
                    image: 'assets/latest/whychooseus2.png',
                    subtitle:
                        'Go Drive provides top-class services at an affordable price.',
                    title: 'Low Prices'),
                whychoose(
                  image: 'assets/latest/whychooseus3.png',
                  title: 'Experienced Staff',
                  subtitle:
                      'We Hire best experts in everything concerning car rental.',
                ),
                whychoose(
                    image: 'assets/latest/whychooseus4.png',
                    subtitle:
                        'Our team guarantee reliable support in addition to the offered services.',
                    title: 'Reliable support'),
                whychoose(
                    image: 'assets/latest/whychooseus1.png',
                    subtitle:
                        'You can find our car rental officess throughout kerala',
                    title: 'Convienient Location')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class whychoose extends StatelessWidget {
  const whychoose({
    required this.image,
    required this.subtitle,
    required this.title,
    super.key,
  });
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: 280,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 72, 72, 72),
              Color.fromARGB(255, 35, 35, 35),
              Color.fromARGB(255, 44, 44, 44),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizedboc,
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                image,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            sizedboc,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
