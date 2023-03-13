import 'package:mockito/annotations.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

@GenerateMocks(<Type>[
  GlobalCubit,
])
void main() {}

void globalSetup() {
  // when(mockSqlDb.readData(tableName ?? 'supaccountslist')).thenAnswer(
  //     (Invocation realInvocation) async => <Map<String, dynamic>>[]);
  // when(mockSqlDb.insertData()).thenAnswer((Invocation realInvocation) async {});
  // when(mockSqlDb.deleteDatabase())
  //     .thenAnswer((Invocation realInvocation) async {});
}
