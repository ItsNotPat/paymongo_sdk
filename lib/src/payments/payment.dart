import '../src.dart';

extension PayMongoPayments on PayMongoClient {
  Future<String> createPayment(PaymentAttributes data,
      [int before, int after, int limit]) async {
    assert(data != null, "Data does not meet requirements");
    if (before != null) {}
    final options = PayMongoOptions(
      path: '/payments',
      data: {
        'attributes': data.toMap(),
      },
      params: {
        'before': before,
        'after': after,
        'limit': limit,
      },
    );

    final response = await post(options);

    return response;
  }

  Future<String> retreivePayment(int id) async {
    final options = PayMongoOptions(
      path: '/payments/$id',
    );

    final response = await get(options);

    return response;
  }

  Future<String> listPayments() async {
    final options = PayMongoOptions(path: '/payments');

    final response = await get(options);

    return response;
  }
}
