enum OrderStatusEnum {
  draft('Создан'),
  created('Оформлен'),
  ready('Ожидает'),
  canceled('Отменен'),
  picked('Получен'),
  undefined('');

  final String value;

  const OrderStatusEnum(this.value);

  factory OrderStatusEnum.fromValue(String value) {
    switch (value) {
      case 'Оформлен':
        return OrderStatusEnum.created;
      case 'Ожидает':
        return OrderStatusEnum.ready;
      case 'Отменен':
        return OrderStatusEnum.canceled;
      case 'Получен':
        return OrderStatusEnum.picked;
      case 'Создан':
        return OrderStatusEnum.draft;
      default:
        return OrderStatusEnum.undefined;
    }
  }
}
