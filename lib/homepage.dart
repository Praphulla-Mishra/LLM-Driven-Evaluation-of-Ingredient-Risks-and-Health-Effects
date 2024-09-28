import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NutriScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NutriScan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: () {
            // Example functionality: Open a drawer or show a menu
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 60),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
                
            
              ),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text('Image $i', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                icon: Icon(Icons.image, color: Colors.white),
                label: Text('Upload Image', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // Example functionality: open image picker
                  print("Upload Image button tapped.");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 60),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                label: Text('Use Camera',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  // Example functionality: open camera
                  print("Use Camera button tapped.");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 60),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat,color: Colors.white,),
        onPressed: () {
          // Example functionality: open chat or support
          print("Floating action button tapped.");
        },
        backgroundColor: Colors.black,
      ),
    );
  }
}
