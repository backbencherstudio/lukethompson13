import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/parent_screen/parent_screen.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> sliderData = [
    {
      "title": "Track wait time",
      "desc": "Track detention stops and boost your earnings.",
      "image": Assets.images.pickUp.path,
      "onPress": (BuildContext context, WidgetRef ref) {
        ref.read(parentScreenIndexProvider.notifier).goToLog();
      },
    },
    {
      "title": "Broker &\nDock Scores",
      "desc": "Get insights into your broker pay and doc scores.",
      "image": Assets.images.pickUp.path,
      "onPress": (BuildContext context, WidgetRef ref) {
        context.push(Routes.shipperRatings);
      },
    },
    {
      "title": "Send Invoice",
      "desc": "Bill brokers directly with auto-attached BOL and logs.",
      "image": Assets.images.pickUp.path,
      "onPress": (BuildContext context, WidgetRef ref) {
        ref.read(parentScreenIndexProvider.notifier).goToStops();
      },
    },
    {
      "title": "Calculate\nDetention & Pay",
      "desc": "Compute extra waiting pay based on your rates.",
      "image": Assets.images.pickUp.path,
      "onPress": (BuildContext context, WidgetRef ref) {
        ref.read(parentScreenIndexProvider.notifier).goToReports();
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            viewportFraction: 1,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: sliderData.map((data) {
            return CarouselCardItem(data: data);
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sliderData.asMap().entries.map((entry) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _currentIndex == entry.key ? 24.0 : 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentIndex == entry.key
                      ? Colors.orange
                      : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CarouselCardItem extends ConsumerWidget {
  const CarouselCardItem({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () => data['onPress'](context, ref),
      child: Container(
        width: MediaQuery.sizeOf(context).width - 32.w,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF63D991),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      data['title'] as String,
                      style: TextStyle(
                        height: 1,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['desc'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(data['image'] as String, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
    );
  }
}
