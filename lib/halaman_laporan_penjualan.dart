import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'rotigolovers_model.dart';
import 'restapi.dart';
import 'config.dart';

class RotigoloversLaporan extends StatefulWidget {
  const RotigoloversLaporan({Key? key}) : super(key: key);

  @override
  RotigoloversLaporanState createState() => RotigoloversLaporanState();
}

class RotigoloversLaporanState extends State<RotigoloversLaporan> {
  final searchKeyword = TextEditingController();
  bool searchStatus = false;

  DataService ds = DataService();

  List data = [];
  List<RotigoloversModel> rotigolovers = [];

  List<RotigoloversModel> search_data = [];
  List<RotigoloversModel> search_data_pre = [];

  @override
  void initState() {
    super.initState();
    selectAllRotigolovers();
  }

  Future<void> selectAllRotigolovers() async {
    data =
        jsonDecode(await ds.selectAll(Token, Project, 'rotigolovers', appid));

    rotigolovers = data.map((e) => RotigoloversModel.fromJson(e)).toList();

    setState(() {
      rotigolovers = rotigolovers;
    });
  }

  void filterRotigolovers(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      search_data = data.map((e) => RotigoloversModel.fromJson(e)).toList();
    } else {
      search_data_pre = data.map((e) => RotigoloversModel.fromJson(e)).toList();
      search_data = search_data_pre
          .where((user) => user.nama_menu
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      rotigolovers = search_data;
    });
  }

  Future reloadDataRotigolovers(dynamic value) async {
    selectAllRotigolovers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laporan Penjualan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.brown, // Set background color to brown
        foregroundColor: Colors.white, // Set text color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Laporan Penjualan - Rotigolovers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: rotigolovers.length,
                itemBuilder: (context, index) {
                  final item = rotigolovers[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(item.nama_menu,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal: ${item.tanggal}',
                              style: const TextStyle(color: Colors.black54)),
                          Text('Jumlah: ${item.quantity}',
                              style: const TextStyle(color: Colors.black54)),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.brown),
                      onTap: () {
                        Navigator.pushNamed(context, 'halaman_detail_laporan',
                            arguments: [item.id]).then(reloadDataRotigolovers);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchIcon() {
    return !searchStatus
        ? Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  searchStatus = true;
                });
              },
              child: const Icon(
                Icons.search,
                size: 26.0,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  searchStatus = false;
                });
              },
              child: const Icon(
                Icons.close,
                size: 26.0,
              ),
            ),
          );
  }

  Widget searchField() {
    return TextField(
      controller: searchKeyword,
      autofocus: true,
      cursorColor: Colors.white,
      onChanged: filterRotigolovers,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      decoration: const InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
    );
  }
}





// import 'dart:convert';
// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:file_picker/file_picker.dart';

// import 'rotigolovers_Model.dart';
// import 'restapi.dart';
// import 'config.dart';

// class LaporanPage extends StatefulWidget {
//   const LaporanPage({Key? key}) : super(key: key);

//   @override
//   LaporanPageState createState() => LaporanPageState();
// }

// class LaporanPageState extends State<LaporanPage> {
//   DataService ds = DataService();
//   String gambar_menu = '';
//   late ValueNotifier<int> _notifier;
//   List<RotigoloversModel> rotigolovers = [];
//   List data = [];

//   @override
//   void initState() {
//     super.initState();
//     _notifier = ValueNotifier<int>(0);
//   }

//   Future<void> selectIdRotigolovers(String id) async {
//     data = jsonDecode(
//         await ds.selectId(Token, Project, 'rotigolovers', appid, id));
//     rotigolovers = data.map((e) => RotigoloversModel.fromJson(e)).toList();
//     // gambar_menu = rotigolovers[0].gambar_menu;
//   }

//   Future<void> reloadDataRotigolovers(dynamic value) async {
//     setState(() {
//       final args = ModalRoute.of(context)?.settings.arguments as List<String>;
//       selectIdRotigolovers(args[0]);
//     });
//   }

//   // Future<void> pickImage(String id) async {
//   //   try {
//   //     var picked = await FilePicker.platform.pickFiles(withData: true);
//   //     if (picked != null) {
//   //       var response = await ds.upload(Token, Project,
//   //           picked.files.first.bytes!, picked.files.first.extension.toString());
//   //       var file = jsonDecode(response);
//   //       await ds.updateId('gambar_menu', file['assets/pic.jpeg'], Token,
//   //           Project, 'restoran', appid, id);
//   //       gambar_menu = file['assets/pic.jpeg'];
//   //       _notifier.value++;
//   //     }
//   //   } on PlatformException catch (e) {
//   //     if (kDebugMode) {
//   //       print(e);
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments as List<String>;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Laporan"),
//         elevation: 0,
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               // onTap: () => pickImage(args[0]),
//               child: const Icon(
//                 Icons.camera_alt,
//                 size: 26.0,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               onTap: () {
//                 if (kDebugMode) {
//                   print(rotigolovers);
//                 }
//                 Navigator.pushNamed(context, 'restoran_form_edit',
//                     arguments: [args[0]]).then(reloadDataRotigolovers);
//               },
//               child: const Icon(
//                 Icons.edit,
//                 size: 26.0,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   barrierDismissible: false,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text("Warning"),
//                       content: const Text("Remove this data?"),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close Dialog
//                           },
//                           child: const Text("CANCEL"),
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             Navigator.of(context).pop(); // Close Dialog
//                             bool response = await ds.removeId(
//                                 Token, Project, 'rotigolovers', appid, args[0]);
//                             if (response) {
//                               Navigator.pop(context, true);
//                             }
//                           },
//                           child: const Text("REMOVE"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: const Icon(
//                 Icons.delete_outline,
//                 size: 26.0,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: FutureBuilder<dynamic>(
//         future: selectIdRotigolovers(args[0]),
//         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return const Text('None');
//             case ConnectionState.waiting:
//               return const Center(child: CircularProgressIndicator());
//             case ConnectionState.active:
//               return const Text('Active');
//             case ConnectionState.done:
//               if (snapshot.hasError) {
//                 return Text(
//                   '${snapshot.error}',
//                   style: const TextStyle(color: Colors.red),
//                 );
//               } else {
//                 return ListView(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(color: Colors.purple),
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.40,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               ValueListenableBuilder(
//                                 valueListenable: _notifier,
//                                 builder: (context, value, child) =>
//                                     gambar_menu.isEmpty
//                                         ? const Align(
//                                             alignment: Alignment.bottomCenter,
//                                             child: Icon(
//                                               Icons.person,
//                                               color: Colors.white,
//                                               size: 130,
//                                             ),
//                                           )
//                                         : Align(
//                                             alignment: Alignment.bottomCenter,
//                                             child: CircleAvatar(
//                                               radius: 80,
//                                               backgroundImage: NetworkImage(
//                                                   fileUri + gambar_menu),
//                                             ),
//                                           ),
//                               ),
//                               // InkWell(
//                               //   onTap: () => pickImage(args[0]),
//                               //   child: Align(
//                               //     alignment: Alignment.bottomCenter,
//                               //     child: Container(
//                               //       height: 30.0,
//                               //       width: 30.0,
//                               //       margin: const EdgeInsets.only(
//                               //           left: 183.00,
//                               //           top: 10.00,
//                               //           right: 113.00),
//                               //       decoration: BoxDecoration(
//                               //         color: Colors.white70,
//                               //         borderRadius: BorderRadius.circular(5.00),
//                               //       ),
//                               //       child: const Icon(
//                               //         Icons.camera_alt_outlined,
//                               //         size: 20,
//                               //         color: Colors.black,
//                               //       ),
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.all(5),
//                                 child: Text(
//                                   rotigolovers[0].nama_menu,
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 30),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.center,
//                           //   children: <Widget>[
//                           //     Padding(
//                           //       padding: const EdgeInsets.all(5),
//                           //       child: Text(
//                           //         restoran[0].nama_menu,
//                           //         style: const TextStyle(
//                           //             color: Colors.white, fontSize: 30),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].quantity),
//                         subtitle: const Text(
//                           "Quantity",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].jenis),
//                         subtitle: const Text(
//                           "Jenis",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].tanggal),
//                         subtitle: const Text(
//                           "tanggal",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].notes),
//                         subtitle: const Text(
//                           "notes",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].nama_kasir),
//                         subtitle: const Text(
//                           "Kasir",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].nomor_meja),
//                         subtitle: const Text(
//                           "nomor meja",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         title: Text(rotigolovers[0].nama_pelanggan),
//                         subtitle: const Text(
//                           "nama pelanggan",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         leading: IconButton(
//                           icon: const Icon(
//                             Icons.person,
//                             color: Colors.purple,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _notifier.dispose();
//     super.dispose();
//   }
// }
