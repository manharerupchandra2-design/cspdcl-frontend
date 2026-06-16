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

// class DashboardData {
//   final int totalConsumers;
//   final int totalReadings;
//   final int totalBills;
//
//   DashboardData({
//     required this.totalConsumers,
//     required this.totalReadings,
//     required this.totalBills,
//   });
//
//   factory DashboardData.fromJson(Map<String, dynamic> json) {
//     return DashboardData(
//       totalConsumers: json['total_consumers'],
//       totalReadings: json['total_readings'],
//       totalBills: json['total_bills'],
//     );
//   }
// }

class DashboardData {
  final int totalConsumers;
  final int totalReadings;
  final int totalBills;
  final int todayReadings;      // ← add
  final int todayBills;         // ← add
  final int pendingToday;       // ← add
  final List<RecentReading> recentReadings; // ← add

  DashboardData({
    required this.totalConsumers,
    required this.totalReadings,
    required this.totalBills,
    required this.todayReadings,
    required this.todayBills,
    required this.pendingToday,
    required this.recentReadings,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalConsumers: json['total_consumers'],
      totalReadings: json['total_readings'],
      totalBills: json['total_bills'],
      todayReadings: json['today_readings'] ?? 0,
      todayBills: json['today_bills'] ?? 0,
      pendingToday: json['pending_today'] ?? 0,
      recentReadings: (json['recent_readings'] as List)
          .map((e) => RecentReading.fromJson(e))
          .toList(),
    );
  }
}

class RecentReading {
  final int id;
  final int currentReading;
  final String readingDate;
  final String consumerName;
  final String consumerNo;

  RecentReading({
    required this.id,
    required this.currentReading,
    required this.readingDate,
    required this.consumerName,
    required this.consumerNo,
  });

  factory RecentReading.fromJson(Map<String, dynamic> json) {
    return RecentReading(
      id: json['id'],
      currentReading: json['current_reading'] ?? 0,
      readingDate: json['reading_date'] ?? '',
      consumerName: json['consumer_name'] ?? '',
      consumerNo: json['consumer_no'] ?? '',
    );
  }
}