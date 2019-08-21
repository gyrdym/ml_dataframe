import 'package:grinder/grinder.dart';
import 'package:ml_tech/grind.dart' as ml_tech;

Future<void> main(List<String> args) => grind(args);

@Task()
Future<void> uploadCoverage() => ml_tech.uploadCoverage();

@Task()
Future<void> test() => ml_tech.test();
