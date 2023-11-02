import 'package:flutter/material.dart';
import 'package:grocery/model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartModel>(builder: (context, value, child) {
        return Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 50),
              child: ClipOval(
                child: Material(
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 236, 236, 236),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24, top: 20, bottom: 15),
              child: Text(
                "Keranjang",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: value.cartItems.length,
              padding: const EdgeInsets.only(right: 20),
              itemBuilder: (context, index) {
                String itemName = value.cartItems.reversed.toList()[index][0];
                String itemPrice =
                    'Rp${NumberFormat.decimalPattern('id_ID').format(int.parse(value.cartItems.reversed.toList()[index][1]))}';
                String itemImage = value.cartItems.reversed.toList()[index][2];
                Color itemColor = value.cartItems.reversed.toList()[index][3];
                String itemCount = value.cartItems.reversed.toList()[index][4];

                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: itemColor,
                        ),
                        child: Center(
                          child: Image.asset(
                            itemImage,
                            height: 45,
                          ),
                        ),
                      ),
                      title: Text(
                        itemName,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: itemPrice,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' - $itemCount item',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          int reversedIndex = value.cartItems.length - 1 - index;
                          Provider.of<CartModel>(context, listen: false)
                              .removeItemFromCart(reversedIndex);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Color.fromARGB(255, 130, 198, 254),
                                size: 20,
                              ),
                              onPressed: () =>
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(index),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Hapus',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: Color.fromARGB(255, 130, 198, 254),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Atau",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Color.fromARGB(255, 119, 119, 119),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 90),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
              width: 360,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 222, 228, 237),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Ulangi Pesanan Sebelumnya",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 15),
                  MaterialButton(
                    onPressed: value.orderItems.length > 0
                        ? () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Berhasil Membuat Ulang Pesanan Sebelumnya",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: Color.fromARGB(
                                              255, 119, 133, 219),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Menutup dialog
                                        Provider.of<CartModel>(context,
                                                listen: false)
                                            .processPreviousOrder();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    minWidth: 10,
                    height: 45,
                    elevation: 0,
                    child: const Text(
                      "Pesan Sekarang",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 119, 133, 219),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Harga",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Color.fromARGB(255, 215, 216, 225),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Rp${NumberFormat.decimalPattern('id_ID').format(int.parse(value.calculateTotalPrice()))}',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: value.cartItems.length > 0
                        ? () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Pesanan Berhasil Dibuat",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          color: Color.fromARGB(
                                              255, 119, 133, 219),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Menutup dialog
                                        Provider.of<CartModel>(context,
                                                listen: false)
                                            .processPayment();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                    color: const Color.fromARGB(255, 119, 133, 219),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 197, 200, 225)),
                    ),
                    minWidth: 100,
                    height: 40,
                    elevation: 0,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bayar",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]);
      }),
    );
  }
}
