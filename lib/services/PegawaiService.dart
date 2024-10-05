import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/PegawaiModel.dart';

class Pegawaiservice {
  //url  api
  final String apiUrl = "http://192.168.100.17:8000/api";

  //GET: mendapatkan semua data pegawai
  Future<List<PegawaiModel>> getPegawai() async {
    final response = await http.get(Uri.parse('$apiUrl/get-pegawai'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => PegawaiModel.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //post menyimpan data
  Future<PegawaiModel> createPegawai(PegawaiModel pegawai) async {
    final response = await http.post(
      Uri.parse('$apiUrl/pegawai-store'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(pegawai.toJson()),
    );
    if (response.statusCode == 200) {
      return PegawaiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  //untuk delete data 
  Future<void>deletePegawai(int id) async{
    final response = await http.delete(Uri.parse('$apiUrl/pegawai/delete/$id'));
    if(response.statusCode == 200 || response.statusCode == 204){
      //berhasil di hapus 
      print('pegawai dengan id $id berhasil di hapus');
    } else{
      throw Exception('Gagal menghapus data');
    }
  }
}
