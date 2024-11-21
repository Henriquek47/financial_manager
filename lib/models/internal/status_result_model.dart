class StatusResult {
  final bool doNotShow;
  final bool isSuccess;
  final bool isFailure;
  final bool isWarning;
  final bool isInfo;
  final String? messageCode;

  StatusResult.doNotShow({this.messageCode, this.doNotShow = true})
      : isSuccess = true,
        isWarning = false,
        isFailure = false,
        isInfo = false;

  StatusResult.success({this.messageCode, this.doNotShow = false})
      : isSuccess = true,
        isWarning = false,
        isFailure = false,
        isInfo = false;

  StatusResult.failure({this.messageCode, this.doNotShow = false})
      : isSuccess = false,
        isWarning = false,
        isFailure = true,
        isInfo = false;

  StatusResult.warning({this.messageCode, this.doNotShow = false})
      : isSuccess = false,
        isWarning = true,
        isFailure = false,
        isInfo = false;

  StatusResult.info({this.messageCode, this.doNotShow = false})
      : isSuccess = false,
        isWarning = false,
        isFailure = false,
        isInfo = true;
}
