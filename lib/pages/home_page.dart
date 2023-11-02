import 'package:flutter/material.dart';
import 'package:grocery/components/grocery_item.dart';
import 'package:grocery/model/cart_model.dart';
import 'cart_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<CartModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              FloatingActionButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const CartPage();
                })),
                backgroundColor: const Color.fromARGB(255, 119, 133, 219),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              Positioned(
                right: 9,
                top: 5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    value.calculateTotalItem(),
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Consumer<CartModel>(builder: (context, value, child) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.black,
                        ),
                        Text(
                          " Jakarta, Indonesia",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'lib/images/profile.png',
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Selamat Datang, Dafi",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color.fromARGB(255, 129, 129, 129),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 13),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 70),
                child: Text(
                  "Silakan pilih item yang Anda inginkan",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Kategori",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                child: Expanded(
                  child: Consumer<CartModel>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.shopItems.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 140,
                            child: GroceryItem(
                              itemName: value.shopItems[index][0],
                              itemPrice: value.shopItems[index][1],
                              imagePath: value.shopItems[index][2],
                              color: value.shopItems[index][3],
                              onPressed: () {
                                Provider.of<CartModel>(context, listen: false)
                                    .addItemToCart(index);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 13),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Riwayat Pesanan",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: value.orderItems.length,
                  padding: const EdgeInsets.only(right: 10),
                  itemBuilder: (context, orderIndex) {
                    List<dynamic> items = value.orderItems.reversed.toList()[orderIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: items.reversed.toList().map<Widget>((orderItem) {
                        String itemName = orderItem[0];
                        String itemPrice =
                            'Rp${NumberFormat.decimalPattern('id_ID').format(int.parse(orderItem[1]))}';
                        String itemImage = orderItem[2];
                        Color itemColor = orderItem[3];
                        String itemCount = orderItem[4].toString();
                        String itemDate = orderItem[5];

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
                                    height: 50,
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
                              subtitle: Text(
                                itemDate,
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.grey,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              trailing: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: itemPrice,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n$itemCount item',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        color: Colors.grey,
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
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
