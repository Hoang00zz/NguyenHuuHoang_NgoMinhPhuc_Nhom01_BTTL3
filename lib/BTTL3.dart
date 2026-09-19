// =============================================================================
// BÀI TẬP 03 - Giao diện "Quà của Vinh (7)" (mô phỏng màn hình MoMo)
//
// Cách chạy:
//   1. Tạo project:   flutter create bai05_layout
//   2. Chép toàn bộ nội dung file này đè lên  lib/main.dart
//   3. flutter run
//
// Kiến thức sử dụng (theo tài liệu Bài 05):
//   - Scaffold + AppBar (leading, title, actions)
//   - ListView ngang (scrollDirection: Axis.horizontal) cho thanh bộ lọc
//   - ListView.builder cho danh sách thẻ quà
//   - Lớp model (giống DeTai) + widget riêng cho từng item (giống DeTaiItem)
//   - AlertDialog khi bấm nút "Dùng ngay" / "Thu thập"
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// Màu chủ đạo của MoMo
const Color kMomoPink = Color(0xFFAE2070);
const Color kNenHong = Color(0xFFFCE4EF);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài tập 03',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kMomoPink),
        useMaterial3: true,
      ),
      home: const MyGiftScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. MODEL: thông tin một thẻ quà
// -----------------------------------------------------------------------------
class QuaTang {
  final String thuongHieu; // tên hiển thị ở khung bên trái
  final IconData icon; // logo (dùng Icon thay cho ảnh)
  final Color mauIcon;
  final String tieuDe; // "Giảm 100K"
  final String moTa; // "Cho đơn từ 0đ"
  final String? hanDung; // "HSD: 28/02/2025" (có thể không có)
  final bool sapHetHan; // true -> hiển thị chữ màu đỏ
  final String? nhan; // thẻ nhỏ: "Quà hiện vật"
  final String? nhanTrenLogo; // chữ nhỏ phía trên logo: "KM đã tặng"
  final bool coTim; // có hiển thị icon trái tim hay không
  final bool daThuThap; // true -> "Dùng ngay", false -> "Thu thập"
  bool yeuThich;

  QuaTang({
    required this.thuongHieu,
    required this.icon,
    required this.mauIcon,
    required this.tieuDe,
    required this.moTa,
    this.hanDung,
    this.sapHetHan = false,
    this.nhan,
    this.nhanTrenLogo,
    this.coTim = true,
    this.daThuThap = true,
    this.yeuThich = false,
  });
}

// -----------------------------------------------------------------------------
// 2. MÀN HÌNH CHÍNH
// -----------------------------------------------------------------------------
class MyGiftScreen extends StatefulWidget {
  const MyGiftScreen({super.key});

  @override
  State<MyGiftScreen> createState() => _MyGiftScreenState();
}

class _MyGiftScreenState extends State<MyGiftScreen> {
  final List<QuaTang> dsQua = [
    QuaTang(
      thuongHieu: 'CGV',
      icon: Icons.movie_outlined,
      mauIcon: Colors.red,
      tieuDe: 'CGV -',
      moTa: 'Đồng giá 79K khi mua vé CGV 2D trên MoMo',
      hanDung: 'HSD: 28/02/2025',
    ),
    QuaTang(
      thuongHieu: 'Mua Sim\nchính chủ',
      icon: Icons.sim_card_outlined,
      mauIcon: kMomoPink,
      tieuDe: 'Giảm 100K',
      moTa: 'Cho đơn từ 0đ',
      hanDung: 'HSD: 28/02/2025',
      yeuThich: true,
    ),
    QuaTang(
      thuongHieu: 'Ngân hàng\nQuốc Tế VIB',
      icon: Icons.account_balance_outlined,
      mauIcon: Colors.blue,
      tieuDe: 'Tặng 100k',
      moTa: 'Khi mở thẻ VIB Online Plus 2in1 (*)',
      hanDung: 'HSD: 31/03/2025',
      nhan: 'Quà hiện vật',
    ),
    QuaTang(
      thuongHieu: 'Thanh toán\nBảo hiểm',
      icon: Icons.beach_access_outlined,
      mauIcon: Colors.teal,
      tieuDe: 'Hoàn 15K',
      moTa: 'Cho hóa đơn từ 3.000.000đ',
      hanDung: 'Hết hạn sau 5 ngày',
      sapHetHan: true,
    ),
    QuaTang(
      thuongHieu: 'Phí không\ndừng',
      icon: Icons.toll_outlined,
      mauIcon: Colors.orange,
      tieuDe: 'Giảm 10K',
      moTa: 'Cho đơn từ 100K',
      nhanTrenLogo: 'KM đã tặng',
      coTim: false,
      daThuThap: false,
    ),
  ];

  // Hộp thoại thông báo (giống ví dụ Alert Dialog trong tài liệu)
  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------- AppBar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kNenHong,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      titleSpacing: 0,
      title: const Text(
        'Quà của Vinh (7)',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF7D3E4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.headset_mic_outlined, size: 18),
              Container(
                width: 1,
                height: 16,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: Colors.black38,
              ),
              const Icon(Icons.close, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------- Thanh bộ lọc ------
  Widget _buildBoLoc() {
    return Container(
      color: kNenHong,
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal, // cuộn ngang
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: const [
          FilterChipItem(leadingIcon: Icons.filter_alt_outlined),
          SizedBox(width: 8),
          FilterChipItem(label: 'Sắp xếp', trailingIcon: Icons.sort),
          SizedBox(width: 8),
          FilterChipItem(label: 'Dịch vụ', trailingIcon: Icons.keyboard_arrow_down),
          SizedBox(width: 8),
          FilterChipItem(label: 'Gần tôi'),
          SizedBox(width: 8),
          FilterChipItem(label: 'Yêu thích'),
          SizedBox(width: 8),
          FilterChipItem(label: 'Sắp hết hạn'),
        ],
      ),
    );
  }

  // ------------------------------------------ Hai thẻ tóm tắt: Xu + Thẻ quà ---
  Widget _buildTheTomTat() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: Row(
        children: [
          // --- Thẻ "Đang có 1.955 Xu"
          Expanded(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBC9),
                border: Border.all(color: const Color(0xFFFFC46B)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFFFA726),
                    child: Icon(Icons.monetization_on, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Đang có',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Text('1.955 Xu',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.black54),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          // --- Thẻ "Bỏ túi ngay 4 thẻ quà"
          Expanded(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF2F5BFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.card_giftcard, color: Colors.white, size: 30),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bỏ túi ngay',
                            style: TextStyle(fontSize: 12, color: Colors.white70)),
                        Text('4 thẻ quà',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_forward,
                        size: 14, color: Color(0xFF2F5BFF)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------- build -------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildBoLoc(),
          _buildTheTomTat(),
          // Danh sách thẻ quà - chiếm phần còn lại của màn hình
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 12),
              itemCount: dsQua.length,
              itemBuilder: (BuildContext context, int index) {
                final qua = dsQua[index];
                return QuaTangItem(
                  qua: qua,
                  onTapTim: () {
                    setState(() {
                      qua.yeuThich = !qua.yeuThich;
                    });
                  },
                  onTapNut: () {
                    _showDialog(
                      'Thông báo',
                      qua.daThuThap
                          ? 'Bạn chọn dùng ưu đãi "${qua.tieuDe}"'
                          : 'Bạn đã thu thập ưu đãi "${qua.tieuDe}"',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. WIDGET: nút lọc dạng viên thuốc (Sắp xếp, Dịch vụ, ...)
// -----------------------------------------------------------------------------
class FilterChipItem extends StatelessWidget {
  final String? label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const FilterChipItem({
    super.key,
    this.label,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) Icon(leadingIcon, size: 18),
          if (label != null)
            Text(label!, style: const TextStyle(fontSize: 13)),
          if (trailingIcon != null) ...[
            const SizedBox(width: 4),
            Icon(trailingIcon, size: 16),
          ],
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. WIDGET: một thẻ quà trong danh sách (giống DeTaiItem)
// -----------------------------------------------------------------------------
class QuaTangItem extends StatelessWidget {
  final QuaTang qua;
  final VoidCallback onTapTim;
  final VoidCallback onTapNut;

  const QuaTangItem({
    super.key,
    required this.qua,
    required this.onTapTim,
    required this.onTapNut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildKhungTrai(),
            Expanded(child: _buildKhungPhai()),
          ],
        ),
      ),
    );
  }

  // Khung bên trái: logo + tên thương hiệu
  Widget _buildKhungTrai() {
    return Container(
      width: 104,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
        border: Border(right: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (qua.nhanTrenLogo != null)
            Text(
              qua.nhanTrenLogo!,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          Icon(qua.icon, size: 32, color: qua.mauIcon),
          const SizedBox(height: 6),
          Text(
            qua.thuongHieu,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Khung bên phải: tiêu đề, mô tả, HSD, nút bấm
  Widget _buildKhungPhai() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hàng tiêu đề + trái tim
          Row(
            children: [
              Expanded(
                child: Text(
                  qua.tieuDe,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              if (qua.coTim)
                InkWell(
                  onTap: onTapTim,
                  child: Icon(
                    qua.yeuThich ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: qua.yeuThich ? kMomoPink : Colors.black45,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            qua.moTa,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
          if (qua.hanDung != null) ...[
            const SizedBox(height: 4),
            Text(
              qua.hanDung!,
              style: TextStyle(
                fontSize: 11,
                color: qua.sapHetHan ? Colors.deepOrange : Colors.black54,
              ),
            ),
          ],
          if (qua.nhan != null) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                qua.nhan!,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ),
          ],
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: qua.daThuThap
                ? TextButton(
                    onPressed: onTapNut,
                    style: TextButton.styleFrom(
                      foregroundColor: kMomoPink,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 28),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Dùng ngay',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  )
                : OutlinedButton(
                    onPressed: onTapNut,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kMomoPink,
                      side: const BorderSide(color: kMomoPink),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      minimumSize: const Size(0, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Thu thập',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}