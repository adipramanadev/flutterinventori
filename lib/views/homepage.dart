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
  List<PegawaiModel> pegawaiList = [];

  // Function to load pegawai data
  _loadPegawai() async {
    pegawaiList = await pegawaiservice.getPegawai();
    setState(() {});
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
      backgroundColor: Colors.white, // Soft background color
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              //navigasi ke halaman tambah dengan get
              Get.to(() => Tambahdata());
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Daftar Pegawai',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: pegawaiList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.all(8.0), // Add padding for better spacing
              child: ListView.builder(
                itemCount: pegawaiList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      elevation: 4, // Add shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Rounded corners for the card
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 8), // Space between cards
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            pegawaiList[index].nama?.substring(0, 1) ??
                                '', // Initials of the name
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          pegawaiList[index].nama ?? 'Nama tidak tersedia',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NIP: ${pegawaiList[index].nip ?? 'Tidak tersedia'}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Alamat: ${pegawaiList[index].alamat ?? 'Alamat tidak tersedia'}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Colors.blueAccent),
                        onTap: () {
                          //detail page disini nantinya 
                           Get.to(() => DetailPage(pegawai: pegawaiList[index]));
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
