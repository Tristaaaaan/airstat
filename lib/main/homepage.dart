import 'package:airstat/components/container/menu_container.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: const [
                  MenuContainer(
                    image: 'assets/icons/Icon_booth_orange.png',
                    label: 'Booth',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon3dMap.png',
                    label: '3D Map',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_continuous_orange.png',
                    label: 'Continuous',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_files_orange.png',
                    label: 'Files',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_IIR.png',
                    label: 'A.I.I.',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_OR.png',
                    label: 'O.R.',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_random_orange.png',
                    label: 'Random',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_settings_orange.png',
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
