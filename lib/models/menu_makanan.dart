class Bahan {
  final String nama;
  final String jumlahUrt;
  final num berat;
  final num energi;
  final num protein;
  final num lemak;
  final num kh;

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
  final dynamic id;
  final String waktu;
  final num umurMin;
  final num umurMax;
  final String kategoriGizi;
  final String nama;
  final List<Bahan>? bahan;

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
      'kategori_mizi': kategoriGizi,
      'nama': nama,
      'bahan': bahan?.map((item) => item.toJson()),
    };
  }
}
