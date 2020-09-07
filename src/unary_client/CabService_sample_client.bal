import ballerina/grpc;
import ballerina/io;
import ballerina/log;

public function main(string... args) {

    CabServiceBlockingClient blockingEp = new ("http://localhost:9090");

    CabDetails cab = {
        cabNumber: "AB002"
    };
    var response = blockingEp->getStartLocation(cab);
    if (response is grpc:Error) {
        log:printInfo("Error from Connector: " + response.message());
    } else {
        io:println(response);
    }
}


