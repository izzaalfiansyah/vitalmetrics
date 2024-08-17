class Bahan {
  String nama;
  String jumlahUrt;
  num berat;
  num energi;
  num protein;
  num lemak;
  num kh;

  Bahan({
    this.nama = '',
    this.jumlahUrt = '',
    this.berat = 0,
    this.energi = 0,
    this.protein = 0,
    this.lemak = 0,
    this.kh = 0,
  });

  factory Bahan.fromJson(Map<String, dynamic> map) {
    return Bahan(
      nama: map['nama'],
      jumlahUrt: map['jumlah_urt'],
      berat: map['berat'],
      energi: map['energi'],
      protein: map['protein'],
      lemak: map['lemak'],
      kh: map['kh'],
    );
  }

  toJson() {
    return {
      'nama': nama,
      'jumlah_urt': jumlahUrt,
      'berat': berat,
      'energi': energi,
      'protein': protein,
      'lemak': lemak,
      'kh': kh,
    };
  }
}

class MenuMakanan {
  dynamic id;
  String waktu;
  num umurMin;
  num umurMax;
  String kategoriGizi;
  String nama;
  List<Bahan>? bahan;

  MenuMakanan({
    this.id,
    this.waktu = '',
    this.umurMin = 0,
    this.umurMax = 0,
    this.kategoriGizi = '',
    this.nama = '',
    this.bahan,
  });

  factory MenuMakanan.fromJson(Map<String, dynamic> map) {
    return MenuMakanan(
      id: map['id'],
      waktu: map['waktu'],
      umurMin: map['umur_min'],
      umurMax: map['umur_max'],
      kategoriGizi: map['kategori_gizi'],
      nama: map['nama'],
      bahan: List.from(map['bahan'].map((item) => Bahan.fromJson(item))),
    );
  }

  toJson() {
    return {
      'id': id,
      'waktu': waktu,
      'umur_min': umurMin,
      'umur_max': umurMax,
      'kategori_gizi': kategoriGizi,
      'nama': nama,
      'bahan': List.from((bahan ?? []).map((item) => item.toJson()).toList()),
    };
  }
}
