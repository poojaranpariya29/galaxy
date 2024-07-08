import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/providers/json_decode_provider.dart';
import 'package:galaxy_planets/controllers/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gifs/gifback.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Solar System",
                      style: TextStyle(
                        fontSize: 3.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('favorites_page');
                      },
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                    ),
                    CupertinoSwitch(
                      value:
                          Provider.of<ThemeProvider>(context).themeModel.isDark,
                      onChanged: (val) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 18,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...List.generate(
                        Provider.of<JsonDecodeProvider>(context, listen: false)
                            .galaxyDetails
                            .length,
                        (index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  'details_page',
                                  arguments: Provider.of<JsonDecodeProvider>(
                                          context,
                                          listen: false)
                                      .galaxyDetails[index],
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      animationController.repeat();
                                      setState(() {});
                                    },
                                    onDoubleTap: () {
                                      animationController.reverse(from: 2 * pi);
                                      setState(() {});
                                    },
                                    child: AnimatedBuilder(
                                      animation: animationController,
                                      child: Image.asset(
                                        Provider.of<JsonDecodeProvider>(context,
                                                listen: false)
                                            .galaxyDetails[index]
                                            .image,
                                        height: 20.h,
                                        width: 20.h,
                                      ),
                                      builder: (context, widget) {
                                        return Transform.rotate(
                                          angle: animationController.value,
                                          child: widget,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 22.h,
                                    width: 25.h,
                                    decoration: BoxDecoration(
                                      color:
                                          (Provider.of<ThemeProvider>(context)
                                                  .themeModel
                                                  .isDark)
                                              ? Colors.grey.withOpacity(0.4)
                                              : Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    padding: EdgeInsets.all(1.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Provider.of<JsonDecodeProvider>(
                                                      context)
                                                  .galaxyDetails[index]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 3.h,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                if (animationController
                                                    .isAnimating) {
                                                  animationController.stop();
                                                } else {
                                                  animationController.repeat();
                                                }
                                                setState(() {});
                                              },
                                              icon: (animationController
                                                      .isAnimating)
                                                  ? const Icon(Icons.stop)
                                                  : const Icon(
                                                      Icons.play_arrow),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          'Radius : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].radius}',
                                          style: TextStyle(
                                            fontSize: 2.h,
                                          ),
                                        ),
                                        Text(
                                          'Velocity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].velocity}',
                                          style: TextStyle(
                                            fontSize: 2.h,
                                          ),
                                        ),
                                        Text(
                                          'Gravity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].gravity}',
                                          style: TextStyle(
                                            fontSize: 2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
