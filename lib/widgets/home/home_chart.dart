import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/constants.dart';

class _ChartData {
  _ChartData(this.x, this.y1, this.y2, this.y3, this.y4);

  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}

class HomeChartPage extends StatefulWidget {
  const HomeChartPage({super.key});

  @override
  State<HomeChartPage> createState() => _HomeChartPageState();
}

class _HomeChartPageState extends State<HomeChartPage> {
  List<_ChartData> data2 = [
    _ChartData('50w', 15, 15, 15, 15),
    _ChartData('100w', 25, 30, 25, 30),
    _ChartData('150w', 20, 20, 20, 20),
    _ChartData('200w', 30, 55, 30, 35),
    _ChartData('250w', 20, 30, 35, 20),
    _ChartData('300w', 10, 10, 8, 25),
  ];

  final colorList = [
    const Color.fromRGBO(220, 237, 194, 1),
    const Color.fromRGBO(253, 116, 72, 1),
    const Color.fromRGBO(26, 181, 141, 1),
    const Color.fromRGBO(255, 184, 0, 1),
  ];

  List<StackedColumnSeries<_ChartData, String>> _getStackedColumnSeries() {
    return <StackedColumnSeries<_ChartData, String>>[
      StackedColumnSeries<_ChartData, String>(
          dataSource: data2,
          color: colorList[3],
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y1,
          name: 'House Load'),
      StackedColumnSeries<_ChartData, String>(
          dataSource: data2,
          color: colorList[2],
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          name: 'Production'),
      StackedColumnSeries<_ChartData, String>(
          dataSource: data2,
          color: colorList[1],
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y3,
          name: 'Grid Load'),
      StackedColumnSeries<_ChartData, String>(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          dataSource: data2,
          color: colorList[0],
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y4,
          name: 'Battery Load')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.inputColor,
      ),
      height: 250,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: const Legend(
          orientation: LegendItemOrientation.vertical,
          alignment: ChartAlignment.far,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(
            color: AppColors.GreyTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          isVisible: true,
        ),
        primaryXAxis: const CategoryAxis(
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(
            width: 0,
          ),
          majorTickLines: MajorTickLines(size: 0, width: 0),
        ),
        primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}K',
          majorGridLines: MajorGridLines(
              width: 1,
              color: AppColors.GreyTextColor,
              dashArray: <double>[1, 1]),
          majorTickLines: MajorTickLines(size: 0, width: 0),
        ),
        series: _getStackedColumnSeries(),
        tooltipBehavior: TooltipBehavior(
            enable: true, header: '', canShowMarker: false),
      ),
    );
  }
}
