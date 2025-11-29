import 'package:flutter/material.dart';
import 'favorites_screen.dart';        // 즐겨찾기 화면
import 'emergency_contact_screen.dart'; // 긴급연락처 화면
import 'privacy_policy_screen.dart';    // 개인정보 처리방침 화면

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 로그아웃 확인 팝업
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말로 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 스플래시 화면으로 이동하며 이전 페이지 스택 모두 제거
                Navigator.pushNamedAndRemoveUntil(
                    context, '/splash', (route) => false);
              },
              child: const Text(
                '로그아웃',
                style: TextStyle(color: Colors.red),
              ),
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
        title: const Text(
          'SafeMap',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false, // 탭 화면이므로 뒤로가기 버튼 숨김
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          // 1. 즐겨찾기 설정 (연결됨)
          _buildSettingsMenuItem(
            icon: Icons.favorite_outline,
            title: '즐겨찾기 설정',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          const SizedBox(height: 16),

          // 2. 긴급연락처 (연결됨)
          _buildSettingsMenuItem(
            icon: Icons.phone,
            title: '긴급연락처',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmergencyContactScreen()),
              );
            },
          ),
          const SizedBox(height: 16),

          // 3. 위치 공유 유효시간 (준비 중)
          _buildSettingsMenuItem(
            icon: Icons.timer,
            title: '위치 공유 유효시간',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('준비 중인 기능입니다.')),
              );
            },
          ),
          const SizedBox(height: 16),

          // 4. 알림 설정 (준비 중)
          _buildSettingsMenuItem(
            icon: Icons.notifications_none,
            title: '알림 설정',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('준비 중인 기능입니다.')),
              );
            },
          ),
          const SizedBox(height: 16),

          // 5. 개인정보 보호 (연결됨)
          _buildSettingsMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: '개인정보 보호',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          const SizedBox(height: 24),

          // 6. 로그아웃 버튼
          GestureDetector(
            onTap: _logout,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 메뉴 아이템 디자인 위젯 (중복 제거용)
  Widget _buildSettingsMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF2567E8),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}