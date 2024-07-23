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

  String hour =
      dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
  String minute =
      dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();

  String result =
      '${dateTime.day} ${bulan[dateTime.month]} ${dateTime.year} $hour:$minute';

  return result;
}
