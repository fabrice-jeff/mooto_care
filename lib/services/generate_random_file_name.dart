String generateRandomFileName(String debut) {
  var now = DateTime.now();
  var formattedDate =
      '${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}';

  return '${debut}_${formattedDate}';
}
