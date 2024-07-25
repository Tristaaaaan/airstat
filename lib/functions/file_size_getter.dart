import 'dart:math';

String formatFileSize(int bytes) {
  if (bytes <= 0) return "0 B";
  const sizes = ["B", "KB", "MB", "GB", "TB"];
  final i = (log(bytes) / log(1024)).floor();
  return '${bytes ~/ pow(1024, i)} ${sizes[i]}';
}
