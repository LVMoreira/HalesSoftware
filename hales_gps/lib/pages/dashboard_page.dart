import 'package:flutter/material.dart';
import 'package:hales_gps/theme.dart';
import 'login_page.dart';
import 'maps_page.dart';
import 'home_page.dart';
import 'notifications_page.dart';
import 'list_nodes_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return HomePage(); // Página inicial
      case 1:
        return MapsPage(); // Página do mapa
      case 2:
        return ListNodesPage(); // Página de notificações
      case 3:
        return NotificationsPage();
      default:
        return Center(child: Text("Página não encontrada", style: TextStyle(fontSize: 24, color: Colors.white)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 60,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(color: AppTheme.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 69, 69, 69),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(  
                    onPressed: logout , 
                    icon: Icon(Icons.gps_fixed, size: 20, color: Colors.blue)),
                ),
                Spacer(),
                SidebarButton(icon: Icons.home, index: 0, selectedIndex: selectedIndex, onTap: onItemTapped),
                SidebarButton(icon: Icons.map, index: 1, selectedIndex: selectedIndex, onTap: onItemTapped),
                SidebarButton(icon: Icons.list, index: 2, selectedIndex: selectedIndex, onTap: onItemTapped),
                SidebarButton(icon: Icons.notifications, index: 3, selectedIndex: selectedIndex, onTap: onItemTapped),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(  
                    onPressed: logout , 
                    icon: Icon(Icons.logout, size: 20, color: Colors.red)),
                ),
              ],
            ),
          ),

          // Conteúdo principal
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: _getPageForIndex(selectedIndex),
              ),
            ),
        ],
      ),
    );
  }
  }

// Componente para os botões do sidebar
class SidebarButton extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isLogout;

  const SidebarButton({
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == selectedIndex;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(8),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : (isLogout ? Colors.red : Colors.grey),
            size: 20,
          ),
        ),
      ),
    );
  }
}
