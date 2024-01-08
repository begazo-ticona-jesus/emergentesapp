import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartSample extends StatelessWidget {
  final List<String> data; // Tu lista de datos [alto, medio, bajo, ...]

  const LineChartSample({Key? key, required this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<String> last10Data = data.length > 10 ? data.sublist(data.length - 10) : data;
    List<Color> gradientColors = [
      const Color(0xFF343764),
      const Color(0xFFa4acf4),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250.0,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles:  SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 35,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff37434d),
                width: 1,
              ),
            ),
            minX: 0,
            maxX: last10Data.length.toDouble() - 1,
            minY: 0,
            maxY: 4,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(last10Data.length, (index) {
                  return FlSpot(index.toDouble(), mapStringToValue(last10Data[index]));
                }),
                isCurved: true,
                color: const Color(0xFF343764),
                belowBarData: BarAreaData(
                    show: true,
                  gradient: LinearGradient(
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.5))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double mapStringToValue(String value) {
    switch (value.toLowerCase()) {
      case 'alto':
        return 3.0;
      case 'medio':
        return 2.0;
      case 'bajo':
        return 1.0;
      default:
        return 0.0;
    }
  }
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    IconData iconData;
    switch (value.toInt()) {
      case 1:
        iconData = Icons.wb_sunny_outlined;
        break;
      case 2:
        iconData = Icons.sunny_snowing;
        break;
      case 3:
        iconData = Icons.sunny;
        break;
      default:
        return Container();
    }

    return Icon(iconData, size: 30, color: const Color(0xFF343764));
  }

}