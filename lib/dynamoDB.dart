import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';

class Dynamo{
  static final service = DynamoDB(
      region: 'sa-east-1',
      credentials: AwsClientCredentials(
        secretKey: '49nZMjPhXezkGqyzdc80SCXMXYmmwnESwriXFMJd',
        accessKey: 'AKIAQ3HQPWGHROZLBX37',
      ));
  static Future<Map<String, AttributeValue>> getItem(String ticker) async {
    GetItemOutput aux = await service.getItem(
        key: {
          "ticker" : AttributeValue(
            s: ticker,
          )
        },
        tableName: "Stock"
    );
    var map = aux.item as Map<String, AttributeValue>;
    return map;
  }
}