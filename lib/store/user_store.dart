import 'package:clock_hacks_book_reading/models/user_model.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  User? currentUser;

  @observable
  bool isLoggedIn = false;

  UserStoreBase() {
    isLoggedIn = false;
    currentUser = null;
  }

  @action
  login(User user) {
    currentUser = user;
    isLoggedIn = true;
  }

  @action
  logout() {
    currentUser = null;
    isLoggedIn = false;
  }

  @action
  setUserProfileData(int booksCompleted, int booksPending, int booksCanceled) {
    if (currentUser == null) {
      return;
    }

    currentUser?.booksPending = booksPending;
    currentUser?.booksCompleted = booksCompleted;
    currentUser?.booksCanceled = booksCanceled;

    currentUser = User.fromUser(currentUser!);
  }
}
