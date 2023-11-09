import 'package:flutter/material.dart';

abstract class AppColors {
  // app primary colors
  static const agentPrimary = Color(0xFF23003D);
  static const primary = Color(0xFF00008B);
  static const primary01 = Color(0xFF581689);
  static const primary02 = Color(0xFF42D110);
  static const primary03 = Color(0xFFFE5139);
  static const primary04 = Color(0xFF3B0067);
  static const primary05 = Color(0xFF38007D);
  static const primaryMerchant01 = Color(0xFF3C1E88);
  static const primaryCyan = Color(0xFF00C3FF);
  static const primaryOrange = Color(0xFFD94F00);
  static const primaryGred = LinearGradient(
    colors: [
      Color(0xFF3B0067),
      Color(0xFF7500CC),
    ],
  );
  static const rewardsGrad = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF3B0067),
      Color(0xFF7500CC),
      Color(0xFF840B6E),
      Color(0xFFFFBC99),
      Color(0xFFCABDFF),
    ],
  );

  // app neutral colors
  static const neutral00 = Color(0xFFFFFFFF);
  static const neutral01 = Color(0xFFFCFCFC);
  static const neutral02 = Color(0xFFFAFAFA);
  static const neutral03 = Color(0xFFEFEFEF);
  static const neutral03Shade = Color(0xFFE6E6E6);
  static const neutral04 = Color(0xFF6F767E);
  static const neutral04Shade = Color(0xFF9A9FA5);
  static const neutral05 = Color(0xFF33383F);
  static const neutral06 = Color(0xFF272B30);
  static const neutral07 = Color(0xFF1A1D1F);
  static const neutral08 = Color(0xFF000000);
  static const neutral09 = Color(0xFFF6F7F9);
  static const neutral10 = Color(0xFF676E76);
  static const neutral11 = Color(0xFF141414);
  static const neutralSecondary4 = Color(0xFFF6F2FF);
  static const neutral800 = Color(0xFF1C1C1E);
  static const neutral25 = Color(0xFFF8F8FC);

  static const neutralBlack02 = Color(0xFFF9F9F9);
  static const silverGrey = Color(0xffCECDD3);
  static const paleSkyGrey = Colors.black;
  static const mecuryGrey = Color(0xffE5E5E5);

  // app secondary colors
  static const secondary01 = Color(0xFFFFBC99);
  static const secondary02 = Color(0xFFCABDFF);
  static const secondary03 = Color(0xFFB1E5FC);
  static const secondary04 = Color(0xFFB5E4CA);
  static const secondary05 = Color(0xFFFFD88D);
  static const secondary06 = Color(0xFFF8EFFF);
  static const secondary07 = Color(0xFFFAF3FF);
  static const secondary08 = Color(0xFFFFE3EF);
  static const secondary09 = Color(0xFFF5E7FF);
  static const secondary10 = Color(0xFFEEEAFF);
  static const secondary14 = Color(0xFFFFF6F4);
  static const secondary15 = Color(0xFFEEE8F3);
  static const secondary16 = Color(0xFFEDE7F5);

  // auxiliary
  static const mercuryGrey = Color(0xffE5E5E5);
  static const searchBarHint = Color(0xffB1B5C3);
  static const lightGrey = Color(0xff7D7D7D);
  static const borderColor = Color(0xFFE6E8EC);
  static const separatorColor = Color(0xffE0E4EB);
  static const error = Color(0xFFFB0000);
  static const limeGreen = Color(0xFF33C300);
  static const darkPurple = Color(0xFF200E32);
  static const brightTurquoiseBlue = Color(0xff00C3FF);
  static const green2 = Color(0xFF27AE60);
  static const deepPurple = Color(0xff440A70);
  static const searchBarBorder = Color(0xffE6E8EC);
  static const appGreenVariant = Color(0xff00c994);
  static const appGreen = Color(0xff4dc247);
  static const searchBarIcon = Color(0xff6B697C);
  static const registrationBonus = Color(0xffFFE1BD);
  static const transactionBonus = Color(0xffF7D7FF);
  static const deepGreen = Color(0xFF006761);
  static const lightGold = Color(0xFFD1BA8D);
  static const goldBrass = Color(0xFF9A6A3A);
  static const lightGoldBrass = Color(0xFF956701);
  static const springGreen = Color(0xFF08A900);
  static const inactive = Color(0xFFD9D9D9);
  static const Color cardCream = Color(0xffFFEAEC);
  static const shade04 = Color(0xFF9A9FA5);
  static const lightBlue = Color(0xFFF3F0FF);

  // gradient
  static const green = LinearGradient(
    colors: [
      Color(0xFFC1E5C1),
      Color(0xFFDBF2DB),
    ],
  );
  static const gold = LinearGradient(
    colors: [
      Color(0xFFEAD3A8),
      Color(0xFFFDF2DF),
    ],
  );
  static const greyGradient = LinearGradient(
    colors: [
      Color(0xFF696969),
      Color(0xFFA9A9A9),
    ],
  );
  static const gold1 = LinearGradient(
    colors: [
      Color(0xFFD1BA8D),
      Color(0xFF98845E),
    ],
  );
  static const purple = LinearGradient(
    colors: [
      Color(0xFFF6D0FF),
      Color(0xFFFCEFFF),
    ],
  );
  static const magenta = LinearGradient(
    colors: [
      Color(0xffDCBEE3),
      Color(0xffF9EAFD),
    ],
  );
  static const gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF100750),
      Color(0xFF840B6E),
    ],
  );

  static const primaryGradient = LinearGradient(
    colors: [
      Color(0xFF3B0067),
      Color(0xFF7500CC),
    ],
  );
}

const Color deeperSenacePurple = Color(0xff41086c);
const Color darkDeepBlue = Color(0xff1B003E);
const Color darkOceanBlue = Color(0xFF221745);
const Color deeperOceanBlue = Color(0xFF2B1E65);
const Color wealth = Color(0xff3c1e88);
const Color merchantBlue = Color(0xFF312567);
const Color deepPurple = Color(0xff440A70);
const Color classicRoseLilac = Color(0xffF9C9F9);
const Color faintRoseLilac = Color(0xffF8EFFF);
const Color receiveAsh = Color(0xff515151);
const Color sendDark = Color(0xff262626);
const Color purple = Color(0xffB56FFF);
const Color blue = Color(0xff79E1F9);
const Color hawkesBlue = Color(0xffD5EAFC);
const Color paleSkyGrey = Colors.black;
const Color skyGrey = Color(0xff595959);
const Color greyAsh = Color(0xffB1B5C3);
const Color sharkBlack = Color(0xff1A1D1F);
const Color alabasterGrey = Color(0xffF9F9F9);
const Color lighterGrey = Color(0xff272B30);
const Color mecuryGrey = Color(0xffE5E5E5);
const Color chablisRed = Color(0xffFFF5F5);
const Color galleryGrey = Color(0xffEBEBEB);
const Color brightTurquoiseBlue = Color(0xff00C3FF);
const Color curiousBlue = Color(0xff2182D3);
const Color searchBarHint = Color(0xffB1B5C3);
const Color searchBarBorder = Color(0xffE6E8EC);
const Color searchBarIcon = Color(0xff6B697C);
const Color separatorColor = Color(0xffE0E4EB);
const Color neutral = Color(0xffEFEFEF);
const Color indicatorNeutral = Color(0xFFE4E4E4);
const Color appGreen = Color(0xff4dc247);
const Color appGreenVariant = Color(0xff00c994);
const Color appGreenAccent = Color(0xff66d7b8);
const Color greenAccent = Color(0xff2cda9a);
const Color dividerColor = Color(0xffF4F4F4);
const Color appRed = Color(0xffEB5757);
const Color error = Color(0xffFB0000);
const Color silverGrey = Color(0xffCECDD3);
const Color subText = Color(0xff747474);
const Color neutral08 = Color(0xff111315);
const Color accessBlue = Color(0xff301EA5);
const Color defaultBlack = Color(0xff080524);
const Color orangeAccent = Color(0xffff961b);
const Color neutral04 = Color(0xff6F767E);
const Color ashBlack = Color(0xff141414);
const Color cardCream = Color(0xffFFEAEC);
