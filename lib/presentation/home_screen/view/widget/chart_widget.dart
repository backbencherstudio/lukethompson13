import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1,
          color: ColorManager.backgroundColorgreen1.withValues(alpha: .2),
        ),
        color: ColorManager.boxColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Weekly Activity ",
                  style: TextStyle(
                      color: ColorManager.whiteColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "10 stops this week",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primaryButton),
                )
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              "Total Log Stop",
              style: TextStyle(
                  color: const Color(0XFF8DA2B8),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 24.h),
   
            SizedBox(
              height: 180.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 4,
                  minY: 0,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.05),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: bottomTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _chartGroups(),
                  barTouchData: BarTouchData(enabled: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  List<BarChartGroupData> _chartGroups() {
    final List<double> values = [1.5, 3.0, 4.0, 3.0, 4.0, 3.0, 1.5];
    final List<bool> isGreen = [false, true, true, false, false, true, false];

    return List.generate(values.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index],
            color: isGreen[index] 
                ? const Color(0xFF4ADE80) 
                : const Color(0xFF33373E), // Dark grey
            width: 28.w,
            borderRadius: BorderRadius.circular(20.r), 
          ),
        ],
      );
    });
  }

 
  Widget leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(
        value.toInt() == 0 ? "0" : value.toInt().toString().padLeft(2, '0'),
        style: TextStyle(
          color: const Color(0XFF8DA2B8),
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        titles[value.toInt()],
        style: TextStyle(
          color: const Color(0XFF8DA2B8),
          fontSize: 11.sp,
        ),
      ),
    );
  }
}