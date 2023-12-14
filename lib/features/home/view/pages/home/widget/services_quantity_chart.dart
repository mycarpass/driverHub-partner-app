import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ServicesQuantityChart extends StatelessWidget {
  ServicesQuantityChart({
    super.key,
    required this.presenter,
  });

  final HomePresenter presenter;

  final List<ChartData> data = [
    ChartData(xval: 'Polimento', yval: 10),
    ChartData(xval: 'Vitrificação', yval: 20),
    ChartData(xval: 'Lavada simplessasdasdasda', yval: 24),
    ChartData(xval: 'Michael', yval: 20),
    ChartData(xval: 'Janet', yval: 23),
    ChartData(xval: 'Janet', yval: 23),
    ChartData(xval: 'Janet', yval: 23),
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
                    Icons.sell_outlined,
                    color: AppColor.iconSecondaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Serviços mais vendidos').body_bold(),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text('Últimos 30 dias').caption1_regular(
                          style: const TextStyle(
                              color: AppColor.textTertiaryColor))
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: 8,
              ),
              SfCircularChart(
                series: <CircularSeries>[
                  // Render pie chart
                  DoughnutSeries<ChartData, String>(
                      dataSource: data,
                      legendIconType: LegendIconType.diamond,
                      dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          color: AppColor.backgroundSecondary,
                          borderRadius: 6,
                          // margin: EdgeInsets.all(24),
                          labelPosition: ChartDataLabelPosition.outside,
                          textStyle: TextStyle(
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CircularStd',
                              fontSize: 14)),
                      xValueMapper: (ChartData data, _) => data.xval,
                      yValueMapper: (ChartData data, _) => data.yval)
                ],
                legend: const Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                  toggleSeriesVisibility: true,
                  shouldAlwaysShowScrollbar: true,
                  isResponsive: true,
                ),
              ),

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
  final String xval;
  final int yval;
}
