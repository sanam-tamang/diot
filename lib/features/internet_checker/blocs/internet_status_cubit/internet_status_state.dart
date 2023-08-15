// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_status_cubit.dart';

 class InternetStatusState extends Equatable {
  const InternetStatusState(
   {required this.status}
  );
  final InternetState status;
  @override
  List<Object> get props => [status];
}
