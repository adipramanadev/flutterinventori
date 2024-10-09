import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterinventori/model/PegawaiModel.dart';
import 'package:flutterinventori/services/PegawaiService.dart';
import 'package:flutterinventori/views/detailpage.dart';
import 'package:flutterinventori/views/tambahdata.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Pegawaiservice pegawaiservice = Pegawaiservice();
  List<PegawaiModel> pegawaiList = []; // Daftar pegawai asli dari server
  List<PegawaiModel> filteredList = []; // Daftar pegawai yang difilter
  TextEditingController searchController = TextEditingController(); // Controller untuk input pencarian

  // Function to load pegawai data
  _loadPegawai() async {
    pegawaiList = await pegawaiservice.getPegawai();
    setState(() {
      filteredList = pegawaiList; // Inisialisasi daftar yang difilter
    });
  }

  // Function untuk pencarian data pegawai berdasarkan nama
  _searchPegawai(String query) {
    final filtered = pegawaiList.where((pegawai) {
      final namaLower = pegawai.nama?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();
      return namaLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredList = filtered;
    });
  }

  // Initialize data when the widget is loaded
  @override
  void initState() {
    _loadPegawai();
    Timer.periodic(Duration(seconds: 3), (timer) {
      _loadPegawai();
    }); //walaupun sudah bisa menampilkan data secara real time,
    //tapi klo untuk production ga rekomendasi, seharusnya pakai web socket
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Cari Pegawai...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: _searchPegawai, // Setiap input pencarian, filter data
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              // Navigasi ke halaman tambah data
              Get.to(() => Tambahdata());
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: filteredList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      elevation: 4, // Add shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            filteredList[index].nama?.substring(0, 1) ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          filteredList[index].nama ?? 'Nama tidak tersedia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NIP: ${filteredList[index].nip ?? 'Tidak tersedia'}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Alamat: ${filteredList[index].alamat ?? 'Alamat tidak tersedia'}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Colors.blueAccent),
                        onTap: () {
                          // Navigasi ke halaman detail pegawai
                          Get.to(() => DetailPage(pegawai: filteredList[index]));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
