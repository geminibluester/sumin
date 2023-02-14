class AssetsManager {
  static const SHU_IMG = "assets/images/鼠.jpg";
  static const NIU_IMG = "assets/images/牛.jpg";
  static const HU_IMG = "assets/images/虎.jpg";
  static const JIEGUO_BG = "assets/images/bg.png";
  static const List SX = [
    '鼠',
    '牛',
    '虎',
    '兔',
    '龙',
    '蛇',
    '马',
    '羊',
    '猴',
    '鸡',
    '狗',
    '猪'
  ];
  static String getImage(String name) {
    print(name);
    return "assets/images/$name.jpg";
  }
}
