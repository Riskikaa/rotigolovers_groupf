import 'package:flutter/material.dart';
import 'halaman_konfirmasi.dart'; // Import FormInput untuk navigasi

class HalamanKeranjang extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  const HalamanKeranjang({super.key, required this.cartItems});

  @override
  _HalamanKeranjangState createState() => _HalamanKeranjangState();
}

class _HalamanKeranjangState extends State<HalamanKeranjang> {
  @override
  Widget build(BuildContext context) {
    double totalPembelian = 0.0; // Variable to hold the total purchase value

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
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Keranjang Belanja Kosong!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Daftar Pesanan:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (widget.cartItems.length / 10).ceil(),
                    itemBuilder: (context, index) {
                      final startIndex = index * 10;
                      final endIndex =
                          (startIndex + 10) > widget.cartItems.length
                              ? widget.cartItems.length
                              : startIndex + 10;

                      final itemsForCard =
                          widget.cartItems.sublist(startIndex, endIndex);

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
                                int quantity =
                                    int.parse(item['quantity'] ?? '0');
                                double harga =
                                    double.parse(item['harga'] ?? '0');
                                double totalItem = quantity *
                                    harga; // Calculate total for this item
                                totalPembelian +=
                                    totalItem; // Add to total purchase value

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama_menu']!,
                                      style: const TextStyle(
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
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (quantity > 1) {
                                                quantity--;
                                                item['quantity'] =
                                                    quantity.toString();
                                              }
                                            });
                                          },
                                        ),
                                        Text('$quantity'),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
                                              item['quantity'] =
                                                  quantity.toString();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormInput(
                                    initialNamaMenu: itemsForCard[0]
                                        ['nama_menu'],
                                    initialHarga: itemsForCard[0]['harga'],
                                    initialQuantity: itemsForCard[0][
                                        'quantity'], // Memastikan quantity dikirim
                                    initialTotalPembelian:
                                        totalPembelian.toStringAsFixed(
                                            2), // Pass the total to the next page
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.brown,
                            ),
                            child: const Text('Next'),
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
