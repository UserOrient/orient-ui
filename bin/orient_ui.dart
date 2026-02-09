import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String version = '0.2.4';

const String baseUrl =
    'https://raw.githubusercontent.com/userorient/orient-ui/main/templates';

final Map<String, ComponentInfo> components = {
  'button': ComponentInfo(
    'button.dart',
    dependencies: ['spinner'],
  ),
  'card_box': ComponentInfo('card_box.dart'),
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
  'search_field': ComponentInfo('search_field.dart'),
  'tile': ComponentInfo('tile.dart'),
  'toggle': ComponentInfo('toggle.dart'),
  'toggle_tile': ComponentInfo(
    'toggle_tile.dart',
    dependencies: ['toggle'],
  ),
};

void main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    await _checkForUpdate();
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
        await _checkForUpdate();
        return;
      }
      await _addCommand(args[1]);
      break;
    default:
      _printUsage();
  }

  await _checkForUpdate();
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

Future<void> _checkForUpdate() async {
  try {
    final response = await http
        .get(Uri.parse('https://pub.dev/api/packages/orient_ui'))
        .timeout(const Duration(seconds: 3));

    if (response.statusCode != 200) return;

    final data = jsonDecode(response.body);
    final latest = data['latest']['version'] as String;

    if (latest == version) return;

    const dim = '\x1B[2m';
    const green = '\x1B[32m';
    const bold = '\x1B[1m';
    const reset = '\x1B[0m';

    print('');
    _log(
      '🆕',
      '${bold}New version available!$reset  $dim$version$reset → $green$bold$latest$reset',
    );
    _log('  ', '${dim}Updating...$reset');

    final result = await Process.run(
      'dart',
      ['pub', 'global', 'activate', 'orient_ui'],
    );

    if (result.exitCode == 0) {
      _log('✅', '${green}Updated to $latest!$reset');
    } else {
      _log('⚠️ ', '${dim}Auto-update failed. Run manually:$reset');
      print('   dart pub global activate orient_ui');
    }
  } catch (_) {
    // Silently ignore - don't block CLI usage if check fails
  }
}
