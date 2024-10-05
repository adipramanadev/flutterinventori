import 'package:flutter/material.dart';
import 'package:flutterinventori/model/PegawaiModel.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  final PegawaiModel pegawai;
  DetailPage({required this.pegawai, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[200], // Warna latar belakang yang lebih lembut
      appBar: AppBar(
        automaticallyImplyLeading: false, // Tambahkan tombol kembali
        title: Text(
          widget.pegawai.nama ?? 'Detail Pegawai',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Buat sudut kartu melengkung
          ),
          elevation: 8, // Tambahkan shadow untuk efek mengambang
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan nama pegawai
                Center(
                  child: Text(
                    'Detail Pegawai',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Nama Pegawai
                _buildDetailRow(
                    'Nama Pegawai:', widget.pegawai.nama ?? 'Tidak tersedia'),

                Divider(), // Divider untuk memisahkan item

                // NIP Pegawai
                _buildDetailRow('NIP:', widget.pegawai.nip ?? 'Tidak tersedia'),

                Divider(),

                // Alamat Pegawai
                _buildDetailRow(
                    'Alamat:', widget.pegawai.alamat ?? 'Tidak tersedia'),

                Divider(),

                // Tanggal Dibuat
                _buildDetailRow('Created At:',
                    widget.pegawai.createdAt ?? 'Tidak tersedia'),

                Divider(),

                // Tanggal Diperbarui
                _buildDetailRow('Updated At:',
                    widget.pegawai.updatedAt ?? 'Tidak tersedia'),

                SizedBox(height: 16.0),

                // Tombol kembali (Opsional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //tombol edit
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar("Info", "Fungsi Edit nanti disini ");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //tombol hapus
                     //tombol edit
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar("Info", "Fungsi Edit nanti disini ");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigasi kembali
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk menampilkan baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
