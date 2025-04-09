import 'package:get/get.dart';
import '/common/share_pref.dart';

class StickerController extends GetxController {
  static final List<String> _defaultRemainList = [
    'assets/images/stickers/sticker_1.png',
    // 'assets/images/stickers/sticker_2.png',
    'assets/images/stickers/sticker_3.png',
    // 'assets/images/stickers/sticker_4.png',
    'assets/images/stickers/sticker_5.png',
    'assets/images/stickers/sticker_6.png',
    'assets/images/stickers/sticker_7.png',
    'assets/images/stickers/sticker_8.png',
    // 'assets/images/NFTs/nft_1.png',
    'assets/images/NFTs/nft_2.png',
    'assets/images/NFTs/nft_3.png',
    'assets/images/NFTs/nft_4.png',
    'assets/images/NFTs/nft_5.png',
    'assets/images/NFTs/nft_6.png',
    'assets/images/NFTs/nft_7.png',
    'assets/images/NFTs/nft_8.png',
    // 'assets/images/NFTs/nft_9.png',
  ];
  static final List<String> _defaultStickerList = [
    'assets/images/stickers/sticker_2.png',
    'assets/images/stickers/sticker_4.png',
    'assets/images/NFTs/nft_1.png',
    'assets/images/NFTs/nft_9.png',
  ];
  static List<String> remainList = [];
  static List<String> stickerList = [];

  static init() {
    remainList = SharePref.getStringList('remainList') ?? _defaultRemainList;
    stickerList = SharePref.getStringList('stickerList') ?? _defaultStickerList;
  }

  // 获得新的贴纸
  static resiveSticker(index) {
    stickerList = [remainList[index], ...stickerList];
    remainList.removeAt(index);
    SharePref.setStringList('remainList', remainList);
    SharePref.setStringList('stickerList', stickerList);
  }
}