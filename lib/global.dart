String? loggedInUserId;

void setLoggedInUserId(String userId) {
  loggedInUserId = userId;
}

void clearLoggedUserIn() {
  loggedInUserId = null;
}

String? getLoggedInUserId() {
  return loggedInUserId;
}