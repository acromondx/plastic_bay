enum OrderStatus {
  pending('Pending'),
  processing('Processing'),
  shipped('Shipped'),
  delivered('Delivered'),
  cancelled('Cancelled');
  final String name;
  const OrderStatus(this.name);
}

OrderStatus orderStatusFromString(String status) => switch (status) {
      'Pending' => OrderStatus.pending,
      'Processing' => OrderStatus.processing,
      'Shipped' => OrderStatus.shipped,
      'Delivered' => OrderStatus.delivered,
      'Cancelled' => OrderStatus.cancelled,
      _ => OrderStatus.pending,
    };
