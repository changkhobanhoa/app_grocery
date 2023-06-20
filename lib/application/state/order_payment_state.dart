import 'package:freezed_annotation/freezed_annotation.dart';
import '/models/order_payment.dart';

part 'order_payment_state.freezed.dart';

@freezed
class OrderPaymentState with _$OrderPaymentState {
  factory OrderPaymentState({
    OrderPayment? orderPaymentResponseModel,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default("") String message,
  }) = _OrderPaymentState;
}