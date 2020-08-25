import ballerina/grpc;
import ballerina/log;
import ballerina/io;

public function main (string... args) {
    TravelGuideBlockingClient blockingEp = new("http://localhost:9090");

    var response = blockingEp->GetFinalDestination();
    if (response is grpc:Error) {
        log:printInfo("Error from Connector: " + response.message());
    } else {
        Location result;
        grpc:Headers resHeaders;
        [result, resHeaders] = response;
        io:println("Client Got Response : ");
        io:println(result);
    }
}


