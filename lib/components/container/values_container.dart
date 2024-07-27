

// class ContainerValues extends StatelessWidget {
//   final String value;
//   final Color? color;
//   final SettingsState state;
//   final SettingsNotifier notifier;
//   final double? width;
//   const ContainerValues({
//     super.key,
//     required this.value,
//     this.color,
//     required this.state,
//     required this.notifier,
//     this.width = 75,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isSelected = state.selectedValue == value;

//     return GestureDetector(
//       onTap: () => notifier.selectValue(value),
//       child: Container(
//         width: width,
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Theme.of(context).colorScheme.primary
//               : Theme.of(context).colorScheme.secondary,
//         ),
//         child: Text(
//           value,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20,
//             color: Theme.of(context).colorScheme.background,
//           ),
//         ),
//       ),
//     );
//   }
// }
