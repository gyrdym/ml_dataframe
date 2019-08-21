import 'package:grinder/grinder.dart';
import 'package:ml_tech/grind.dart' as ml_tech;

Future<void> main(List<String> args) => grind(args);

@Task()
Future<void> start() => ml_tech.start();

@Task()
Future<void> finish() => ml_tech.finish();
