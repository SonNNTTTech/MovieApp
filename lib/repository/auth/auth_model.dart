class CreateRequestTokenResponse {
  bool? success;
  String? expiresAt;
  String? requestToken;

  CreateRequestTokenResponse({this.success, this.expiresAt, this.requestToken});

  CreateRequestTokenResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    expiresAt = json['expires_at'];
    requestToken = json['request_token'];
  }
}

class CreateSessionIdResponse {
  bool? success;
  String? sessionId;

  CreateSessionIdResponse({this.success, this.sessionId});

  CreateSessionIdResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    sessionId = json['session_id'];
  }
}

class CreateGuestSessionResponse {
  bool? success;
  String? guestSessionId;

  CreateGuestSessionResponse({this.success, this.guestSessionId});

  CreateGuestSessionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    guestSessionId = json['guest_session_id'];
  }
}
