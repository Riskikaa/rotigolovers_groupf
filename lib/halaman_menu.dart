import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rotigolovers_groupf/halaman_keranjang.dart';
import 'package:rotigolovers_groupf/halaman_laporan_penjualan.dart';
import 'halaman_detail_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotigolovers Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const RotigoloversList(),
    );
  }
}

class RotigoloversList extends StatefulWidget {
  const RotigoloversList({super.key});

  @override
  State<RotigoloversList> createState() => _RotigoloversListState();
}

class _RotigoloversListState extends State<RotigoloversList> {
  late List<Map<String, String>> menuItems;
  List<Map<String, String>> cartItems = []; // List to hold items in the cart
  late List<bool> isOrdered; // List to track if an item is ordered

  @override
  void initState() {
    super.initState();
    const String jsonResponse = '''
    [
      {"nama_menu": "Roti Coklat", "description": "Roti dengan isian coklat lezat", "harga": "15000"},
      {"nama_menu": "Roti Keju", "description": "Roti dengan keju gurih", "harga": "13000"},
      {"nama_menu": "Roti Strawberry", "description": "Roti dengan selai strawberry manis", "harga": "14000"},
      {"nama_menu": "Roti Pisang", "description": "Roti dengan potongan pisang segar", "harga": "12000"}
    ]
    ''';

    // Parsing JSON to List<Map<String, String>>
    menuItems = (jsonDecode(jsonResponse) as List<dynamic>)
        .map((item) => {
              "nama_menu": item['nama_menu'] as String,
              "description": item['description'] as String,
              "harga": item['harga'] as String,
            })
        .toList();

    // Initialize the isOrdered list with false
    isOrdered = List<bool>.filled(menuItems.length, false);
  }

  void toggleOrder(int index) {
    setState(() {
      if (isOrdered[index]) {
        // If already ordered, remove from cart
        cartItems.removeWhere(
            (item) => item['nama_menu'] == menuItems[index]['nama_menu']);
      } else {
        // If not ordered, add to cart
        cartItems.add(menuItems[index]);
      }
      isOrdered[index] = !isOrdered[index]; // Toggle the order status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Rotigolovers',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Set this to 4 to display 4 cards per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuDetailPage(
                        nama_menu: item['nama_menu']!,
                        description: item['description']!,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        color: Colors.brown.shade100,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.bakery_dining,
                          size: 40,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          item['nama_menu']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Text(
                          'Harga: Rp ${item['harga']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20), // Increased horizontal padding
                          ),
                          onPressed: () {
                            toggleOrder(index); // Toggle order status
                          },
                          child: Text(
                            isOrdered[index] ? 'Batalkan' : 'Pesan',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to HalamanKeranjang and pass the cart items
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanKeranjang(cartItems: cartItems),
            ),
          );
        },
        backgroundColor: Colors.brown,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            if (cartItems.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${cartItems.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            elevation: 0,
          ),
          onPressed: () {
            // Navigate to your Laporan (Report) page here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RotigoloversLaporan(),
              ),
            );
          },
          child: const Text(
            'Laporan',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
