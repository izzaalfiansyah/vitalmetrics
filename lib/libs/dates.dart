List<String> bulan = [
  '',
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

formatDate(String date) {
  if (date == '') {
    return '';
  }

  DateTime dateTime = DateTime.parse(date);
  String result = '${dateTime.day} ${bulan[dateTime.month]} ${dateTime.year}';

  return result;
}

formatDateTime(String date) {
  if (date == '') {
    return '';
  }

  DateTime dateTime = DateTime.parse(date);
  String result =
      '${dateTime.day} ${bulan[dateTime.month]} ${dateTime.year} ${dateTime.hour}:${dateTime.minute}';

  return result;
}
