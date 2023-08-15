// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quil_toolbar_visibibility_cubit.dart';

class QuilToolbarVisibibilityState extends Equatable {
  const QuilToolbarVisibibilityState({
    this.isKeyboardVisibile = false,
  });
  final bool isKeyboardVisibile;
  @override
  List<Object> get props => [isKeyboardVisibile];
}
