import 'package:app_hemat/data/database.dart';
import 'package:app_hemat/screen/laporan_screen.dart';
import 'package:app_hemat/utils/formatRupiah.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class MyBarGraphMingguan extends StatelessWidget {
  final String kategoriNama;
  final int tipe;

  const MyBarGraphMingguan(
      {Key? key, required this.kategoriNama, required this.tipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemDipilih = Provider.of<LaporanScreenData>(context).itemDipilih;
    return StreamBuilder<Map<String, int>>(
      stream: (itemDipilih == 'Mingguan')
          ? Provider.of<AppDb>(context, listen: false)
              .calculateTotalNilaiBarChartPerHariRepo(
                  DateTime.now(), kategoriNama, tipe)
          : Provider.of<AppDb>(context, listen: false)
              .calculateTotalNilaiBarChartPerMingguRepo(
                  DateTime.now(), kategoriNama, tipe),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Menampilkan indikator loading jika data belum siap.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Tidak ada data pemasukan');
        } else {
          final data = snapshot.data!;
          int highestValue = data.values.reduce((a, b) => a > b ? a : b);
          int incrementValue = 1;
          return BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final formattedValue = CurrencyFormat.convertToIdr(
                      data.entries
                          .elementAt(groupIndex)
                          .value, // Mengambil data yang sesuai dengan bar yang sedang ditunjuk.
                      0,
                    );
                    return BarTooltipItem(
                      formattedValue,
                      TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              gridData: const FlGridData(show: false),
              maxY: highestValue.toDouble(),
              minY: 0,
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                    axisNameWidget: Text(
                      kategoriNama,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    axisNameSize: 20,
                    sideTitles: const SideTitles(showTitles: false)),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return (itemDipilih == 'Mingguan')
                          ? getBottomTilesMingguan(value, meta, context)
                          : getBottomTilesBulanan(value, meta, context);
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: data.entries.map((entry) {
                int xValue;
                try {
                  xValue = incrementValue++;
                } catch (e) {
                  xValue = 0;
                }
                return BarChartGroupData(
                  x: xValue,
                  barsSpace: 4,
                  barRods: [
                    BarChartRodData(
                        color: (tipe == 2) ? Colors.red : Colors.green,
                        toY: entry.value.toDouble(),
                        width: 16,
                        borderRadius: BorderRadius.circular(4)),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

Widget getBottomTilesMingguan(
    double value, TitleMeta meta, BuildContext context) {
  final onBackgroundColor = Theme.of(context).colorScheme.onBackground;
  final style = TextStyle(
      color: onBackgroundColor, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = Text(
        'Sen',
        style: style,
      );
      break;
    case 2:
      text = Text(
        'Sel',
        style: style,
      );
      break;
    case 3:
      text = Text(
        'Rab',
        style: style,
      );
      break;
    case 4:
      text = Text(
        'Kam',
        style: style,
      );
      break;
    case 5:
      text = Text(
        'Jum',
        style: style,
      );
      break;
    case 6:
      text = Text(
        'Sab',
        style: style,
      );
      break;
    case 7:
      text = Text(
        'Min',
        style: style,
      );
      break;
    default:
      text = Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget getBottomTilesBulanan(
    double value, TitleMeta meta, BuildContext context) {
  final onBackgroundColor = Theme.of(context).colorScheme.onBackground;
  final style = TextStyle(
      color: onBackgroundColor, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = Text(
        'Mg-1',
        style: style,
      );
      break;
    case 2:
      text = Text(
        'Mg-2',
        style: style,
      );
      break;
    case 3:
      text = Text(
        'Mg-3',
        style: style,
      );
      break;
    case 4:
      text = Text(
        'Mg-4',
        style: style,
      );
      break;
    case 5:
      text = Text(
        'Mg-5',
        style: style,
      );
      break;
    default:
      text = Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
