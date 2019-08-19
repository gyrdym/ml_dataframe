import 'dart:io';

typedef FileFactory = File Function(String fileName);

FileFactory fileFactory = (String fileName) => File(fileName);