import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotigolovers_groupf/utils/rotigolovers_model.dart'; // Ensure to import the intl package

class StrukPage extends StatelessWidget {
  final RotigoloversModel transaksi;

  StrukPage({required this.transaksi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Struk Transaksi"),
        backgroundColor: const Color(0xFF6A4E23),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nama Menu: ${transaksi.nama_menu}'),
            Text('Quantity: ${transaksi.quantity}'),
            Text('Jenis: ${transaksi.jenis}'),
            Text('Tanggal: ${transaksi.tanggal}'),
            Text('Notes: ${transaksi.notes}'),
            Text('Nama Kasir: ${transaksi.nama_kasir}'),
            Text('Nomor Meja: ${transaksi.nomor_meja}'),
            Text('Nama Pelanggan: ${transaksi.nama_pelanggan}'),
            // Format the total purchase amount as currency
            Text('Total Pembelian:Rp. ${transaksi.total_pembelian}'),
          ],
        ),
      ),
    );
  }
}
