// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_all_adds_cubit.dart';

class ShowAllAddsState {
  ResponseModel<List<JobAddModel>>? jobAddsResponse;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  int? limit;
  int? page;
  bool? hasNextPage;
  ShowAllAddsState({
    this.jobAddsResponse,
    this.errorMessage,
    this.responseType,
    this.limit = 5,
    this.page = 0,
    this.hasNextPage = true,
  });

  ShowAllAddsState copyWith({
    ResponseModel<List<JobAddModel>>? jobAddsResponse,
    String? errorMessage,
    ResponseEnum? responseType,
    int? limit,
    int? page,
    bool? hasNextPage,
  }) {
    return ShowAllAddsState(
      jobAddsResponse: jobAddsResponse ?? this.jobAddsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  String toString() {
    return 'ShowAllAddsState(jobAddsResponse: $jobAddsResponse, errorMessage: $errorMessage, responseType: $responseType, limit: $limit, page: $page, hasNextPage: $hasNextPage)';
  }
}
