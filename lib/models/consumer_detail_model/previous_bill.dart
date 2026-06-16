class PreviousBill {
  final int previousReading;
  final int currentReading;
  final int units;
  final String totalAmount;

  PreviousBill({
    required this.previousReading,
    required this.currentReading,
    required this.units,
    required this.totalAmount,
  });

  factory PreviousBill.fromJson(Map<String, dynamic> json) {
    return PreviousBill(
      previousReading: json['previous_reading'] ?? 0,

      currentReading: json['current_reading'] ?? 0,

      units: json['units'] ?? 0,

      totalAmount: json['total_amount']?.toString() ?? "0",
    );
  }
}
