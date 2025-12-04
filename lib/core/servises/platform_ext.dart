enum PlatformSource { all, aliexpress, alibaba, amazon, shein }

extension PlatformExt on PlatformSource {
  String get name {
    switch (this) {
      case PlatformSource.aliexpress:
        return 'aliexpress';
      case PlatformSource.alibaba:
        return 'alibaba';
      case PlatformSource.amazon:
        return 'amazon';
      case PlatformSource.shein:
        return 'shein';
      default:
        return '';
    }
  }

  static PlatformSource fromString(String value) {
    switch (value) {
      case 'aliexpress':
        return PlatformSource.aliexpress;
      case 'alibaba':
        return PlatformSource.alibaba;
      case 'amazon':
        return PlatformSource.amazon;
      case 'shein':
        return PlatformSource.shein;
      default:
        return PlatformSource.all;
    }
  }
}
