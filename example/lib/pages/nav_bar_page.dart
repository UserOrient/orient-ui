import 'package:flutter/material.dart';
import 'package:example/widgets/nav_bar.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _mobileIndex = 0;
  int _desktopIndex = 0;

  static final _demoItems = [
    NavBarItem(icon: const Icon(Icons.home_outlined), label: 'Home'),
    NavBarItem(icon: const Icon(Icons.search), label: 'Search'),
    NavBarItem(icon: const Icon(Icons.person_outline), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Mobile (Bottom Bar)',
          child: _buildPreviewContainer(
            width: 375,
            height: 667,
            child: NavBar(
              currentIndex: _mobileIndex,
              onTap: (i) => setState(() => _mobileIndex = i),
              items: _demoItems,
              body: _buildDemoBody('Mobile View', _mobileIndex),
            ),
          ),
        ),
        _buildSection(
          title: 'Desktop (Rail)',
          child: _buildPreviewContainer(
            width: 800,
            height: 500,
            child: NavBar(
              currentIndex: _desktopIndex,
              onTap: (i) => setState(() => _desktopIndex = i),
              items: _demoItems,
              railHeader: const Text(
                'Logo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              body: _buildDemoBody('Desktop View', _desktopIndex),
            ),
          ),
        ),
        _buildSection(
          title: 'With Header & Footer',
          child: _buildPreviewContainer(
            width: 800,
            height: 500,
            child: NavBar(
              currentIndex: 0,
              onTap: (_) {},
              items: _demoItems,
              railHeader: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF18181B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.bolt, color: Colors.white, size: 20),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Acme Inc',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              railFooter: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFFE4E4E7),
                      child: Icon(Icons.person, size: 18, color: Color(0xFF71717A)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'John Doe',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              body: _buildDemoBody('With Header & Footer', 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDemoBody(String title, int index) {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: ${_demoItems[index].label}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF71717A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewContainer({
    required double width,
    required double height,
    required Widget child,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE4E4E7)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: MediaQuery(
        data: MediaQueryData(size: Size(width, height)),
        child: child,
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF71717A),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
