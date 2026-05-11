import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';


class ClaimDetialsWidget extends StatelessWidget {
  const ClaimDetialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      // appBar: CustomAppBarScreen(
      //   profileImage: IconManager.backArroe,
      //   welcomeText: " Claim Detail",
      //   welcomeFontSize: 22.sp,
      //   userName: "Walmart DC Shelbyville, TN",
      //   userNameFontSize: 14.sp,
      //   userNameColor: const Color.fromARGB(255, 204, 204, 204),
      //   userNameFontWeight: FontWeight.w400,
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

    InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          color: const Color(0xFF2c5046), 
        ),
        child: Center(
          child: Image.asset(
            IconManager.backArrow,
            width: 20.w, 
            color: Colors.white,
          ),
        ),
      ),
    ),
    
    SizedBox(width: 16.w), 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Claim Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h), 
        Text(
          'WWalmart DC Shelbyville. TN',
          style: TextStyle(
            color: const Color(0xFFA0B1AC), 
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    )
  ],
),
 SizedBox(height: 20.h,),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.center,
                    colors: [
                      ColorManager.secondary,
                      const Color.fromARGB(255, 29, 32, 36),
                    ],
                  ),
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(IconManager.appLogo,fit: BoxFit.cover,height: 38.h,width: 42.w,),
                        // Container(
                        //   padding: EdgeInsets.all(4.r),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFF0D1117),
                        //     borderRadius: BorderRadius.circular(6.r),
                        //   ),
                        //   child: Icon(
                        //     Icons.local_shipping,
                        //     color: const Color(0xFF32D779),
                        //     size: 22.sp,
                        //   ),
                        // ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "GET",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "DOCK",
                                    style: TextStyle(
                                      color: const Color(0xFF32D779),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "PAY",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
                             Text(
                      "Review details before sending",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                          ],
                        ),
                      ],
                    ),
                   
                    SizedBox(height: 15.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF32D779).withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFF32D779).withOpacity(0.05),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detention Claim Amount",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "\$135.00",
                            style: TextStyle(
                              color: const Color(0xFF32D779),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "2h 15m billable . \$60/hr detention rate . 2h free time",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      "CLAIM DETAILS",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Facility",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  "Walmart DC - Shelbyville, TN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.05),
                            height: 1,
                            thickness: 1,
                            indent: 12.w,
                            endIndent: 12.w,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Arrival - Departure",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  "9:00 AM -> 1:30 PM",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.05),
                            height: 1,
                            thickness: 1,
                            indent: 12.w,
                            endIndent: 12.w,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Billable Detention",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  "2h 15m",
                                  style: TextStyle(
                                    color: const Color(0xFF32D779),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.05),
                            height: 1,
                            thickness: 1,
                            indent: 12.w,
                            endIndent: 12.w,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "BOL Number",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  "BOL-2026-04-8823",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.05),
                            height: 1,
                            thickness: 1,
                            indent: 12.w,
                            endIndent: 12.w,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GPS Coordinates",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  "35.4831, -86.4603",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h),

                    Text(
                      "PROOF PACKAGE",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.link, color: Colors.blue, size: 18.sp),
                          SizedBox(width: 10.w),
                          Text(
                            "00140_4437_0009964.jpg",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.link, color: Colors.blue, size: 18.sp),
                          SizedBox(width: 10.w),
                          Text(
                            "00140_4437_0009964.pdf",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25.h),
              Text(
                "Send To",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),


              Text(
                "Recipient Email",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "billing@walmart-carrier.com",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.2),
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF14171C),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "CC Broker (Optional)",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "dispatch@tql.com",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.2),
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF14171C),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(color: const Color(0xFF32D779)),
                      color: const Color(0xFF13231B),
                    ),
                    child: const Center(
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0xFF32D779),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Center(
                      child: Text("SMS", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
           
GestureDetector(
  onTap: () {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32), 
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.white60, size: 18.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "Share this",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.h),
              
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Container(
                    height: 50.w, width: 50.w,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                    child: Icon(Icons.whatshot_sharp, color: Colors.green, size: 28.sp),
                  ),
            
                  Container(
                    height: 50.w, width: 50.w,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                    child: Icon(Icons.email, color: Colors.redAccent, size: 28.sp),
                  ),
         
                  Container(
                    height: 50.w, width: 50.w,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                    child: Icon(Icons.messenger_outline, color: Colors.blue, size: 28.sp),
                  ),
               
                  Container(
                    height: 50.w, width: 50.w,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                    child: Icon(Icons.messenger, color: Colors.purpleAccent, size: 28.sp),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              Text(
                "Or copy link",
                style: TextStyle(color: Colors.white70, fontSize: 13.sp),
              ),
              SizedBox(height: 12.h),

      
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1117),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "https://www.google.com/search?q=link+ge...",
                        style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Copy",
                        style: TextStyle(
                          color: const Color(0xFF32D779),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        );
      },
    );
  },
  child: Container(
    width: 100.w,
    height: 45.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      border: Border.all(color: Colors.white24),
    ),
    child: const Center(
      child: Text(
        "Share",
        style: TextStyle(color: Colors.grey),
      ),
    ),
  ),
),
                ],
              ),

              SizedBox(height: 30.h),

       
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF32D779),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Claim Now",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
