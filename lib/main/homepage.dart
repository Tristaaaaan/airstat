import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/container/menu_container.dart';
import 'package:airstat/main/aii/aii_page.dart';
import 'package:airstat/main/booth/booth_page.dart';
import 'package:airstat/main/continuous/continuous_main_page.dart';
import 'package:airstat/main/files/file_page.dart';
import 'package:airstat/main/random/random_reading_mode.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/main/three_d_page.dart';
import 'package:airstat/models/settings_model.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:airstat/services/airstat_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final usbDevices = ref.watch(usbDevicesProvider);
    // final subscription = ref.watch(subscriptionProvider);
    // // Function to initialize USB devices
    // void initializeUsbDevices() async {
    //   // Add logic to fetch and set USB devices
    //   // Example:
    //   List<UsbDevice> serialList = await UsbSerial.listDevices();

    //   ref.read(usbDevicesProvider.notifier).state = serialList;

    //   if (subscription != null) {
    //     await ref.read(subscriptionProvider.notifier).state!.cancel();
    //     ref.read(subscriptionProvider.notifier).state = null;
    //   }

    //   UsbPort port = (await serialList.first.create())!;
    //   ref.read(usbPortProvider.notifier).state = port;

    //   port.setDTR(true);
    //   port.setRTS(true);

    //   await port.setPortParameters(
    //     9600, // Check the correct baud rate for WindSonic 75
    //     UsbPort.DATABITS_8,
    //     UsbPort.STOPBITS_1,
    //     UsbPort.PARITY_NONE,
    //   ); // Ensure these match your device's settings
    // }

    // useEffect(() {
    //   if (usbDevices.isEmpty) {
    //     initializeUsbDevices();
    //   }
    //   return null;
    // }, [usbDevices]);

    // Function to initialize USB devices
    void initializeSettings() async {
      final AirstatSettingsModel data =
          await AirstatSettingsConfiguration().getAirstatSettingsDatabase();

      ref.read(generalSamplingValueProvider.notifier).state =
          data.sampling.toString();
      ref.read(generalDelayValueProvider.notifier).state =
          data.delay.toString();
      ref.read(unitValueProvider.notifier).state = data.unit;

      print("General Delay: ${ref.watch(generalDelayValueProvider)}");
    }

    useEffect(() {
      initializeSettings();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Airstat'),
        actions: const [AirstatSettingsAppBar()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            builder: (context) => const BoothPage()),
                      );
                    },
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon3dMap.png',
                    label: '3D Map',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ThreeDMap()),
                      );
                    },
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_continuous_orange.png',
                    label: 'Continuous',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ContinuousReadingMode()),
                      );
                    },
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

                      ref.read(selectedFilesProvider.notifier).clearSelection();
                    },
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_IIR.png',
                    label: 'A.I.I.',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AirborneInfectionIsolationPage()));
                    },
                  ),
                  const MenuContainer(
                    image: 'assets/icons/Icon_OR.png',
                    label: 'O.R.',
                  ),
                  MenuContainer(
                    image: 'assets/icons/Icon_random_orange.png',
                    label: 'Random',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RandomReadingMode(),
                        ),
                      );
                    },
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
