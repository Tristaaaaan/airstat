// DropdownMenuEntry labels and values for the first dropdown menu.
enum ReadingModeLabels {
  booth('Booth'),
  or('OR'),
  all('All'),
  threed('3D');

  const ReadingModeLabels(this.label);

  final String label;
}

enum UnitLabels {
  booth('m/sec'),
  or('ft/min');

  const UnitLabels(this.label);

  final String label;
}

enum RowLabels {
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  five('5'),
  six('6'),
  seven('7'),
  eight('8'),
  nine('9'),
  ten('10'),
  eleven('11'),
  twelve('12');

  const RowLabels(this.label);

  final String label;
}

enum ReadingPerRowLabels {
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  five('5'),
  six('6'),
  seven('7'),
  eight('8'),
  nine('9');

  const ReadingPerRowLabels(this.label);

  final String label;
}

enum SilhouetteWidthLabels {
  one('1'),
  two('2'),
  three('3');

  const SilhouetteWidthLabels(this.label);

  final String label;
}

enum SilhouetteHeightLabels {
  one('1'),
  two('2'),
  three('3');

  const SilhouetteHeightLabels(this.label);

  final String label;
}
