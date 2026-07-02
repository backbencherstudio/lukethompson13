import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/data/models/report/report.model.dart';

class RevenueRealizationChart extends StatelessWidget {
  const RevenueRealizationChart({super.key, this.chartData});

  final List<RevenueRealization>? chartData;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderRadius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _maxY,
                barTouchData: BarTouchData(enabled: false),
                titlesData: _buildTitlesData(),
                gridData: _buildGridData(),
                borderData: FlBorderData(show: false),
                barGroups: _getBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Revenue Realization',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Claimed vs. Collected monthly\nperformance',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegendItem("Collected", const Color(0xFF32D779)),
            const SizedBox(height: 8),
            _buildLegendItem("Claimed", const Color(0xFF33373E)),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    if (chartData == null) return [];

    return chartData!.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final collected = double.tryParse(item.collected) ?? 0;
      final claimed = double.tryParse(item.claimed) ?? 0;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: collected,
            width: 16,
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF32D779), Color(0xFF42E88B)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: claimed,
              color: const Color(0xFF33373E),
            ),
          ),
        ],
      );
    }).toList();
  }

  double get _maxY {
    if (chartData == null) return 0;
    double max = 0;
    for (final item in chartData!) {
      final claimed = double.tryParse(item.claimed) ?? 0;
      final collected = double.tryParse(item.collected) ?? 0;
      final m = claimed > collected ? claimed : collected;
      if (m > max) max = m;
    }
    return max == 0 ? 100 : max * 1.15;
  }

  FlTitlesData _buildTitlesData() {
    final labels = chartData?.map((e) => e.label).toList() ?? [];
    return FlTitlesData(
      show: true,
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: (_maxY / 4).ceilToDouble().clamp(50, double.infinity),
          getTitlesWidget: (value, meta) {
            return Text(
              '\$${value.toInt()}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final i = value.toInt();
            if (i >= labels.length) return const SizedBox.shrink();
            return Text(
              labels[i],
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            );
          },
        ),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 100,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.white.withValues(alpha: 0.05),
          strokeWidth: 1,
        );
      },
    );
  }
}
