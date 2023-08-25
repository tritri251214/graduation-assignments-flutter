import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/router.dart';

enum Menu { home, search, tickets, favorites, profile }

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.selectedMenu,
    this.router = const AppRouter(),
  });

  final Menu selectedMenu;
  final AppRouter router;

  @override
  State<BottomNavigationBarWidget> createState() => _ComponentState();
}

class _ComponentState extends State<BottomNavigationBarWidget> {
  int selectedMenu = 0;

  void _onChangeMenu(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        break;
      case 1:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/search-event', (route) => false);
        break;
      case 2:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/tickets', (route) => false);
        break;
      case 3:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/favorites', (route) => false);
        break;
      case 4:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/profile', (route) => false);
        break;
      default:
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        break;
    }
  }

  BottomNavigationBarItem buildItem(IconData iconData, Menu label) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: widget.selectedMenu == label  ? Colors.black : Colors.grey,
      ),
      label: label.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedMenu) {
      case Menu.home:
        selectedMenu = 0;
        break;
      case Menu.search:
        selectedMenu = 1;
        break;
      case Menu.tickets:
        selectedMenu = 2;
        break;
      case Menu.favorites:
        selectedMenu = 3;
        break;
      case Menu.profile:
        selectedMenu = 4;
        break;
      default:
        selectedMenu = 0;
        break;
    }
    return BottomNavigationBar(
      backgroundColor: AppColors.backgroundCard,
      elevation: 2,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        buildItem(Icons.home_outlined, Menu.home),
        buildItem(Icons.search_outlined, Menu.search),
        buildItem(Icons.local_offer_outlined, Menu.tickets),
        buildItem(Icons.favorite_border_outlined, Menu.favorites),
        buildItem(Icons.person_outline, Menu.profile),
      ],
      currentIndex: selectedMenu,
      selectedItemColor: Colors.black,
      onTap: _onChangeMenu,
    );
  }
}
