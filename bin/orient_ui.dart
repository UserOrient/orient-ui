import 'dart:io';
import 'package:http/http.dart' as http;

const String baseUrl =
    'https://raw.githubusercontent.com/userorient/orient-ui/main/templates';

final Map<String, ComponentInfo> components = {
  'button': ComponentInfo(
    'button.dart',
    dependencies: ['spinner'],
  ),
  'confirmation_popup': ComponentInfo(
    'confirmation_popup.dart',
    dependencies: ['button'],
  ),
  'copy_button': ComponentInfo('copy_button.dart'),
  'empty_state': ComponentInfo('empty_state.dart'),
  'nav_bar': ComponentInfo('nav_bar.dart'),
  'spinner': ComponentInfo('spinner.dart'),
  'toast': ComponentInfo('toast.dart'),
  'alert_popup': ComponentInfo('alert_popup.dart'),
  'popup': ComponentInfo('popup.dart'),
};

void main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    return;
  }

  final command = args[0];

  switch (command) {
    case 'init':
      await _initCommand();
      break;
    case 'add':
      if (args.length < 2) {
        _listComponents();
        return;
      }
      await _addCommand(args[1]);
      break;
    default:
      _printUsage();
  }
}

void _log(String emoji, String message) => print('$emoji $message');

void _printUsage() {
  print('Orient UI - Design system for Flutter');
  print('Usage:');
  print('  orient_ui init           Initialize styling');
  print('  orient_ui add            List available components');
  print('  orient_ui add <widget>   Add a widget');
}

void _listComponents() {
  _log('📦', 'Available widgets:\n');
  for (final name in components.keys) {
    print('  • $name');
  }
  _log('\n💡', 'Usage: orient_ui add <widget>');
}

Future<void> _initCommand() async {
  _log('🎨', 'Initializing Orient UI...');

  try {
    await _fetchAndSave('styling.dart', 'lib/styling.dart');

    _log('🎉', 'All set! Wrap your app:');
    print('   ┌─────────────────────────────────');
    print('   │ Styling(');
    print('   │   brightness: Brightness.light,');
    print('   │   child: MaterialApp(...)');
    print('   │ )');
    print('   └─────────────────────────────────');
  } catch (e) {
    _log('❌', 'Failed: $e');
    exit(1);
  }
}

Future<void> _addCommand(String widget) async {
  _log('📦', 'Adding $widget...');

  if (!components.containsKey(widget)) {
    _log('❌', 'Widget "$widget" not found');
    _listComponents();
    exit(1);
  }

  final component = components[widget]!;

  try {
    await _fetchAndSave(component.filename, 'lib/$widget.dart');
    _log('📝', 'Don\'t forget to import styling.dart in $widget.dart');

    if (component.dependencies.isNotEmpty) {
      _log('⚠️ ', 'Depends on: ${component.dependencies.join(', ')}');
      print('   Run: orient_ui add ${component.dependencies.first}');
    }
  } catch (e) {
    _log('❌', 'Failed: $e');
    exit(1);
  }
}

class ComponentInfo {
  final String filename;
  final List<String> dependencies;

  ComponentInfo(this.filename, {this.dependencies = const []});
}

Future<void> _fetchAndSave(String filename, String destination) async {
  final url = '$baseUrl/$filename';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch (${response.statusCode})');
  }

  final file = File(destination);
  file.createSync(recursive: true);
  file.writeAsStringSync(response.body);

  _log('✨', 'Created $destination');
}
