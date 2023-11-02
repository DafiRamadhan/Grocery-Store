import 'package:flutter/material.dart';
import 'home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 255, 255),
      body: Column(children: [
        //Image
        Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 40),
          child: Image.asset('lib/images/intro.png'),
        ),

        //Title
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 50),
          child: Text(
            'Kami Mengirimkan Bahan Makanan ke Rumah Anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //Subtitle
        const Text(
          'Tersedia berbagai pilihan sayuran dan buah segar.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: Color.fromARGB(255, 86, 86, 86),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Pesan kebutuhan Anda sekarang juga.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            color: Color.fromARGB(255, 86, 86, 86),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),

        //Button
        GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          )),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 119, 133, 219),
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            width: 160,
            height: 55,
            child: const Text(
              "Mulai Belanja",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Spacer(),
      ]),
    );
  }
}
