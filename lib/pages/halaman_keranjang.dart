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
                    itemCount: (cartItems.length / 10)
                        .ceil(), // Set to display up to 10 items per card
                    itemBuilder: (context, index) {
                      final startIndex = index * 10;
                      final endIndex = (startIndex + 10) > cartItems.length
                          ? cartItems.length
                          : startIndex + 10;

                      final itemsForCard =
                          cartItems.sublist(startIndex, endIndex);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...itemsForCard.map((item) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama_menu']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Harga: Rp ${item['harga']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 8), // Spacing between items
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Navigasi ke FormInput dengan tombol Next
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormInput(
                                    initialNamaMenu: itemsForCard[0][
                                        'nama_menu'], // Pass the first menu in the card
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
