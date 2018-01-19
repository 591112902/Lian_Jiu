


//全部--测试:
#define API_DOMAIN  @"http://101.132.38.30:8085"
//订单系统-
#define API_ORDER  @"http://101.132.38.30:8084"
//登录系统-
#define DENGLU_API  @"http://101.132.38.30:8083"
//图片上传--多图
#define MULTIPIC  @"http://101.132.38.30:8081"
//支付相关
#define API_PAY  @"http://101.132.38.30:8086"





////全部--测试:
//#define API_DOMAIN  @"https://rest.lianjiuhuishou.com"
////订单系统-
//#define API_ORDER  @"https://orders.lianjiuhuishou.com"
////登录系统-
//#define DENGLU_API  @"https://sso.lianjiuhuishou.com"
////图片上传--多图
//#define MULTIPIC  @"https://upload.lianjiuhuishou.com"
////支付相关
//#define API_PAY  @"https://payment.lianjiuhuishou.com"












//大宗交易-首页
#define PRODUCTBULK API_DOMAIN@"/rest/index/productBulk"
//大宗交易-首页跳至搜索页面调用---搜索-如果不传入，搜索所有
#define BULKSEARCH API_DOMAIN@"/rest/bulk/search"
//大宗交易-修改数量
#define SETBULKITEMCART API_DOMAIN@"/rest/bulk/setBulkItemCart"
//大宗交易-获取制定的清单
#define GETBULKITEMCART API_DOMAIN@"/rest/bulk/getBulkItemCart"
//大宗交易-提交大宗单
#define BULKSUBMIT API_ORDER@"/orders/orderBulk/submit"
//大宗交易-订单展示
#define B_GETORDERSBYUSERSTATUS API_ORDER@"/orders/orderBulk/getOrdersByUserStatus"
//大宗交易-确认清单
#define B_ORDERSPREVIEW API_ORDER@"/orders/orderBulk/ordersPreview"
//大宗交易-订单取消
#define B_ORDERSCANCEL API_ORDER@"/orders/orderBulk/cancel"
//大宗交易-订单确认
#define B_ORDERSAGREE API_ORDER@"/orders/orderBulk/agree"
//大宗交易-获取订单详情
#define B_ORDERSDETAILS API_ORDER@"/orders/orderBulk/ordersDetails"

//大宗交易-获取大宗回收仓库地址
#define B_GETBULKADDRESS MULTIPIC@"/bulk/getBulkAddress"












// 加单结算
#define SUBMITFACe API_ORDER@"/orders/orderFaceface/submitFace"

//: 质检明细-少
#define ZJMXJIEKOU API_DOMAIN@"/rest/allianceBusiness/selectProduct"

// 链旧退出登陆
#define LJLOGINOUT DENGLU_API@"/user/loginOut"

// qq微信登录授权状态
#define QWLOGIN DENGLU_API@"/user/QWLogin"

// 绑定手机获取验证码
#define SENDSMSBYBINGDING DENGLU_API@"/user/sendSmsByBinding"

// qq微信绑定手机号
#define CREATEUSER DENGLU_API@"/user/CreateUser"


// 退款退货
#define ORDERSREFUNDGOODJP API_ORDER@"/orders/ordersExcellent/ordersExcellentRefundGoods"

//  仅退款
#define ORDERSREFUNDJP API_ORDER@"/orders/ordersExcellent/ordersExcellentRefund"


// 修改订单状态（
#define REPAIRMODIFYSTATUS API_ORDER@"/orderRepair/modifyStatus"





//  图片上传 多张
#define LOADIMGLJ MULTIPIC@"/pic/upload/multi/list"

// 查看回收车
#define SELECTPRODUCTFROM API_DOMAIN@"/rest/product/selectProductFromCar"
// 查询默认地址
#define CHOOSEADDRESSDEFULT API_DOMAIN@"/rest/user/chooseAddressDefult"

//二手精品-首页轮播图
#define SELECTCARAROUSE  API_DOMAIN@"/rest/ad/selectCararouseFourType"
//二手精品-品牌墙
#define GETBRANDS  API_DOMAIN@"/rest/excellent/getBrands"
//二手精品- 热门精品
#define SELECTADESSENCEHOTFOUR  API_DOMAIN@"/rest/ad/selectAdEssenceHotFour"
//二手精品-精品详情
#define GETEXCELLENT  API_DOMAIN@"/rest/excellent/getExcellent"
//二手精品-获取当前产品的评价
#define GETCOMMENT  API_DOMAIN@"/rest/comment/getComment"
//二手精品-立即购买点击后
#define SELECTADDRESSDEFAULT  API_ORDER@"/orders/ordersExcellent/selectAddressDefault"
//二手精品-查询地址，根据用户根据
#define CHOOSEADRESS  API_DOMAIN@"/rest/user/chooseAdress"


//二手精品-精品订单查看一个产品的
#define EXCELLENTGETONECOMMENT  API_ORDER@"/orders/ordersExcellent/getOneComment"








// 订单提交-手机维修
#define WXSUBMITT  API_ORDER@"/orders/orderRepair/submit"


//二手精品- 修改为默认地址
#define SETDEFAULT  API_DOMAIN@"/rest/user/setDefault"
//二手精品- 用户地址更新--编辑时的保存
#define MODIFYADRESS API_DOMAIN@"/rest/user/modifyAdress/toUser"
//二手精品- 用户地址删除--编辑时的删除
#define DELETEADRESS API_DOMAIN@"/rest/user/deleteAdress"
//二手精品- 用户地址增加--添加新地址时的保存
#define ADDADRESS API_DOMAIN@"/rest/user/addAdress/toUser"
//二手精品- 根据订单的状态获取订单。分页
#define ORDERSEXCELLENT API_DOMAIN@"/rest/ordersExcellent/getExcellent"
//二手精品- 提交订单
#define SUBMITEXCELLENT API_ORDER@"/orders/ordersExcellent/submit"
//提交上门回收订单
#define SUBMITFACEFACE API_ORDER@"/orders/orderFaceface/submit"
//产品评价提交
#define SUBMITCOMMENT API_DOMAIN@"/rest/comment/submitComment"
//: 确认收货，订单完成
#define JJPFINISH API_ORDER@"/orders/ordersExcellent/finish"


//: 精品订单状态更新--
#define MODIFYEXELLENTSTATE API_ORDER@"/orders/ordersExcellent/modifyExcellentState"



//根据条件过滤出产品
#define LJFILTERS API_DOMAIN@"/rest/excellent/getProductByFilters"
//二手精品-  付款
#define ORDERSEXCELLENTPAY API_ORDER@"/orders/ordersExcellent/ordersExcellentPay"

//二手精品-  付款===验证码验证
#define WALLETCHCEK API_ORDER@"/orders/wallet/checkSms/check"


//查询订单中所有产品详情页-快递
#define SELECTORDERDETAILSKD API_ORDER@"/orders/orderExpress/selectOrderDetails"
//查询订单中所有产品详情页-上门
#define SELECTORDERDETAILSSM API_ORDER@"/orders/orderFaceface/selectOrderDetails"








//二手精品-  通过品牌名称获取产品
#define GETPRODUCTBYBRAND API_DOMAIN@"/rest/excellent/getProductByBrand"
//登录系统-登录
#define LOGIN DENGLU_API@"/user/login"
//登录系统-验证码登录
#define SMSLOGIN DENGLU_API@"/user/sMsLogin"
//登录系统-获取验证码
#define SENDSMS DENGLU_API@"/user/sendSms"


//登录系统-wangjimima忘记密码-获取验证码
#define FORGETPWDSMS DENGLU_API@"/user/forgetPwdSms"




#define SENDNEWPHONE DENGLU_API@"/user/sendNewPhone"

//登录系统-获取验证码
#define SENDSMSLOGIN DENGLU_API@"/user/sendSmsLogin"





//商品支付时获取验证码
#define WALLETSENDSMS API_ORDER@"/orders/wallet/sendSms"


//SENDSMSPWD-获取验证码
#define SENDSMSPWD DENGLU_API@"/user/sendSMSPwd"
//提现时获取验证码
#define TXSENDSMS API_ORDER@"/orders/wallet/withdrawals/sendSms"
//提现验证验证码
#define TXCHECKWSMS API_ORDER@"/orders/wallet/withdrawals/checkWsms"
//tx-获取验证码
#define BDYHKSENDSMS API_DOMAIN@"/rest/user/sendSms/bankCard"
//登录系统-获取验证码
#define SENDSMSPHONE DENGLU_API@"/user/sendSmsPhone"
//登录系统-忘记密码（更新密码）
#define UPDATEPWD DENGLU_API@"/user/updatePwd"
//获取用户基本信息
#define SELECTASSET API_DOMAIN@"/rest/user/selectAsset"
//登录系统-设置密码
#define MODIFYPWD DENGLU_API@"/user/modifyPwd"
//卖家电---==首页
#define PRODUCTHOUSEHOLD API_DOMAIN@"/rest/index/productHousehold"
//卖家电---==首页
#define GETBRANDBYCID API_DOMAIN@"/rest/product/getBrandBycId"
//卖家电---==首页
#define BRANDSWITCH API_DOMAIN@"/rest/product/brandSwitch"
//卖家电---==首页
#define GETBYPRODUCTCATEGORYID API_DOMAIN@"/rest/product/getByProductCategoryId"
//卖家电---==首页
#define SELECTPRODUCT API_DOMAIN@"/rest/product/selectProduct"
//卖废品---==首页
#define PRODUCTWASTE API_DOMAIN@"/rest/index/productWaste"
//卖废品---==首页
#define GETWASTE API_DOMAIN@"/rest/waste/getWaste"
//卖废品---==首页
#define GETWASTEDETAILS API_DOMAIN@"/rest/waste/getWasteDetails"

#define LIANJIU API_DOMAIN@"/rest/index/lianjiu"

#define PRODUCTREPAIR API_DOMAIN@"/rest/index/productRepair"

#define GETREPAIR API_DOMAIN@"/rest/repair/getRepair"

#define GETPARAMTEMPLATE API_DOMAIN@"/rest/repair/getParamTemplate"

#define SUBMIT API_ORDER@"/orders/orderRepair/submit"

#define GETREPAIRBYSTATUSARR API_ORDER@"/orders/orderRepair/getRepairByStatusArr"

#define SELECTASSETDETAILS API_DOMAIN@"/rest/user/selectAssetDetails"

#define CATEGORYFILTER API_DOMAIN@"/rest/excellent/categoryFilter"

#define BRANDFILTER API_DOMAIN@"/rest/excellent/BrandFilter"

#define MODIFYUSERBANKCARD API_DOMAIN@"/rest/user/modifyUserbankCard"

#define SUBCERTIFICATION API_DOMAIN@"/rest/user/subCertification/id=123"
//卖手机
#define PRODUCTELECTRONIC API_DOMAIN@"/rest/index/productElectronic"
//卖手机--点击上面的...
#define ELECTRONICSWITCH API_DOMAIN@"/rest/product/electronicSwitch"

//卖手机--点击左边的...
#define BRANDSWITCH API_DOMAIN@"/rest/product/brandSwitch"
//接口名称: 质检报告(171122改)手机
#define QUALITYCHECKINGDETAILS API_ORDER@"/orders/orderExpress/qualityCheckingDetails"
//卖手机--点击左边的...右边2个
#define YOUBRANDSWITCH API_DOMAIN@"/rest/product/categorySwitch"

#define IMMEDIATELY API_DOMAIN@"/rest/product/calculationImmediately"
#define JDIMMEDIATELY API_DOMAIN@"/rest/product/calculationJDImmediately"

//评估后..
#define CALCULATIONPRICE API_DOMAIN@"/rest/product/calculationPrice"
//#define CALCULATIOJDNPRICE API_DOMAIN@"/rest/product/calculationJDPrice"



#define GETCOMMENTBYRELATIVEID API_DOMAIN@"/rest/comment/getAllComment"

#define SELECTPRODUCTFROMCAR API_DOMAIN@"/rest/product/selectProductFromCar"


#define ADDTOEXPRESSPRODUCTCAR API_DOMAIN@"/rest/product/addToExpressProductCar"//手机

#define INTRODUCTIONPRDUCT API_DOMAIN@"/rest/product/introductionProduct"//卖家电

//直接上门回收（171031改）
#define DIRECTSUBMIT API_ORDER@"/orders/orderFaceface/directSubmit"

//立即卖掉（171031改）
#define DIRECTEXPRESSSALE API_ORDER@"/orders/orderExpress/directExpressSale"

//立即卖掉（171031改）
#define DIRECTSUBWASTE API_ORDER@"/orders/orderFaceface/directSubmitWaste"

//获取图片-提现
#define TXWXCASHCODE API_PAY@"/payment/transferController/wxCashCode"
//验证验证码
#define TXWXPAYCHECKCODE API_PAY@"/payment/transferController/wxpayCheckCode"
//确认提现
#define TXPAYOTHER API_PAY@"/payment/transferController/payOther"



#define ZRSelectProduct API_DOMAIN@"/rest/product/selectProduct"

#define GETEXPRESSSTUTSLIST API_ORDER@"/orders/orderExpress/getExpressStutsList"
//上门-结算
#define BALANCE API_ORDER@"/orders/orderFaceface/balance"


//快递结算
#define PRODUCTBALANCE API_ORDER@"/orders/orderExpress/productBalance"

//提交订单(
#define ORSUBMIT API_ORDER@"/orders/orderExpress/submit"

//提交订单-获取验证码
#define SENDEXPRESSORDERAMS API_DOMAIN@"/rest/product/sendExpressOrderSMS"

#define ADDEXPRESSSNUM API_ORDER@"/orders/orderExpress/addExpresssNum"

#define INTRODUCTIONWASTE API_DOMAIN@"/rest/waste/introductionWaste"
//用户加单进加单车
#define ADDWASTE API_ORDER@"/orders/orderFaceface/addWaste"

//回收的评价提交
#define SUBMITCOMMENT API_DOMAIN@"/rest/comment/submitComment"

//确认价格
#define MODIFYVISITPRICE API_ORDER@"/orders/orderFaceface/modifyVisitPrice"





//确认价格SHOU JI
#define PRICECONFIRM API_ORDER@"/orders/orderExpress/priceConfirm"


//不卖了SHOU JI
#define BMLPRICEREFUSE API_ORDER@"/orders/orderExpress/priceRefuse"



//查询订单中所有产品详情页

#define SELECTORDERDETAILS API_ORDER@"/orders/orderFaceface/selectOrderDetails"





//取消订单
#define SMKDCANCEL API_ORDER@"/orders/orderExpress/cancel"


//取消jiage订单
#define SMKDPRICEREFUSE API_ORDER@"/orders/orderFaceface/priceRefuse"







// 企业订单提交 企业订单提交
#define ADDCOMPANY API_ORDER@"/orders/orderCompany/addCompany"
//接口名称: 加盟商申请信息添加
#define APPLICATION API_DOMAIN@"/rest/allianceBusiness/application"


//用户各种订单运行状态查询
#define GETHOMEVISTSTUTSLIST API_ORDER@"/orders/orderFaceface/getHomeVistStutsList"


//用户各种订单运行状态查询
#define GETHOMEVISTSTUTSLIST API_ORDER@"/orders/orderFaceface/getHomeVistStutsList"


//查询加单车的内容
#define GETWASTECARC API_ORDER@"/orders/orderFaceface/getWasteCar"



//删除加单车的内容
#define DELETEWASTECAR API_ORDER@"/orders/orderFaceface/deleteWasteCar"

//从回收车中删除商品-shagnmen
#define FACEDELETECAR API_ORDER@"/orders/orderFaceface/reduceProductFromCar"



//从回收车中删除商品-kuaidi
#define EXPRESSDELETECAR API_ORDER@"/orders/orderExpress/reduceProductFromCar"


// 二手精品里面的搜索商品
#define SEARCHQUERYEXCELLENT API_DOMAIN@"/rest/search/queryExcellent"


//搜索商品
#define SEARCHQUERY API_DOMAIN@"/rest/search/query"
//热门活动
#define GETACTIVITY API_DOMAIN@"/rest/user/getActivity"
//优惠券
#define GETCOUPONLIST API_DOMAIN@"/rest/user/getCouponList"
//判断用户是否设置了密码
#define ISPWD DENGLU_API@"/user/isPwd"


//: 用户修改密码
#define CHANGEPWD DENGLU_API@"/user/changePwd"

//:接口名称: 用户原手机校验验证码
#define PHONECHECK DENGLU_API@"/user/phoneCheck"
//接口名称: 用户校验原手机号码并发送验证码
#define SENDSMSPHONE DENGLU_API@"/user/sendSmsPhone"

//用户修改电话号码
#define PHONECHANGE DENGLU_API@"/user/phoneChange"
//马上估价之后
#define CALCULATIONJDPRICE API_DOMAIN@"/rest/product/calculationJDPrice"
//质检明细jiadian家电
#define FACEQUALITYCHECKINGDETAILS API_ORDER@"/orders/orderFaceface/qualityCheckingDetails"

#define ALIPAYAPP  API_ORDER@"/orders/alipayApp/iosPaymentJP"

//微信app支付
#define WXPAYAPP API_ORDER@"/orders/weixinWeb/wxpayapp"

//微信app支付JP
#define WXPAYAPPJP API_ORDER@"/orders/weixinWeb/wxpayappJP"

// 校验是否实名认证
#define ISCERTIFICATION API_DOMAIN@"/rest/user/isCertification"

// 校验是否绑定银行卡
#define ISUSERBANKCARD API_DOMAIN@"/rest/user/isUserbankCard"

// 更新绑定银行卡
#define UPDATEUSERBANKCARD API_DOMAIN@"/rest/user/updateUserbankCard"

// 删除绑定银行卡
#define REMOVEUSERBANKCARD API_DOMAIN@"/rest/user/removeUserbankCard"




////微信支现
//#define WXPANCODE API_PAY@"/payment/transferController/payOther"
//// 微信支现验证
//#define WXPAYCHECK API_PAY@"/payment/transferController/wxpayCheck"
//





//银行卡支现
#define LJINSERT API_ORDER@"/orders/unionpay/insert"


//取消
#define MODIFYEXPRESSORDERSTATUS API_ORDER@"/orders/orderExpress/cancel"


//退款退货，上传运单号
#define ORDERSEXCELLENTREFUNDEXP API_ORDER@"/orders/ordersExcellent/ordersExcellentRefundExp"
































//progress:^(NSProgress * _Nonnull uploadProgress)

typedef void (^progressBack)(NSProgress *  uploadProgress);
typedef void (^callBack)(NSMutableDictionary *dic);
typedef void (^errorBack)(NSError *error);
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface networking : NSObject
// 带进度上传多张图片 不同参数名

+ (void)AFNPOSTMutableArrfile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName dataSource:(NSArray *)datadic success:(callBack )callBack progress:(progressBack )progressBack  error:(errorBack)errorBack HUDAddView:(UIView*)view;


//GET
+ (void)AFNRequest:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
//GET 里面没有判断成功返回值
+ (void)AFNRequestNotCode:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
//POST
+ (void)AFNPOST:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
//POST 里面没有判断成功返回值
+ (void)AFNPOSTNotCode:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
//上传1图片
+ (void)AFNPOSTfile:(NSString *)url withparameters:(NSDictionary *)parameters data:(NSData *)data dataName:(NSString *)dataName success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
// 上传多张图片 不同参数名
+ (void)AFNPOSTMutableDicfile:(NSString *)url withparameters:(NSDictionary *)parameters dataSource:(NSDictionary *)datadic success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
//gaigai
+ (void)GAFNPOSTMutableArrfile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName dataSource:(NSArray *)datadic success:(callBack )callBack progress:(progressBack )progressBack  error:(errorBack)errorBack HUDAddView:(UIView*)view;

//上传多张图片 同一个参数名
+ (void)AFNPOSTMutableArrfile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName dataSource:(NSArray *)datadic success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;//9

//上传多个本地文件 同一个参数名 pahts:urls
+ (void)AFNPOSTMutableArrUrlFile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName pahts:(NSArray *)paths success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view;
//GET 没有HUDView
+ (void)AFNRequestNotHUD:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack;
//POST 没有HUDView
+ (void)AFNPOSTNotHUD:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack;
@end
