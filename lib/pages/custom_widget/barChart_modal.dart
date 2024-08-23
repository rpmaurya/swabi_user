import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModal {
  String rentalName;
  int rentaData;
  final charts.Color color;
  BarChartModal(
      // ignore: avoid_types_as_parameter_names
      {
    required this.rentalName,
    required this.rentaData,
    required this.color,
  });
}
