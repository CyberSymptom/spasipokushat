extension DateTimeExtension on DateTime {
  String toReadableFormat() {
    const List<String> monthNames = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];

    final String monthName = monthNames[month - 1];
    final String day = this.day.toString();
    final String year = this.year.toString();
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');

    return '$day $monthName $yearг. в $hour:$minute';
  }
}
