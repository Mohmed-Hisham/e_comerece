enum PlatformSource { all, aliexpress, alibaba, amazon, shein, localProduct }

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
      case PlatformSource.localProduct:
        return 'localproduct';
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
      case 'localproduct':
        return PlatformSource.localProduct;
      default:
        return PlatformSource.all;
    }
  }
}
