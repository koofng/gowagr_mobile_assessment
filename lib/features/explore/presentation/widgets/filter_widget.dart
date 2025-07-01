import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<_CategoryItem> _categories = [
    _CategoryItem(name: 'Trending', icon: Icons.trending_up),
    _CategoryItem(name: 'WatchList', icon: Icons.bookmark),
    _CategoryItem(name: 'Entertainment', icon: Icons.music_note_outlined),
    _CategoryItem(name: 'Sports', icon: Icons.sports_soccer),
  ];

  String _activeCategory = 'Trending';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = _categories[index];
            final isActive = item.name == _activeCategory;

            return TextButton.icon(
              onPressed: () {
                setState(() {
                  _activeCategory = _activeCategory == item.name ? '' : item.name;
                });
              },
              icon: Icon(item.icon, color: isActive ? Colors.white : Color(0x80355587), size: 18),
              label: Text(
                item.name,
                style: TextStyle(color: isActive ? Colors.white : Color(0x80355587), fontWeight: FontWeight.w500, fontSize: 12.0),
              ),
              style: TextButton.styleFrom(
                backgroundColor: isActive ? Colors.blue : Color(0xffECEFF2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryItem {
  final String name;
  final IconData icon;

  _CategoryItem({required this.name, required this.icon});
}
