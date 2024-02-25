
import 'package:fpdart/fpdart.dart';
import 'package:waste_company/api/core/api_failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = Future<Either<Failure, void>>;