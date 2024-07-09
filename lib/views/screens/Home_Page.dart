import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/providers/json_decode_provider.dart';
import '/controllers/providers/theme_provider.dart';

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
              image: AssetImage('assets/gifs/back.gif'),
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
                      "Galaxy",
                      style: TextStyle(
                        fontSize: 22,
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
                            InkWell(
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
                                  InkWell(
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
                                        height: 150,
                                        width: 150,
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
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color:
                                          (Provider.of<ThemeProvider>(context)
                                                  .themeModel
                                                  .isDark)
                                              ? Colors.blueGrey.withOpacity(0.8)
                                              : Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(10),
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
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Radius : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].radius}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Velocity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].velocity}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Gravity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].gravity}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
