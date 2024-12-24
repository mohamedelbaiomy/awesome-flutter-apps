import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_provider/views/city_name/provider/city_name_provider.dart';
import 'package:weather_api_provider/views/city_name/views/city_name.dart';

import '../../../constant.dart';

class GetCity extends StatelessWidget {
  const GetCity({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white70,
            size: 15,
          ),
        ),
        title: const Text(
          "Get City Name",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white70),
                  cursorColor: Colors.white70,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you must enter city name';
                    }
                    if (value.length < 2) {
                      return 'enter a valid city name';
                    }
                    return null;
                  },
                  controller: cityController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.map,
                      color: Colors.white70,
                    ),
                    labelText: 'City Name',
                    hintText: 'ex : Egypt',
                    labelStyle: TextStyle(color: Colors.white70),
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white70,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.white70,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Get.to(
                        ChangeNotifierProvider(
                          create: (context) => CityNameProvider(),
                          child: CityName(cityName: cityController.text),
                        ),
                        transition: Transition.rightToLeftWithFade,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Go"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
