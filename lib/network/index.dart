import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:rupee_day/Controllers/auth_first_controller.dart';
import 'package:rupee_day/models/auth_info_model.dart';
import 'package:rupee_day/models/auth_params_model.dart';
import 'package:rupee_day/models/feedback_list_result.dart';
import 'package:rupee_day/models/feedback_model.dart';
import 'package:rupee_day/models/image_upload_params.dart';
import 'package:rupee_day/models/liveness_params_model.dart';
import 'package:rupee_day/models/login_result_model.dart';
import 'package:rupee_day/models/optical_character_model.dart';
import 'package:rupee_day/models/order_detail_result_model.dart';
import 'package:rupee_day/models/order_result_list_model.dart';
import 'package:rupee_day/models/product_detail_model.dart';
import 'package:rupee_day/models/product_list_model.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/models/purchase_result_model.dart';
import 'package:rupee_day/models/repay_extension_model.dart';
import 'package:rupee_day/models/space_result_model.dart';
import 'package:rupee_day/models/user_info_model.dart';
import 'package:rupee_day/network/api_base_response.dart';
import 'package:rupee_day/util/dio_util/dio_method.dart';
import 'package:rupee_day/util/dio_util/index.dart';
import 'package:rupee_day/util/random_util.dart';
import 'package:rupee_day/views/order_tab/order_type.dart';

class NetworkApi {
  // 发送验证码
  static void sendOTP(String phone, Function()? success) {
    _request('/EZDyP/ynKmyF', params: {'uXXXseXXrPhone': phone}).then((value) {
      if (value != null) {
        success!();
      }
    });
  }

  // 登录
  static Future<LoginResultModel> login(String phone, String code) async {
    var json = await _request('/EZDyP/EhULCC', params: {'uXXXseXXrPhone': phone, 'lXXXogXXinCode': code});
    return LoginResultModel.fromJson(json);
  }

  // 登出
  static Future logout() async {
    await _request('/EZDyP/YWDwpx');
  }

  // 登录前首页
  static Future<List<ProductModel>> fetchUnLoginProducts() async {
    var json = await _request('/EZDyP/BuGuN');
    return ProductListModel.fromJson(json).productList;
  }

  // 获取用户信息
  static Future<UserInfoModel> fetchUserInfo() async {
    var json = await _request('/EZDyP/lnTwMn/hLZYt');
    return UserInfoModel.fromJson(json);
  }

  // 获取推荐产品
  static Future<ProductDetailModel?> fetchRecommendProduct() async {
    var json = await _request(
      '/EZDyP/lnTwMn/hLZYt',
      params: {'iXXXsRXXecommend': '1'},
    );
    return UserInfoModel.fromJson(json).loanProduct;
  }

  // 获取用户认证信息
  static Future<AuthInfoModel> fetchAuthInfo() async {
    var json = await _request('/EZDyP/lnTwMn/FWsblY');
    return AuthInfoModel.fromJson(json);
  }

  // OCR 识别
  static Future<OpticalCharacterModel> opticalCharacterRecognition(String filePath, {required OCRType type}) async {
    EasyLoading.show(status: 'recognizing...', maskType: EasyLoadingMaskType.black);
    var json = await _request('/EZDyP/lnTwMn/omxwY');
    ImageUploadParams params = ImageUploadParams.fromJson(json);
    String objectKey = await awsImageUpload(params, filePath);

    // 上传完成回调到服务器
    String ocrType;
    switch (type) {
      case OCRType.front:
        ocrType = 'AADHAAR_FRONT';
      case OCRType.back:
        ocrType = 'AADHAAR_BACK';
      case OCRType.pan:
        ocrType = 'PAN_FRONT';
    }
    var resultJson = await _request(
      '/EZDyP/lnTwMn/juJeY',
      params: {
        'iXXXmaXXgeUrl': objectKey,
        'oXXXcrXXType': ocrType,
      },
    );
    OpticalCharacterModel model = OpticalCharacterModel.fromJson(resultJson);
    return model;
  }

  static Future<String> awsImageUpload(ImageUploadParams params, String filePath) async {
    AwsClientCredentials credentials = AwsClientCredentials(
      accessKey: params.credentials.accessKeyId,
      secretKey: params.credentials.secretAccessKey,
      sessionToken: params.credentials.sessionToken,
    );

    S3 client = S3(region: params.awsRegion, credentials: credentials);

    // 图片路径
    var date = formatDate(DateTime.now(), ['yyyy', '-', 'mm', '-', 'dd']);
    String objectKey = '${params.awsFolder}$date${RandomUtil.generateRandomString(32)}.jpg';

    // 压缩图片
    Uint8List imgData = await compressImageToLower200kB(filePath);
    PutObjectOutput output = await client.putObject(
      bucket: params.awsBucket,
      key: objectKey,
      body: imgData,
      contentType: 'image/jpeg',
    );

    return objectKey;
  }

  static void livenessAuth({required String filePath, required String faceScore, Function()? success}) async {
    EasyLoading.show(status: 'authenticating...');
    var json = await _request('/EZDyP/lnTwMn/omxwY');
    ImageUploadParams params = ImageUploadParams.fromJson(json);
    String fileUrl = await awsImageUpload(params, filePath);
    await _request('/EZDyP/lnTwMn/dFZZE', params: {
      'uXXXseXXrFaceStep': 'liveness',
      'lXXXivXXenessImg': fileUrl,
      'lXXXivXXenessScore': faceScore,
    });
    EasyLoading.dismiss();
    success!();
  }

  // 获取活体认证参数
  static Future<LivenessParamsModel> fetchLivenessParams() async {
    var json = await _request('/EZDyP/lnTwMn/dFZZE', params: {'uXXXseXXrFaceStep': 'license'});
    return LivenessParamsModel.fromJson(json);
  }

  // 启动时访问，第一个网络请求
  static Future firstRequest() async {
    await _request('/EZDyP/ZEQZIN');
  }

  // 统一认证接口
  static void authentication(AuthParamsModel paramsModel, {Function()? successCallback}) async {
    Map<String, dynamic> params = {'aXXXutXXhStep': paramsModel.authStep};
    switch (paramsModel.authStep) {
      case '1':
        params['fXXXroXXntImage'] = paramsModel.frontImage;
        params['bXXXacXXkImage'] = paramsModel.backImage;
        params['pXXXanXXCardImg'] = paramsModel.panCardImg;
        params['aXXXadXXhaarNumber'] = paramsModel.aadhaarNumber;
        params['uXXXseXXrNames'] = paramsModel.userNames;
        params['uXXXseXXrGender'] = paramsModel.userGender;
        params['dXXXatXXeOfBirth'] = paramsModel.dateOfBirth;
        params['aXXXddXXressDetail'] = paramsModel.addressDetail;
        params['pXXXanXXNumber'] = paramsModel.panNumber;
      case '2':
        params['wXXXhaXXtsAppAccount'] = paramsModel.whatsAppAccount;
        params['mXXXarXXriageStatus'] = paramsModel.marriageStatus;
        params['eXXXduXXcation'] = paramsModel.education;
        params['mXXXonXXthlySalary'] = paramsModel.monthlySalary;
        params['uXXXseXXrIndustry'] = paramsModel.userIndustry;
        params['wXXXorXXkTitle'] = paramsModel.workTitle;
        params['uXXXseXXrEmail'] = paramsModel.userEmail;
        if (paramsModel.applyAmount != null) {
          params['aXXXppXXlyAmount'] = paramsModel.applyAmount;
        }
        params['bXXXanXXkCardNo'] = paramsModel.bankCardNo;
        params['bXXXanXXkCardName'] = paramsModel.bankCardName;
        params['bXXXanXXkIfscCode'] = paramsModel.bankIfscCode;
      case '3':
        params['cXXXonXXtactList'] = paramsModel.contactList;
    }
    await _request('/EZDyP/lnTwMn/eAbBJ', params: params);
    successCallback!();
  }

  // 下单
  static Future<PurchaseResultModel> purchaseProduct(Map<String, dynamic> params) async {
    var json = await _request('/EZDyP/lnTwMn/ZwOTB', params: params);
    PurchaseResultModel model = PurchaseResultModel.fromJson(json);
    return model;
  }

  // 查询 space 详情
  static Future<SpaceResultModel> checkSpaceDetail(String productId) async {
    var json = await _request('/EZDyP/lnTwMn/rkiEL', params: {'pXXXroXXductId': productId});
    SpaceResultModel model = SpaceResultModel.fromJson(json);
    return model;
  }

  // 获取订单列表
  static Future<OrderResultListModel> fetchOrderList(OrderType type) async {
    Map<String, dynamic> params = {};
    switch (type) {
      case OrderType.pending:
        params['oXXXrdXXerStatus'] = '1';
        break;
      case OrderType.disbursing:
        params['oXXXrdXXerStatus'] = '2';
        break;
      case OrderType.unpaid:
        params['oXXXrdXXerStatus'] = '3';
        break;
      case OrderType.payed:
        params['oXXXrdXXerStatus'] = '4';
        break;
      case OrderType.disbursingFail:
        params['oXXXrdXXerStatus'] = '5';
        break;
      case OrderType.overdue:
        params['oXXXrdXXerStatus'] = '6';
        break;
      default:
        break;
    }
    var json = await _request('/EZDyP/lnTwMn/iOUrJ', params: type != OrderType.none ? params : null);
    OrderResultListModel listModel = OrderResultListModel.fromJson(json);
    return listModel;
  }

  static Future changeBankCard({required String cardNumber, required String bankName, required String ifscCode}) async {
    await _request('/EZDyP/lnTwMn/RCtjf', params: {'bXXXanXXkCardNo': cardNumber, 'bXXXanXXkCardName': bankName, 'bXXXanXXkIfscCode': ifscCode});
  }

  static Future<List<FeedbackModel>> fetchFeedbackList() async {
    var json = await _request('/EZDyP/lnTwMn/IlLwW');
    FeedbackListResult result = FeedbackListResult.fromJson(json);
    return result.feedBackList;
  }

  static Future<String> uploadFeedbackImage(String filePath) async {
    EasyLoading.show(status: 'uploading...', maskType: EasyLoadingMaskType.black);
    var json = await _request('/EZDyP/lnTwMn/omxwY');
    ImageUploadParams params = ImageUploadParams.fromJson(json);
    String objectKey = await awsImageUpload(params, filePath);
    EasyLoading.dismiss();
    return objectKey;
  }

  static saveFeedback({
    required String orderNumber,
    required String feedBackType,
    required String feedBackContent,
    String? feedBackImg,
    Function()? successCallback,
  }) async {
    Map<String, dynamic> params = {
      'lXXXoaXXnOrderNo': orderNumber,
      'fXXXeeXXdBackType': feedBackType,
      'fXXXeeXXdBackContent': feedBackContent,
    };
    if (feedBackImg != null) {
      params['fXXXeeXXdBackImg'] = feedBackImg;
    }
    await _request('/EZDyP/lnTwMn/UbCON', params: params);
    if (successCallback != null) successCallback!();
  }

  // 订单详情
  static Future<OrderDetailResultModel> fetchOrderDetail(String orderNumber) async {
    var json = await _request('/EZDyP/lnTwMn/Subxj', params: {'lXXXoaXXnOrderNo': orderNumber});
    return OrderDetailResultModel.fromJson(json);
  }

  // 获取还款路径
  static Future<Map<String, dynamic>> fetchRepayPath({required String orderNumber, String repayType = 'all', required String loanRepayDate}) async {
    Map<String, dynamic> result = await _request('/EZDyP/lnTwMn/sYByG', params: {
      'lXXXoaXXnOrderNo': orderNumber,
      'rXXXepXXayType': repayType,
      'lXXXoaXXnRepayDate': loanRepayDate,
    });
    return result;
  }

  // 获取展期详情
  static Future<RepayExtensionModel> fetchRepayExtensionDetail(String orderNumber) async {
    var json = await _request('/EZDyP/lnTwMn/nfqaBX', params: {'lXXXoaXXnOrderNo': orderNumber});
    return RepayExtensionModel.fromJson(json);
  }

  // 压缩图片到200kb
  static Future<Uint8List> compressImageToLower200kB(String filePath) async {
    Uint8List imageCompressed = Uint8List(0);
    for (int i = 0; i < 100; i++) {
      Uint8List? stempList = await FlutterImageCompress.compressWithFile(
        filePath,
        minWidth: 1024,
        minHeight: 768,
        quality: 100 - i,
      );
      if (stempList != null && stempList.length <= 200000) {
        imageCompressed = stempList;
      }
    }
    return imageCompressed;
  }

  // 统一的网络请求
  static Future<dynamic> _request(String path, {Map<String, dynamic>? params}) async {
    var json = await DioUtil.instance.request(path, params: params, method: DioMethod.post);
    ApiBaseResponse response = ApiBaseResponse.fromJson(json);
    return response.data;
  }
}
