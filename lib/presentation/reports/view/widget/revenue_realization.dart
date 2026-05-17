import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenueRealizationChart extends StatelessWidget {
  const RevenueRealizationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E26), // Dark background
        borderRadius: BorderRadius.circular(24),
      ),
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
                maxY: 400,
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
        )
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
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    // Data: [MonthIndex, CollectedValue, ClaimedValue]
    final data = [
      [0, 340.0, 400.0], // Jan
      [1, 200.0, 250.0], // Feb
      [2, 300.0, 400.0], // Mar
      [3, 200.0, 300.0], // Apr
      [4, 350.0, 400.0], // May
      [5, 270.0, 330.0], // Jun
      [6, 200.0, 200.0], // Jul
    ];

    return data.map((item) {
      return BarChartGroupData(
        x: item[0].toInt(),
        barRods: [
          BarChartRodData(
            toY: (item[1] as num).toDouble(),
            width: 32,
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF32D779), Color(0xFF42E88B)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            // This creates the background "Claimed" bar
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: (item[2] as num).toDouble(),
              color: const Color(0xFF33373E),
            ),
          ),
        ],
      );
    }).toList();
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 100,
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
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                months[value.toInt()],
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
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
          color: Colors.white.withOpacity(0.05),
          strokeWidth: 1,
        );
      },
    );
  }
}