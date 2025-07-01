import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../explore/presentation/screens/explore_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> tabTitles = ['Explore', 'Portfolio', 'Activity'];
  final List<Widget> tabContents = [ExploreScreen(), Placeholder(), Placeholder()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21.82),
                  color: Color(0xffFFFFFF),
                  border: Border.all(width: 1.71, color: Color(0x1A0166F4), style: BorderStyle.solid),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: SvgPicture.asset('assets/svgs/qalla.svg', fit: BoxFit.fill),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(tabTitles.length, (index) {
                  final isSelected = index == _selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() => _selectedIndex = index);
                      },
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(),
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        tabTitles[index],
                        textAlign: TextAlign.start,
                        style: TextStyle(color: isSelected ? Color(0xff355587) : Color(0xffDAE0EA), fontSize: 20.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12.0),
              TextField(
                cursorHeight: 12.0,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  prefixIcon: SizedBox(width: 40, height: 40, child: const Icon(Icons.search, color: Color(0xffC9D1DE))),
                  hintText: 'Search for a market',
                  hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xffC9D1DE)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xff032B69), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xff032B69), width: 1),
                  ),
                ),
              ),
              Expanded(
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0), child: tabContents[_selectedIndex]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
