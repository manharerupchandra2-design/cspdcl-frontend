class PreviousBill {
  final int previousReading;
  final int currentReading;
  final int units;
  final String amount;

  PreviousBill({
    required this.previousReading,
    required this.currentReading,
    required this.units,
    required this.amount,
  });

  factory PreviousBill.fromJson(Map<String, dynamic> json) {
    return PreviousBill(
      previousReading: json['previous_reading'] ?? 0,

      currentReading: json['current_reading'] ?? 0,

      units: json['units'] ?? 0,

      amount: json['amount']?.toString() ?? "0",
    );
  }
}
