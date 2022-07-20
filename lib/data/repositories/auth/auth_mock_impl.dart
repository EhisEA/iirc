import 'package:faker/faker.dart';
import 'package:iirc/domain.dart';
import 'package:rxdart/subjects.dart';

class AuthMockImpl extends AuthRepository {
  static final String id = faker.guid.guid();

  static AccountModel generateAccount() =>
      AccountModel(id: id, displayName: faker.person.name(), email: faker.internet.email());

  final BehaviorSubject<String?> _authIdState$ = BehaviorSubject<String?>();

  @override
  Future<AccountModel> get account async => generateAccount();

  @override
  Stream<String?> get onAuthStateChanged => _authIdState$;

  @override
  Future<String> signIn() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    _authIdState$.add(id);
    return id;
  }

  @override
  Future<void> signOut() async => Future<void>.delayed(const Duration(seconds: 2));
}
