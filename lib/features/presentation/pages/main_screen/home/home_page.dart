// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_miload/consts.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';

class HomePage extends StatefulWidget {
  final UserEnitity user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: HomePageBody(user: widget.user),
      ),
    );
  }
}

class HomePageBody extends StatefulWidget {
  final UserEnitity user;
  const HomePageBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding, horizontal: defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundColor: greyColor, radius: 25),
                sizedHor(defaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: defaultFontSizeMin,
                      ),
                    ),
                    Text(
                      widget.user.username!,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: defaultFontSize,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                     
                    },
                    icon: const Icon(
                      Icons.notifications,
                      size: 30,
                    ))
              ],
            ),
            sizeVer(defaultPadding),
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/truck_image.jpg'),
                          fit: BoxFit.cover),
                      border: Border.all(width: 1, color: greyColor),
                      borderRadius:
                          BorderRadius.circular(defaultCircularRadius)),
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        transparentColor,
                        selectedColor.withOpacity(1),
                      ], begin: Alignment.centerLeft),
                      border: Border.all(width: 1, color: greyColor),
                      borderRadius:
                          BorderRadius.circular(defaultCircularRadius)),
                ),
                Positioned(
                  top: 40,
                  left: 220,
                  child: Text(
                    'Get Your Cargo\nDelivered Safely..',
                    style: GoogleFonts.inter(
                        fontSize: defaultFontSize,
                        color: whiteColor.withOpacity(0.8),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            sizeVer(defaultPadding),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(width: 1, color: greyColor),
                  borderRadius: BorderRadius.circular(defaultCircularRadius)),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Book an Instant Trip',
                      style: GoogleFonts.inter(
                          fontSize: defaultFontSize,
                          fontWeight: FontWeight.w500,
                          color: whiteColor),
                    ),
                    Text(
                      'Get your items delivered quickly',
                      style: GoogleFonts.inter(
                          fontSize: defaultFontSizeMin2,
                          fontWeight: FontWeight.w500,
                          color: whiteColor),
                    ),
                    sizeVer(defaultPadding),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.all(defaultPaddingMin),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius:
                            BorderRadius.circular(defaultCircularRadiusMin),
                        color: whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: blueColor,
                              ),
                              sizedHor(defaultPaddingMin),
                              Text(
                                'Pickup Location?',
                                style: GoogleFonts.inter(
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            sizeVer(defaultPadding),
            Row(
            
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 240,
                    decoration: BoxDecoration(
                        color: primaryColor.shade400,
                        border: Border.all(width: 1, color: greyColor),
                        borderRadius:
                            BorderRadius.circular(defaultCircularRadius)),
                    child: Row(
                      children: [
                        sizedHor(defaultPadding),
                       const Icon(
                          Icons.alarm_rounded,
                          color: blackColor,
                          size: 50,
                        ),
                        sizedHor(defaultPadding),
                        Text(
                          'Schedule\na Trip',
                          style: GoogleFonts.inter(
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                sizedHor(defaultFontSizeMin),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: lightBlueColor,
                            border: Border.all(width: 1, color: greyColor),
                            borderRadius:
                                BorderRadius.circular(defaultCircularRadius)),
                        child: Row(children: [
                          sizedHor(defaultPadding),
                           Text(
                              ' Saved\n Trips',
                              style: GoogleFonts.inter(
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor),
                            ),
                           const Expanded(child: SizedBox()),
                            const Icon(Icons.arrow_forward,),
                            sizedHor(defaultPadding),
                        ],),
                      ),
                      sizeVer(defaultPaddingMin),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: lightBlueColor,
                            border: Border.all(width: 1, color: greyColor),
                            borderRadius:
                                BorderRadius.circular(defaultCircularRadius)),
                        child: Row(children: [
                          sizedHor(defaultPadding),
                           Text(
                              ' Available\n Vehicles',
                              style: GoogleFonts.inter(
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor),
                            ),
                           const Expanded(child: SizedBox()),
                            const Icon(Icons.arrow_forward,),
                            sizedHor(defaultPadding),
                        ],),
                      ),
                    ],
                  ),
                ),
              ],
            ),
           
            sizeVer(defaultPadding),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     'Vehicles Available',
            //     style: GoogleFonts.inter(
            //       fontSize: defaultFontSize,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // sizeVer(defaultPadding),
            // Row(
            //   children: [
            //     Container(
            //       height: 120,
            //       width: MediaQuery.of(context).size.width / 3.5,
            //       decoration: BoxDecoration(
            //           border: Border.all(width: 1, color: greyColor),
            //           borderRadius:
            //               BorderRadius.circular(defaultCircularRadius)),
            //       child: Column(
            //         children: [
            //           const Icon(
            //             Icons.fire_truck,
            //             size: 80,
            //           ),
            //           const Expanded(child: SizedBox()),
            //           Text(
            //             'Trunk 1 Ton',
            //             style: GoogleFonts.inter(),
            //           )
            //         ],
            //       ),
            //     ),
            //     sizedHor(defaultPadding),
            //     Container(
            //       height: 120,
            //       width: MediaQuery.of(context).size.width / 3.5,
            //       decoration: BoxDecoration(
            //           border: Border.all(width: 1, color: greyColor),
            //           borderRadius:
            //               BorderRadius.circular(defaultCircularRadius)),
            //       child: Column(
            //         children: [
            //           const Icon(
            //             Icons.fire_truck,
            //             size: 80,
            //           ),
            //           const Expanded(child: SizedBox()),
            //           Text(
            //             'Trunk 3 Ton',
            //             style: GoogleFonts.inter(),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
