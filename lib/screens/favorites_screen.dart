import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _homeController = TextEditingController();
  final _workController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations(); // 화면이 켜지면 저장된 주소를 불러옵니다.
  }

  @override
  void dispose() {
    _homeController.dispose();
    _workController.dispose();
    super.dispose();
  }

  // 저장된 주소 불러오기
  Future<void> _loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _homeController.text = prefs.getString('home_address') ?? ''; // 없으면 빈칸
      _workController.text = prefs.getString('work_address') ?? '';
      _isLoading = false;
    });
  }

  // 주소 저장하기
  Future<void> _saveLocations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('home_address', _homeController.text);
    await prefs.setString('work_address', _workController.text);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('즐겨찾기 장소가 저장되었습니다!')),
    );
    Navigator.pop(context); // 저장 후 설정 화면으로 돌아가기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '즐겨찾기 설정',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '자주 가는 장소를 등록해두세요.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // 집 주소 입력란
            _buildLocationInput(
              controller: _homeController,
              label: '집 (Home)',
              icon: Icons.home_rounded,
              hint: '집 주소를 입력하세요',
            ),
            const SizedBox(height: 20),

            // 직장/학교 주소 입력란
            _buildLocationInput(
              controller: _workController,
              label: '직장 / 학교 (Work)',
              icon: Icons.work_rounded,
              hint: '직장 또는 학교 주소를 입력하세요',
            ),

            const Spacer(),

            // 저장 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveLocations,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2567E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '저장하기',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 입력 필드 디자인 위젯
  Widget _buildLocationInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF2567E8)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}