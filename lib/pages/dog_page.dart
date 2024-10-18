import 'package:flutter/material.dart';

import 'package:flutter_api_assignment/network/dog_network.dart';

class DogPage extends StatefulWidget {
  final String breedName;

  const DogPage({
    required this.breedName,
    super.key,
  });

  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  late Future<String> futureImageUrl;
  final dogNetwork = DogNetwork();

  String get breedName => widget.breedName;

  @override
  void initState() {
    super.initState();
    futureImageUrl = dogNetwork.getRandomImagebyBreed(widget.breedName);
  }

  void _refreshImage() {
    setState(() {
      futureImageUrl = dogNetwork.getRandomImagebyBreed(widget.breedName);
    });
  }

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
        body: FutureBuilder(
            future: futureImageUrl,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final dog = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                          color: Colors.grey.shade300,
                          surfaceTintColor: Colors.grey.shade100,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Text(breedName.toUpperCase()),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(dog)),
                                )
                              ],
                            ),
                          )),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all<Color>(
                              Colors.grey.shade700,
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.grey.shade300),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        onPressed: _refreshImage,
                        child: Text(
                          'Change Image',
                        ))
                  ],
                );
              } else {
                return const Center(child: Text("No Image Available"));
              }
            }));
  }
}
