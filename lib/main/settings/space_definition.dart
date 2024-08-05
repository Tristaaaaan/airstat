import 'package:airstat/main/settings/add_space_definition.dart';
import 'package:flutter/material.dart';

class SpaceDefinition extends StatelessWidget {
  const SpaceDefinition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space Definition"),
        centerTitle: true,
      ),
      body: AddSpaceDefinition(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RegularButton2(
            onTap: () {},
            textLabel: "Add",
          ),
          RegularButton2(
            onTap: () {},
            textLabel: "Edit",
          ),
          RegularButton2(
            onTap: () {},
            textLabel: "Delete",
          ),
          RegularButton2(
            onTap: () {},
            textLabel: "Save",
          ),
        ],
      ),
    );
  }
}

class RegularButton2 extends StatelessWidget {
  final String textLabel;
  final void Function() onTap;
  const RegularButton2({
    super.key,
    required this.textLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: Text(
            textAlign: TextAlign.center,
            textLabel,
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.background),
          ),
        ),
      ),
    );
  }
}
