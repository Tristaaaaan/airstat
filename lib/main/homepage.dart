import 'package:airstat/components/container/menu_container.dart';
import 'package:airstat/main/file_page.dart';
import 'package:airstat/main/settings.dart';
import 'package:airstat/main/try.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: [
                  MenuContainer(
                    image: 'assets/icons/Icon_booth_orange.png',
                    label: 'Booth',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
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
                  MenuContainer(
                    image: 'assets/icons/Icon_files_orange.png',
                    label: 'Files',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilePage(),
                        ),
                      );
                    },
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
                  MenuContainer(
                    image: 'assets/icons/Icon_settings_orange.png',
                    label: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Settings(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text("App Rev 4.0"),
            ),
          ],
        ),
      ),
    );
  }
}
