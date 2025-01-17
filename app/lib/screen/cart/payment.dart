import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Bootpay
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/config/bootpay_config.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/stat_item.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';

// Screen
import 'package:intergrate_cafe/screen/home/home_screen.dart';

// Provider
import 'package:intergrate_cafe/provider/cafe/total.dart';

// Util
import 'package:intergrate_cafe/util/service.dart';

class Payment extends ConsumerStatefulWidget {
  const Payment({super.key});

  @override
  ConsumerState<Payment> createState() => _PaymentState();
}

class _PaymentState extends ConsumerState<Payment> {
  Payload payload = Payload();
  late String totalPrice = '0';
  late List<Map<String, dynamic>> cafeData = [];

  String webApplicationId = '676d859731d38115ba3fca27';
  String androidApplicationId = '676d859731d38115ba3fca28';
  String iosApplicationId = '676d859731d38115ba3fca29';

  String get applicationId {
    return Bootpay().applicationId(
        webApplicationId, androidApplicationId, iosApplicationId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final state = ref.watch(totalProvider);

    final cafe = state['cafe'] ?? {};
    final menus = cafe['menus'] ?? [];
    print('cart menus >>>>> $menus');

    cafeData = List<Map<String, dynamic>>.from(menus)
        .where((menu) => (menu['qty'] != null))
        .toList();

    totalPrice = Service().formatComma(
      cafeData.fold<int>(
        0,
        (int total, dynamic item) {
          if (item['qty'] != null) {
            final price = (item['price'] as num?)?.toInt() ?? 0;
            final qty = (item['qty'] as num?)?.toInt() ?? 0;

            return total + (price * qty);
          }
          return total;
        },
      ),
    );
    bootpayReqeustDataInit();
  }

  bootpayReqeustDataInit() {
    final items = cafeData
        .map((menu) => Item(
            name: menu['name'],
            qty: menu['qty'],
            price: double.tryParse(menu['price'].toString()) ?? 0.0,
            id: menu['_id']))
        .toList();
    // Item item1 = Item();
    // item1.name = "미키 '마우스"; // 주문정보에 담길 상품명
    // item1.qty = 1; // 해당 상품의 주문 수량
    // item1.id = "ITEM_CODE_MOUSE"; // 해당 상품의 고유 키
    // item1.price = totalPrice; // 상품의 가격

    // Item item2 = Item();
    // item2.name = "키보드"; // 주문정보에 담길 상품명
    // item2.qty = 1; // 해당 상품의 주문 수량
    // item2.id = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    // item2.price = 500; // 상품의 가격
    // List<Item> itemList = [item1, item2];

    print('------- request Init applicationId : $applicationId');
    payload.webApplicationId = webApplicationId; // web application id
    payload.androidApplicationId =
        androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id

    payload.pg = '나이스페이';
    // payload.method = '네이버페이';
    // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
    payload.methods = ['card', 'kakao'];
    payload.orderName = "테스트 상품"; //결제할 상품명
    print(
        '------- request Init totalPrice : ${double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.0}');
    payload.price =
        double.tryParse(totalPrice.replaceAll(',', '')) ?? 0.0; //정기결제시 0 혹은 주석

    payload.orderId = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); //주문번호, 개발사에서 고유값으로 지정해야함

    payload.metadata = {
      "callbackParam1": "value12",
      "callbackParam2": "value34",
      "callbackParam3": "value56",
      "callbackParam4": "value78",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    // payload.items = itemList; // 상품정보 배열
    payload.items = items; // 상품정보 배열

    User user = User(); // 구매자 정보
    user.username = "사용자 이름";
    user.email = "user1234@gmail.com";
    user.area = "서울";
    user.phone = "010-4033-4678";
    user.addr = '서울시 동작구 상도로 222';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'bootpayFlutterExample';
    extra.cardQuota = '3';
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.extra = extra;
    payload.extra?.openType = "iframe";
    payload.extra?.appScheme = "bootpayFlutterExample";
  }

  //버튼클릭시 부트페이 결제요청 실행
  void goBootpayTest(BuildContext context) {
    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel Applicationb Id: $applicationId');
        print('------- onCancel: $data');
      },
      onError: (String data) {
        print('------- goBootpayTest Payload: $payload');
        print('------- onError Applicationb Id: $applicationId');
        print('------- onError: $data');
      },
      onClose: () {
        print('------- onClose');
        Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
      },
      // onCloseHardware: () {
      //   print('------- onCloseHardware');
      // },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        print('------- onConfirm: $data');
        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 비동기 승인 하고자 할 때
            checkQtyFromServer(data);
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        // checkQtyFromServer(data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        return false;
      },
      onDone: (String data) {
        print('------- onDone: $data');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print('------- initState');
    // TotalProvider의 state를 구독
    // final state = ref.watch(totalProvider);

    // // state에서 'cafe' 키의 데이터를 가져옴
    // final cafe = state['cafe'] ?? {};
    // final menus = cafe['menus'] ?? [];
    // print('cart menus >>>>> $menus');
    // // qty > 0인 메뉴 필터링
    // cafeData = List<Map<String, dynamic>>.from(menus)
    //     .where((menu) => (menu['qty'] != null))
    //     .toList();

    // // 총 금액 계산
    // totalPrice = Service().formatComma(
    //   cafeData.fold<int>(
    //     0,
    //     (int total, dynamic item) {
    //       if (item['qty'] != null) {
    //         final price = (item['price'] as num?)?.toInt() ?? 0;
    //         final qty = (item['qty'] as num?)?.toInt() ?? 0;

    //         return total + (price * qty);
    //       }

    //       return total;
    //     },
    //   ),
    // );
    // bootpayReqeustDataInit(); //결제용 데이터 init
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(totalProvider);

    // 총 주문금액 계산
    int totalAmount = 0;
    if (provider['cafe'] != null && provider['cafe']['menus'] != null) {
      totalAmount = provider['cafe']['menus'].fold(0, (sum, menu) {
        if (menu['isAdd'] == true) {
          return sum + ((menu['price'] ?? 0) * (menu['qty'] ?? 1));
        }
        return sum;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('결제하기'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 배달 주소 섹션
                    _buildSection(
                      '배달주소',
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '서울시 관악구 신림동',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '상세주소를 입력해주세요',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                    ),

                    // 주문 내역 섹션
                    _buildSection(
                      '주문내역',
                      Column(
                        children: [
                          ...provider['cafe']['menus']
                              .where((menu) => menu['isAdd'] == true)
                              .map((menu) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(menu['name']),
                                        Text(
                                          '${Service().formatComma(menu['price'] * menu['qty'])}원',
                                        ),
                                      ],
                                    ),
                                  )),
                        ],
                      ),
                    ),

                    // 결제 수단 섹션
                    _buildSection(
                      '결제수단',
                      Column(
                        children: [
                          _buildPaymentMethod('신용카드', true),
                          _buildPaymentMethod('계좌이체', false),
                          _buildPaymentMethod('휴대폰', false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 하단 결제 버튼
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 결제 처리 로직
                  goBootpayTest(context);
                  // Bootpay().requestPayment(
                  //   price: totalAmount,
                  //   itemName: '주문 내역',
                  //   userName: '홍길동',
                  //   userEmail: 'test@test.com',
                  // );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '${Service().formatComma(totalAmount)}원 결제하기',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content,
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildPaymentMethod(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Radio(
            value: isSelected,
            groupValue: true,
            onChanged: (value) {
              // TODO: 결제 수단 변경 로직
            },
          ),
          Text(title),
        ],
      ),
    );
  }
}
