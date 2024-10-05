class PegawaiModel {
  int? id;
  String? nama;
  String? nip;
  String? alamat;
  String? createdAt;
  String? updatedAt;

  PegawaiModel(
      {this.id,
      this.nama,
      this.nip,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  PegawaiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nip = json['nip'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['nip'] = this.nip;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}