ballerina grpc --mode service --input protofiles/unary.proto --output src/unary_server
ballerina grpc --mode client --input protofiles/unary.proto --output src/unary_client