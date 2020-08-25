# Unary use case
ballerina grpc --mode service --input protofiles/unary.proto --output src/unary_server
ballerina grpc --mode client --input protofiles/unary.proto --output src/unary_client

# Server streaming use case
ballerina grpc --mode service --input protofiles/s_streaming.proto --output src/s_streaming_server
ballerina grpc --mode client --input protofiles/s_streaming.proto --output src/s_streaming_client