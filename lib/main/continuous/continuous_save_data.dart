import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/models/serial_data_model.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContinuousSaveData extends ConsumerWidget {
  const ContinuousSaveData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController fileNameController = TextEditingController();
    final serialData = ref.watch(serialDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Continuous"),
      ),
      body: Center(
        child: Column(
          children: [
            RegularTextField(
              category: "File Name",
              controller: fileNameController,
            ),
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
              "assets/icons/Icon_continuous_orange.png",
              width: 50,
              height: 50,
            ),
            RegularButton(
              buttonText: "Discard",
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () {},
            ),
            RegularButton(
              buttonText: "Save",
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () {
                if (fileNameController.text.isEmpty && serialData.isNotEmpty) {
                  informationSnackBar(context, Icons.warning,
                      "Kindly enter the file name to proceed");
                } else {
                  final currentDate = DateTime.now();

                  Headers headers = Headers(
                    dataPoint: "data_point",
                    pos: "pos",
                    cd: "cd",
                    dd: "dd",
                  );
                  ContinuousDataModel saveData = ContinuousDataModel(
                      readings: serialData,
                      fileName: fileNameController.text,
                      dateTime: currentDate,
                      lastUpdated: currentDate,
                      mode: "Continuous",
                      numSampling: 10,
                      headers: headers,
                      delay: 10,
                      unit: "ft/min");

                  ref.read(saveDataProvider.notifier).state = [saveData];
                  final data = ref.watch(saveDataProvider);
                  print(data.map((e) => e).toList());
                  print(data.map((e) => e.fileName).toList());
                  print("SERIAL DATA: ${ref.watch(saveDataProvider)}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
