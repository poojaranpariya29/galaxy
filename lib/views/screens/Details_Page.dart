import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/providers/json_decode_provider.dart';
import '/controllers/providers/theme_provider.dart';
import '/models/json_decode.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    JsonDecodeModel data =
        ModalRoute.of(context)!.settings.arguments as JsonDecodeModel;

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
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<JsonDecodeProvider>(context, listen: false)
                            .favoritePlanet(int.parse(data.position));
                      },
                      icon: (Provider.of<JsonDecodeProvider>(context)
                              .galaxyDetails[int.parse(data.position)]
                              .favorite)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 18,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 0,
                            end: 2 * pi,
                          ),
                          duration: const Duration(seconds: 16),
                          child: Image.asset(
                            data.image,
                            height: 180,
                            width: 180,
                          ),
                          builder: (context, value, widget) {
                            return Transform.rotate(
                              angle: value,
                              child: widget,
                            );
                          },
                        ),
                        Container(
                          height: 230,
                          width: 250,
                          decoration: BoxDecoration(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.blueGrey.withOpacity(0.8)
                                : Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.type,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Radius : ${data.radius}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Orbital Period : ${data.orbital_period}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Gravity : ${data.gravity}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Velocity : ${data.velocity}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Distance (from Sun) : ${data.distance}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
