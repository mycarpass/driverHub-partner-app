import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LastWeekEarnChart extends StatelessWidget {
  LastWeekEarnChart({
    super.key,
    required this.presenter,
  });

  final HomePresenter presenter;

  // final List<ChartData> data = [
  //   ChartData(xval: 'Polimento', yval: 10),
  //   ChartData(xval: 'Vitrificação', yval: 20),
  //   ChartData(xval: 'Lavada simplessasdasdasda', yval: 24),
  //   ChartData(xval: 'Michael', yval: 20),
  //   ChartData(xval: 'Janet', yval: 23),
  //   ChartData(xval: 'Janet', yval: 23),
  //   ChartData(xval: 'Janet', yval: 23),
  // ];

  final List<ChartData> data = [
    ChartData(
        xval: 600, yval: DateTime.now().subtract(const Duration(days: 6))),
    ChartData(
        xval: 500, yval: DateTime.now().subtract(const Duration(days: 5))),
    ChartData(
        xval: 500, yval: DateTime.now().subtract(const Duration(days: 4))),
    ChartData(xval: 0, yval: DateTime.now().subtract(const Duration(days: 3))),
    ChartData(
        xval: 900, yval: DateTime.now().subtract(const Duration(days: 2))),
    ChartData(
        xval: 1200, yval: DateTime.now().subtract(const Duration(days: 1))),
    ChartData(xval: 600, yval: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColor.backgroundTransparent,
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.all(24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColor.iconSecondaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Faturamento da semana').body_bold(),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text('Últimos 7 dias').caption1_regular(
                          style: const TextStyle(
                              color: AppColor.textTertiaryColor))
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              SfCartesianChart(
                  isTransposed: true,
                  primaryYAxis: NumericAxis(
                      minorGridLines: const MinorGridLines(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      maximumLabelWidth: 58,
                      opposedPosition: true,
                      numberFormat: NumberFormat.simpleCurrency(
                          locale: "pt_BR", decimalDigits: 0),
                      isVisible: false),
                  primaryXAxis: DateTimeAxis(
                      minorGridLines: const MinorGridLines(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      interval: 1,
                      dateFormat: DateFormat('d, EEE', 'pt_BR'),
                      opposedPosition: false,
                      labelStyle: const TextStyle(fontFamily: 'CircularStd'),
                      borderWidth: 0,
                      isVisible: true),
                  series: <ChartSeries>[
                    ColumnSeries<ChartData, DateTime>(
                        dataSource: data,
                        color: AppColor.accentColor,
                        dataLabelMapper: (datum, index) =>
                            NumberFormat.simpleCurrency(locale: "pt_BR")
                                .format(datum.xval)
                                .toString(),
                        dataLabelSettings: const DataLabelSettings(
                            showZeroValue: false,
                            isVisible: true,
                            textStyle: TextStyle(
                                fontFamily: 'CircularStd', fontSize: 11)),
                        trackBorderColor: AppColor.accentColor,
                        borderColor: AppColor.blackColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(6),
                            topRight: Radius.circular(6)),
                        borderWidth: 0.2,
                        enableTooltip: true,
                        xValueMapper: (ChartData data, _) => data.yval,
                        yValueMapper: (ChartData data, _) => data.xval)
                  ])

              // SfCartesianChart(
              //     primaryXAxis: CategoryAxis(),
              //     // Chart title
              //     title: ChartTitle(text: 'Half yearly sales analysis'),
              //     // Enable legend
              //     legend: Legend(isVisible: true),
              //     // Enable tooltip
              //     tooltipBehavior: TooltipBehavior(enable: true),
              //     series: <ChartSeries<_SalesData, String>>[
              //       LineSeries<_SalesData, String>(
              //           dataSource: data,
              //           xValueMapper: (_SalesData sales, _) => sales.year,
              //           yValueMapper: (_SalesData sales, _) => sales.sales,
              //           name: 'Sales',
              //           // Enable data label
              //           dataLabelSettings: DataLabelSettings(isVisible: true))
              //     ]),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     //Initialize the spark charts widget
              //     child: SfSparkLineChart.custom(
              //       //Enable the trackball
              //       trackball: SparkChartTrackball(
              //           activationMode: SparkChartActivationMode.tap),
              //       //Enable marker
              //       marker: SparkChartMarker(
              //           displayMode: SparkChartMarkerDisplayMode.all),
              //       //Enable data label
              //       labelDisplayMode: SparkChartLabelDisplayMode.all,
              //       xValueMapper: (int index) => data[index].year,
              //       yValueMapper: (int index) => data[index].sales,
              //       dataCount: 5,
              //     ),
              //   ),
              // )
            ])));
  }
}

class ChartData {
  ChartData({required this.xval, required this.yval});
  final double xval;
  final DateTime yval;
  // final String rawValue;
}
