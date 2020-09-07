import ballerina/grpc;
import ballerina/io;

public function main(string... args) {

    CabServiceClient ep = new ("http://localhost:9091");

    CabDetails cab = {
        cabNumber: "AB002"
    };
    grpc:Error? result = ep->getCurrentLocation(cab, CabServiceMessageListener);
    if (result is grpc:Error) {
        io:println("Error from Connector: " + result.message());
    } else {
        io:println("Connected successfully");
    }

}

service CabServiceMessageListener = service {

    resource function onMessage(Location location) {
        io:println("Response received from server: " + location.name);
    }

    resource function onError(error err) {
        io:println("Error from Connector: " + err.message());
    }

    resource function onComplete() {
        io:println("Server Complete Sending Responses.");
    }
};

