import 'package:goldvault/Models/AboutUsModel.dart';
import 'package:goldvault/Models/FAQModel.dart';
import 'package:goldvault/Models/GetCardModel.dart';
import 'package:goldvault/Models/GetChatModel.dart';
import 'package:goldvault/Models/GetGoldByDate.dart';
import 'package:goldvault/Models/GetGoldListModel.dart';
import 'package:goldvault/Models/GetGoldPriceModel.dart';
import 'package:goldvault/Models/GetNewsAndTipsModel.dart';
import 'package:goldvault/Models/InsertChatModel.dart';
import 'package:goldvault/Models/SellGoldFractionModel.dart';
import 'package:goldvault/Models/TermsConditionsModel.dart';

var userId;
var userName;
var userMailId;
var userMobile;
var userToken;
var userCountry="";
var userCity="";
var userAddress="";
var userImage="";
var userAvailableGold="0";
var userAvailableAmount="0";
var referalCode;
double currentLat = 0;
double currentLon = 0;
var currentAddress;
List<GetNewsAndTipsResult> getNewsAndTipsResult=[];
AboutUsResult? aboutResult;
TermsConditionResult? tcResult;
TermsConditionResult? privacyResult;
List<FAQResult> faqResult=[];
List<GetGoldListResult> goldListResult=[];
GetGoldPriceResult? goldPriceResult;
List<GetCardResult> getCardResult = [];
List<SellGoldFractionResult> sellGoldFractionResult = [];
InsertChatResult? insertChatResult;
List<GetChatResult> getChatResult = [];
List<GetGoldByDateResult> getGoldByDateResult1 = [];



