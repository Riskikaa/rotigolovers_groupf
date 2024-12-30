import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rotigolovers_groupf/pages/halaman_struk.dart';
import '../utils/restapi.dart';
import '../utils/config.dart';
import '../utils/rotigolovers_model.dart';

class FormInput extends StatefulWidget {
  final String? initialNamaMenu;
  final String? initialHarga;
  final String? initialQuantity;
  final String? initialTotalPembelian;

  const FormInput(
      {Key? key,
      this.initialNamaMenu,
      this.initialHarga,
      this.initialQuantity,
      this.initialTotalPembelian})
      : super(key: key);

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
  final harga = TextEditingController();

  late Future<DateTime?> selectDate;

  DataService ds = DataService();

  @override
  void initState() {
    super.initState();
    if (widget.initialNamaMenu != null) {
      nama_menu.text = widget.initialNamaMenu!;
    }
    if (widget.initialHarga != null) {
      harga.text = widget.initialHarga!;
    }
    if (widget.initialQuantity != null) {
      quantity.text = widget.initialQuantity!;
    }
    if (widget.initialTotalPembelian != null) {
      total_pembelian.text = widget.initialTotalPembelian!;
    }
  }

  // Method to format currency
  String formatCurrency(String amount) {
    final format = NumberFormat.simpleCurrency(locale: 'id_ID');
    final parsedAmount = double.tryParse(amount) ?? 0;
    return format.format(parsedAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Input Pesanan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildFormSection(
              title: "Detail Menu",
              children: [
                _buildTextField(nama_menu, 'Nama Menu'),
                _buildTextField(quantity, 'Quantity',
                    keyboardType: TextInputType.number),
                _buildDropdownField('Jenis', ['Hot', 'Ice'],
                    (String? newValue) {
                  setState(() {
                    jenis = newValue!;
                  });
                }, jenis),
                _buildTextField(harga, 'Harga',
                    keyboardType: TextInputType.number, onChanged: (value) {
                  // Format harga when the user enters the value
                  harga.text = formatCurrency(value);
                  harga.selection = TextSelection.fromPosition(
                      TextPosition(offset: harga.text.length));
                }),
              ],
            ),
            _buildFormSection(
              title: "Informasi Tambahan",
              children: [
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
              ],
            ),
            _buildFormSection(
              title: "Ringkasan Pembelian",
              children: [
                _buildTextField(total_pembelian, 'Total Pembelian',
                    keyboardType: TextInputType.number, onChanged: (value) {
                  // Format total_pembelian when the user enters the value
                  total_pembelian.text = formatCurrency(value);
                  total_pembelian.selection = TextSelection.fromPosition(
                      TextPosition(offset: total_pembelian.text.length));
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A4E23),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    if (nama_menu.text.isEmpty ||
                        quantity.text.isEmpty ||
                        harga.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Nama Menu, Quantity, dan Harga tidak boleh kosong')));
                      return;
                    }

                    try {
                      List response = jsonDecode(await ds.insertRotigolovers(
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
                        print(response);
                      }

                      List<RotigoloversModel> rotigolovers = response
                          .map((e) => RotigoloversModel.fromJson(e))
                          .toList();

                      if (rotigolovers.length == 1) {
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
                          print("Error response: $response");
                        }
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print("Error: $e");
                      }
                    }
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {VoidCallback? onTap,
      TextInputType keyboardType = TextInputType.text,
      ValueChanged<String>? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          fillColor: const Color(0xFFFAEBD7),
          filled: true,
        ),
        onTap: onTap,
        onChanged: onChanged,
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
          fillColor: const Color(0xFFFAEBD7),
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

  Widget _buildFormSection(
      {required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            ...children,
          ],
        ),
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
