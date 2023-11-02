import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartModel extends ChangeNotifier {
  //List Produk (nama, harga, gambar, warna)
  final List items = [
    [
      "Pisang",
      "35000",
      "lib/images/banana.png",
      const Color.fromARGB(255, 255, 240, 218)
    ],
    [
      "Susu",
      "20000",
      "lib/images/milk.png",
      const Color.fromARGB(255, 221, 248, 255)
    ],
    [
      "Sawi",
      "15000",
      "lib/images/mustard.png",
      const Color.fromARGB(255, 239, 255, 221)
    ],
    [
      "Kepiting",
      "100000",
      "lib/images/crab.png",
      const Color.fromARGB(255, 255, 234, 229)
    ],
    [
      "Ikan",
      "50000",
      "lib/images/fish.png",
      const Color.fromARGB(255, 221, 248, 255)
    ],
  ];
  List cart = [];
  List order = [];

  get shopItems => items;

  get cartItems => cart;

  get orderItems => order;

  // Menambahkan atau memperbarui item di Keranjang
  void addItemToCart(int index) {
    var existingItemIndex =
        cart.indexWhere((item) => item[0] == shopItems[index][0]);

    //Jika item sudah ada di keranjang
    if (existingItemIndex != -1) {
      // Tambahkan jumlah harganya
      cart[existingItemIndex][1] = (int.parse(cart[existingItemIndex][1]) +
              int.parse(shopItems[index][1]))
          .toString();

      // Tambahkan jumlah itemnya
      cart[existingItemIndex][4] =
          (int.parse(cart[existingItemIndex][4]) + 1).toString();
    } else {
      // Jika item belum ada di keranjang, tambahkan item baru dengan jumlah 1
      var newItem = List.from(shopItems[index]);
      newItem.add('1');
      cart.add(newItem);
    }

    notifyListeners();
  }

  //Menghapus item di Keranjang
  void removeItemFromCart(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  //Menghitung harga total
  String calculateTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(0);
  }

  //Menghitung total item
  String calculateTotalItem() {
    int totalItem = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalItem += int.parse(cartItems[i][4]);
    }
    return totalItem.toStringAsFixed(0);
  }

  // Menangani pembayaran
  void processPayment() {
    String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    //Daftar seluruh pesanan dalam satu kali checkout
    var orderStorage = [];

    // Menambahkan pesanan ke daftar pesanan
    for (int i = 0; i < cartItems.length; i++) {
      List<dynamic> currentOrder = List.from(cartItems[i]);
      currentOrder.add(currentDate);
      orderStorage.add(currentOrder);
    }
    //Menambahkan seluruh pesanan dalam satu kali checkout ke orderList
    order.add(orderStorage);

    // Mengosongkan keranjang
    cart.clear();
    notifyListeners();
  }

  // Menangani pemesanan sebelumnya
  void processPreviousOrder() {
    // Menambahkan pesanan terakhir ke daftar pesanan
    List<dynamic> previousOrder = List.from(orderItems[orderItems.length - 1]);
    order.add(previousOrder);

    // Mengosongkan keranjang
    cart.clear();
    notifyListeners();
  }
}
