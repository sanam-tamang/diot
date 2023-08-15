import 'package:devmandu/core/enum/hero_tag_type.dart';

///it helps to shows different hero tag string data
///it helpst to overcome the confict between different tags
class HeroBuilder {
  static String getTag({required HeroTagType tag, required String payload}) {
    switch (tag) {
      case HeroTagType.article:
        return "article$payload";
      case HeroTagType.profile:
        return "profile$payload";
      case HeroTagType.background:
        return "background$payload";
      default:
        return "others$payload";
    }
  }
}
