import 'package:dartz/dartz.dart';
import 'package:unistay/core/errors/failures.dart';

/// Base use case class following the Use Case pattern
/// [Type] is the return type of the use case
/// [Params] is the parameter type for the use case execution
abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require any parameters
abstract class NoParamsUseCase<Type> extends UseCase<Type, void> {
  const NoParamsUseCase();
}
