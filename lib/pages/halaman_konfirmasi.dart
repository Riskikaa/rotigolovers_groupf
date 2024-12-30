import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/restapi.dart';
import '../utils/config.dart';
import '../utils/rotigolovers_model.dart';

class FormInput extends StatefulWidget {
  final String? initialNamaMenu; // Tambahkan parameter untuk nama_menu

  const FormInput({Key? key, this.initialNamaMenu}) : super(key: key);

  @override
  FormInputAddState createState() => FormInputAddState();
}

class FormInputAddState extends State<FormInput> {
  final id = TextEditingController();
  final nama_menu = TextEditingController();
  final quantity = TextEditingController();
  String jenis = 'Hot';
  final tanggal = TextEditingController();
  final notes = TextEditingController();
  String nama_kasir = 'Kasir 1';
  final nomor_meja = TextEditingController();
  final nama_pelanggan = TextEditingController();
  final total_pembelian = TextEditingController();

  late Future<DateTime?> selectDate;

  DataService ds = DataService();

  @override
  void initState() {
    super.initState();
    // Setel nilai nama_menu jika ada
    if (widget.initialNamaMenu != null) {
      nama_menu.text = widget.initialNamaMenu!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Input',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.brown, // Set background color to brown
        foregroundColor: Colors.white, // Set text color to white
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(nama_menu, 'Nama Menu'),
                _buildTextField(quantity, 'Quantity'),
                _buildDropdownField('Jenis', ['Hot', 'Ice'],
                    (String? newValue) {
                  setState(() {
                    jenis = newValue!;
                  });
                }, jenis),
                _buildTextField(tanggal, 'Tanggal', onTap: () {
                  showDialogPicker(context);
                }),
                _buildTextField(notes, 'Notes'),
                _buildDropdownField('Nama Kasir', ['Kasir 1', 'Kasir 2'],
                    (String? newValue) {
                  setState(() {
                    nama_kasir = newValue!;
                  });
                }, nama_kasir),
                _buildTextField(nomor_meja, 'Nomor Meja'),
                _buildTextField(nama_pelanggan, 'Nama Pelanggan'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF6A4E23), // Brown color for button
                        elevation: 0,
                      ),
                      onPressed: () async {
                        // Validasi input
                        if (nama_menu.text.isEmpty || quantity.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Nama Menu dan Quantity tidak boleh kosong')));
                          return; // Hentikan eksekusi jika ada input yang kosong
                        }

                        try {
                          // Pastikan parameter yang dikirim benar
                          List response =
                              jsonDecode(await ds.insertRotigolovers(
                            appid,
                            nama_menu.text,
                            quantity.text,
                            jenis,
                            tanggal.text,
                            notes.text,
                            nama_kasir,
                            nomor_meja.text,
                            nama_pelanggan.text,
                            total_pembelian.text,
                          ));

                          if (kDebugMode) {
                            print(response); // Debug response
                          }

                          List<RotigoloversModel> rotigolovers = response
                              .map((e) => RotigoloversModel.fromJson(e))
                              .toList();

                          if (rotigolovers.length == 1) {
                            // Menavigasi ke halaman struk setelah berhasil simpan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StrukPage(
                                  transaksi: rotigolovers.first,
                                ),
                              ),
                            );
                          } else {
                            if (kDebugMode) {
                              print("Error response: $response"); // Log error
                            }
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print("Error: $e"); // Tangani kesalahan
                          }
                        }
                      },
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                            color: Colors.white), // Adjusted text color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          fillColor: Color(0xFFFAEBD7), // Light brown for background color
          filled: true,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      ValueChanged<String?> onChanged, String currentValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: label,
          fillColor: Color(0xFFFAEBD7), // Light brown for background color
          filled: true,
        ),
        value: currentValue,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  void showDialogPicker(BuildContext context) {
    var date = DateTime.now();

    selectDate = showDatePicker(
      context: context,
      initialDate: DateTime(date.year, date.month, date.day),
      firstDate: DateTime(1980),
      lastDate: DateTime(date.year, date.month, date.day),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    selectDate.then((value) {
      setState(() {
        if (value == null) return;

        final DateFormat formatter = DateFormat('dd-MMM-yyyy');
        final String formattedDate = formatter.format(value);

        tanggal.text = formattedDate;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}

class StrukPage extends StatelessWidget {
  final RotigoloversModel transaksi;

  StrukPage({required this.transaksi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Struk Transaksi"),
        backgroundColor: Color(0xFF6A4E23), // Brown color for AppBar
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
            Text('Total Pembelian: ${transaksi.total_pembelian}'),
          ],
        ),
      ),
    );
  }
}
