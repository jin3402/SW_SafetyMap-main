// ... imports ...
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // _onItemTapped 함수 삭제됨 (MainScreen이 처리)

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말로 로그아웃하시겠습니까?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/splash'),
              child: const Text('로그아웃', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('SafeMap', style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600)),
        centerTitle: false,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨김
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          _buildSettingsMenuItem(
              icon: Icons.favorite_outline,
              title: '즐겨찾기 설정',
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('즐겨찾기 설정')))),
          // ... (나머지 메뉴 아이템들은 그대로 유지) ...

          const SizedBox(height: 24),
          GestureDetector(
              onTap: _logout,
              child: Container(
                // ... (로그아웃 버튼 스타일 그대로 유지) ...
                  child: Row( children: const [ Icon(Icons.logout, color: Colors.red), SizedBox(width:16), Text('로그아웃', style:TextStyle(color:Colors.red)) ] )
              )
          )
        ],
      ),
      // bottomNavigationBar 삭제됨!
    );
  }

  Widget _buildSettingsMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    // (기존 코드 유지)
    return GestureDetector(
      // ...
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration( border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
            child: Row( children: [ Icon(icon, color: const Color(0xFF2567E8)), const SizedBox(width: 16), Text(title), const Spacer(), const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey) ])
        )
    );
  }
}