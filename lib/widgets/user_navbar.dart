// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gabriel_tour_app/widgets/selectable_bottom_navbar.dart';

// class UserNavbar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const UserNavbar({required this.currentIndex, required this.onTap, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SelectableBottomNavbar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       items: [
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/icons/navbar/search_trip_icon.svg',
//             height: 40,
//             colorFilter: ColorFilter.mode(
//               currentIndex == 0 ? Color(0xFFE4733A) : Colors.grey,
//               BlendMode.srcIn,
//             ),
//           ),
//           label: 'Vyhľadaj zájazdy',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/icons/navbar/my_trip_icon.svg',
//             height: 40,
//             colorFilter: ColorFilter.mode(
//               currentIndex == 1 ? Color(0xFFE4733A) : Colors.grey,
//               BlendMode.srcIn,
//             ),
//           ),
//           label: 'Môj zájazd',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/icons/navbar/message_icon.svg',
//             height: 40,
//             colorFilter: ColorFilter.mode(
//               currentIndex == 2 ? Color(0xFFE4733A) : Colors.grey,
//               BlendMode.srcIn,
//             ),
//           ),
//           label: 'Správy',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             'assets/icons/navbar/profile_icon.svg',
//             height: 40,
//             colorFilter: ColorFilter.mode(
//               currentIndex == 3 ? Color(0xFFE4733A) : Colors.grey,
//               BlendMode.srcIn,
//             ),
//           ),
//           label: 'Profil',
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/selectable_bottom_navbar.dart';

class UserNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const UserNavbar({required this.currentIndex, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableBottomNavbar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message, // Flutter icon for "Messages"
            size: 40,
            color: currentIndex == 0
                ? Color.fromARGB(255, 166, 94, 43) // Brown when selected
                : Colors.grey, // Grey when unselected
          ),
          label: 'Správy',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.airplane_ticket, // Flutter icon for "My Trip"
            size: 40,
            color: currentIndex == 1
                ? Color.fromARGB(255, 166, 94, 43) // Brown when selected
                : Colors.grey, // Grey when unselected
          ),
          label: 'Môj zájazd',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person, // Flutter icon for "Profile"
            size: 40,
            color: currentIndex == 2
                ? Color.fromARGB(255, 166, 94, 43) // Brown when selected
                : Colors.grey, // Grey when unselected
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}
