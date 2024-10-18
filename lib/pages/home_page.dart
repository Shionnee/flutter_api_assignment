import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_api_assignment/models/dogbreeds_model.dart';
import 'package:flutter_api_assignment/network/dog_network.dart';
import 'package:flutter_api_assignment/pages/dog_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final DogNetwork dogNetwork = DogNetwork();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const Text(
            "DOG API",
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade100),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 25,
                child: Text(
                  "Choose a breed you want to see images of!",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            FutureBuilder<DogBreedsModel>(
                future: dogNetwork.getBreeds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
                  }
                  if (snapshot.hasData) {
                    final breedList = snapshot.data!.breeds;
                    return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: breedList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DogPage(
                                            breedName: breedList[index],
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 2.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              height: 75,
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(breedList[index].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                          );
                        });
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
