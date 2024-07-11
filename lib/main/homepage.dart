import 'package:airstat/components/container/menu_container.dart';
import 'package:airstat/main/booth_page.dart';
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
                children: [
                  MenuContainer(
                    image: 'assets/icons/Icon_booth_orange.png',
                    label: 'Booth',
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );

                      // var status = await checkPermissionStatus();
                      // if (status == false) {
                      //   await requestPermissions();
                      // } else {
                      //   if (context.mounted) {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const HomePage(),
                      //       ),
                      //     );
                      //   }
                      // }
                    },
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon3dMap.png',
                    label: '3D Map',
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon_continuous_orange.png',
                    label: 'Continuous',
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon_files_orange.png',
                    label: 'Files',
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon_IIR.png',
                    label: 'A.I.I.',
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon_OR.png',
                    label: 'O.R.',
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon_random_orange.png',
                    label: 'Random',
                  ),
                  const MenuContainer(
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
