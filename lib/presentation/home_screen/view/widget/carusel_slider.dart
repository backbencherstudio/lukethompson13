import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/image_manager.dart';

class CustomCarouselSlider extends StatefulWidget {
  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0; 


  final List<Map<String, String>> sliderData = [
    {
      "title": "Track wait time",
      "desc": "Track detention stops and boost your earnings.",
      "image": ImageManager.pickUp 
    },
    {
       "title": "Track wait time",
      "desc": "Track detention stops and boost your earnings.",
      "image": ImageManager.pickUp 
    },
    {
         "title": "Track wait time",
      "desc": "Track detention stops and boost your earnings.",
      "image": ImageManager.pickUp 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0, 
            viewportFraction: 0.95, 
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; 
              });
            },
          ),
          items: sliderData.map((data) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF63D991), 
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                  
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['title']!,
                                  style: TextStyle(
                                    fontSize: 24.sp,

                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF222222),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data['desc']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    color:  Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                     
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              data['image']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                  
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: sliderData.asMap().entries.map((entry) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == entry.key
                                    ? Colors.orange 
                                    : Colors.white, 
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}