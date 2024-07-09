import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/providers/json_decode_provider.dart';
import '/controllers/providers/theme_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 18,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: (Provider.of<JsonDecodeProvider>(context)
                          .favoriteModel
                          .favoriteList
                          .isNotEmpty)
                      ? Column(
                          children: [
                            ...List.generate(
                              Provider.of<JsonDecodeProvider>(context)
                                  .favoriteModel
                                  .favoriteList
                                  .length,
                              (index) => Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        'details_page',
                                        arguments:
                                            Provider.of<JsonDecodeProvider>(
                                                    context,
                                                    listen: false)
                                                .favoriteModel
                                                .favoriteList[index],
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            animationController.repeat();
                                            setState(() {});
                                          },
                                          onDoubleTap: () {
                                            animationController.reverse(
                                                from: 2 * pi);
                                            setState(() {});
                                          },
                                          child: AnimatedBuilder(
                                            animation: animationController,
                                            child: Image.asset(
                                              Provider.of<JsonDecodeProvider>(
                                                      context,
                                                      listen: false)
                                                  .favoriteModel
                                                  .favoriteList[index]
                                                  .image,
                                              height: 150,
                                              width: 150,
                                            ),
                                            builder: (context, widget) {
                                              return Transform.rotate(
                                                angle:
                                                    animationController.value,
                                                child: widget,
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: (Provider.of<ThemeProvider>(
                                                        context)
                                                    .themeModel
                                                    .isDark)
                                                ? Colors.blueGrey
                                                    .withOpacity(0.8)
                                                : Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    Provider.of<JsonDecodeProvider>(
                                                            context,
                                                            listen: false)
                                                        .favoriteModel
                                                        .favoriteList[index]
                                                        .name,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Provider.of<JsonDecodeProvider>(
                                                              context,
                                                              listen: false)
                                                          .removeFavoritePlanet(
                                                              index);
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Radius : ${Provider.of<JsonDecodeProvider>(context, listen: false).favoriteModel.favoriteList[index].name}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                'Velocity : ${Provider.of<JsonDecodeProvider>(context, listen: false).favoriteModel.favoriteList[index].velocity}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                'Gravity : ${Provider.of<JsonDecodeProvider>(context, listen: false).favoriteModel.favoriteList[index].gravity}',
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
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
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
