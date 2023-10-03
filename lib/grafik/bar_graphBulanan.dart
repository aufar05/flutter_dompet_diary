import 'package:app_hemat/data/database.dart';
import 'package:app_hemat/utils/indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyPieChartBulanan extends StatelessWidget {
  final String kategoriNama;
  final int tipe;

  const MyPieChartBulanan(
      {Key? key, required this.kategoriNama, required this.tipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Chart Bulanan'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Grafik Lingkaran (Pie Chart)
          SizedBox(
            width: double.infinity,
            height: 300,
            child: StreamBuilder<Map<String, int>>(
              stream: Provider.of<AppDb>(context, listen: false)
                  .calculateTotalNilaiPieChartPerBulanRepo(
                      DateTime.now(), tipe),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    height: 100,
                    alignment: const Alignment(0, 7.5),
                    child: Theme.of(context).brightness == Brightness.light
                        ? Lottie.asset('lib/assets/lottie/noDataPie.json')
                        : Lottie.asset('lib/assets/lottie/noDataPie2.json'),
                  );
                } else {
                  final data = snapshot.data!;
                  int totalValue = 0;
                  final List<Color> colors = [
                    Colors.red,
                    Colors.green,
                    const Color.fromARGB(255, 13, 83, 141),
                    const Color.fromARGB(255, 189, 174, 42),
                    const Color.fromARGB(255, 25, 209, 255),
                    const Color.fromARGB(255, 143, 255, 68),
                    Colors.purple,
                    const Color.fromARGB(255, 250, 177, 18)
                  ];
                  for (var entry in data.entries) {
                    totalValue += entry.value;
                  }
                  List<PieChartSectionData> sections =
                      data.entries.map((entry) {
                    final colorIndex = data.keys.toList().indexOf(entry.key);
                    final color = colors[colorIndex];
                    final percentage = (entry.value / totalValue) * 100.0;
                    final formattedPercentage = percentage.toStringAsFixed(1);

                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: '$formattedPercentage%',
                      color: color,
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();

                  return PieChart(
                    PieChartData(
                      sections: sections,
                      centerSpaceRadius: 60,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),

          StreamBuilder<Map<String, int>>(
            stream: Provider.of<AppDb>(context, listen: false)
                .calculateTotalNilaiPieChartPerBulanRepo(DateTime.now(), tipe),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('');
              } else {
                final data = snapshot.data!;

                final List<Color> colors = [
                  Colors.red,
                  Colors.green,
                  const Color.fromARGB(255, 13, 83, 141),
                  const Color.fromARGB(255, 189, 174, 42),
                  const Color.fromARGB(255, 25, 209, 255),
                  const Color.fromARGB(255, 143, 255, 68),
                  Colors.purple,
                  const Color.fromARGB(255, 250, 177, 18)
                ];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.entries.map((entry) {
                      final colorIndex = data.keys.toList().indexOf(entry.key);
                      final color = colors[colorIndex];

                      return Row(
                        children: [
                          Indicator(
                            textColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                            color: color,
                            text: entry.key,
                            isSquare: true,
                          ),
                          const SizedBox(height: 4),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
