import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '개인정보 처리방침',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SafeMap 개인정보 처리방침',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '시행일자: 2024년 11월 29일',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const Divider(height: 30, thickness: 1),

            _buildSection(
              '1. 개인정보의 처리 목적',
              'SafeMap(이하 "앱")은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않습니다.\n\n'
                  '- 사용자 위치 기반 안전 시설(파출소, 비상벨 등) 안내\n'
                  '- 긴급 상황 발생 시 현재 위치 공유 기능 제공\n'
                  '- 자주 가는 장소(즐겨찾기) 저장 및 편의 기능 제공',
            ),

            _buildSection(
              '2. 수집하는 개인정보의 항목',
              '앱은 서비스 제공을 위해 다음과 같은 정보를 수집 및 이용합니다.\n\n'
                  '1) 필수적 정보: 사용자 실시간 위치 정보(GPS)\n'
                  '   * 위치 정보는 서버에 저장되지 않으며, 앱 실행 시 실시간 편의 기능 제공 목적으로만 사용됩니다.\n'
                  '2) 선택적 정보: 자주 가는 장소(집, 직장 등) 주소 정보\n'
                  '   * 해당 정보는 기기 내부(내부 저장소)에만 저장됩니다.',
            ),

            _buildSection(
              '3. 개인정보의 처리 및 보유 기간',
              '1) 위치 정보: 앱이 실행되는 동안 실시간으로만 활용되며, 별도로 서버에 저장하거나 보관하지 않습니다.\n'
                  '2) 기기 내 저장 정보(즐겨찾기): 사용자가 앱을 삭제하거나 데이터를 지우기 전까지 기기 내에 보관됩니다.',
            ),

            _buildSection(
              '4. 제3자 제공 및 위탁',
              '앱은 지도 서비스 제공을 위해 다음과 같이 제3자 서비스를 이용합니다.\n\n'
                  '- 제공 대상: Google Maps Platform\n'
                  '- 제공 목적: 지도 화면 출력 및 위치 좌표 확인\n'
                  '- 제공 항목: 위치 좌표(위도, 경도)',
            ),

            _buildSection(
              '5. 이용자의 권리',
              '이용자는 언제든지 다음의 권리를 행사할 수 있습니다.\n\n'
                  '- 위치 정보 접근 권한 허용/거부 설정 (휴대전화 설정)\n'
                  '- 앱 내 저장된 즐겨찾기 정보 수정 및 삭제\n'
                  '- 앱 삭제 시 모든 데이터 파기',
            ),

            _buildSection(
              '6. 개인정보 보호책임자',
              '서비스 이용 중 발생하는 모든 개인정보보호 관련 민원은 아래로 문의해 주시기 바랍니다.\n\n'
                  '- 이메일: support@safemap.com (예시)\n'
                  '- 개발자 연락처: 010-0000-0000',
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                'SafeMap Team',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400]
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2567E8), // 앱 테마 색상 적용
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6, // 줄 간격 넉넉하게
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}