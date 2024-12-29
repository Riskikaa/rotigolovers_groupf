import 'package:flutter/material.dart';
import 'halaman_konfirmasi.dart'; // Import FormInput untuk navigasi

class HalamanKeranjang extends StatelessWidget {
  final List<Map<String, String>>
      cartItems; // Menerima cartItems dari halaman sebelumnya

  const HalamanKeranjang({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.brown, // Set background color to brown
        foregroundColor: Colors.white, // Set text color to white
      ),
      body: cartItems.isEmpty
          ? Center(
              child: const Text(
                'Keranjang Belanja Kosong!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Daftar Pesanan:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown, // Set color to brown
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation:
                            5, // Add some shadow to the card for a raised effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12), // Rounded corners for the card
                        ),
                        child: ListTile(
                          leading: Icon(Icons.shopping_cart,
                              color: Colors.brown), // Add an icon
                          title: Text(
                            item['nama_menu']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Harga: Rp ${item['harga']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors
                                  .grey[700], // Lighter gray color for price
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Navigasi ke FormInput dengan tombol Next
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormInput(
                                    initialNamaMenu: item[
                                        'nama_menu'], // You can pass the menu name if needed
                                  ),
                                ),
                              );
                            },
                            child: const Text('Next'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.brown, // Text color
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
