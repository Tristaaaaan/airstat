import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/threed_d_map_container.dart';
import 'package:flutter/material.dart';

class ThreeDMap extends StatelessWidget {
  const ThreeDMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D Map"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ThreeDMapContainer(category: "Site", label: "Cincinatti"),
            ThreeDMapContainer(category: "Area/Shop", label: "Building1"),
            ThreeDMapContainer(category: "Floor/Line", label: "Floor1"),
            ThreeDMapContainer(category: "Room/Zone", label: "1006"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/icons/Icon3dMap.png',
              width: 40,
              height: 40,
            ),
            RegularButton(
              buttonText: "Next",
              buttonKey: "threedNext",
              width: 100,
              onTap: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
