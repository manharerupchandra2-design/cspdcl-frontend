class DashboardResponse {
  final bool success;
  final DashboardData data;

  DashboardResponse({
    required this.success,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'],
      data: DashboardData.fromJson(json['data']),
    );
  }
}

class DashboardData {
  final int totalConsumers;
  final int totalReadings;
  final int totalBills;

  DashboardData({
    required this.totalConsumers,
    required this.totalReadings,
    required this.totalBills,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalConsumers: json['total_consumers'],
      totalReadings: json['total_readings'],
      totalBills: json['total_bills'],
    );
  }
}