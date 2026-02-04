import 'package:example/styling.dart';
import 'package:example/widgets/search_field.dart';
import 'package:flutter/widgets.dart';

class SearchFieldPage extends StatefulWidget {
  const SearchFieldPage({super.key});

  @override
  State<SearchFieldPage> createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage> {
  final _controller = TextEditingController();
  String _query = '';

  static const _packages = [
    ('userorient_flutter', 'In-app feedback and feature requests'),
    ('flutter_bloc', 'State management with BLoC pattern'),
    ('riverpod', 'Reactive caching and data-binding'),
    ('provider', 'Simple state management'),
    ('get_it', 'Service locator for dependency injection'),
    ('dio', 'Powerful HTTP client'),
    ('http', 'Composable HTTP client'),
    ('shared_preferences', 'Persistent key-value storage'),
    ('hive', 'Lightweight and fast key-value database'),
    ('sqflite', 'SQLite plugin for Flutter'),
    ('go_router', 'Declarative routing'),
    ('auto_route', 'Code generation for routing'),
    ('freezed', 'Code generation for immutable classes'),
    ('json_serializable', 'JSON serialization code generation'),
    ('flutter_hooks', 'React-like hooks for Flutter'),
    ('cached_network_image', 'Image caching and loading'),
    ('flutter_svg', 'SVG rendering'),
    ('lottie', 'Lottie animations'),
    ('intl', 'Internationalization and localization'),
    ('url_launcher', 'Launch URLs in browser'),
  ];

  List<(String, String)> get _filteredPackages {
    if (_query.isEmpty) return _packages;
    return _packages
        .where((p) =>
            p.$1.toLowerCase().contains(_query.toLowerCase()) ||
            p.$2.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SearchField',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: styling.colors.primaryText,
            ),
          ),
          const SizedBox(height: 24),
          SearchField(
            controller: _controller,
            placeholder: 'Search packages...',
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPackages.length,
              itemBuilder: (context, index) {
                final package = _filteredPackages[index];
                return _PackageItem(
                  name: package.$1,
                  description: package.$2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageItem extends StatelessWidget {
  final String name;
  final String description;

  const _PackageItem({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: styling.colors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: styling.colors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
