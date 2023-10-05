import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AvatarSelectionPage(),
    );
  }
}*/

class AvatarSelectionPage extends StatefulWidget {
  @override
  _AvatarSelectionPageState createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  String selectedAvatar = 'images/icons_avatars/0_0.png';

  final List<String> imagePaths = [
    'images/icons_avatars/0.png',
    'images/icons_avatars/1.png',
    'images/icons_avatars/2.png',
    'images/icons_avatars/3.png',
    'images/icons_avatars/4.png',
    'images/icons_avatars/5.png',
  ];

  @override
  void initState() {
    super.initState();
    loadSelectedAvatar();
  }

  Future<void> loadSelectedAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedAvatar = prefs.getString('selectedAvatar') ?? selectedAvatar;
    setState(() {
      selectedAvatar = savedAvatar;
    });
  }

  Future<void> saveSelectedAvatar(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAvatar', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Selecciona un Avatar',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(selectedAvatar),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecciona una imagen',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagePaths.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              String imagePath = imagePaths[index];
                              setState(() {
                                selectedAvatar = imagePath;
                              });
                              await saveSelectedAvatar(imagePath);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(imagePaths[index]),
                                backgroundColor:
                                    Colors.transparent, // Fondo transparente.
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
