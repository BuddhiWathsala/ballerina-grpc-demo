import ballerina/grpc;
import ballerina/io;

boolean isCompleted = false;
public function main (string... args) {

    TravelGuideClient ep = new("http://localhost:9091");
    grpc:Error? result = ep->GetRoute(TravelGuideMessageListener);
    if (result is grpc:Error) {
        io:println("Error from Connector: " + result.message());
    } else {
        io:println("Connected successfully");
    }

    while (!isCompleted) {}
    io:println("Client got response successfully.");
}

service TravelGuideMessageListener = service {

    resource function onMessage(Location location) {
        io:println("Response received from server: " + location.name);
    }

    resource function onError(error err) {
        io:println("Error from Connector: " + err.message());
    }

    resource function onComplete() {
        isCompleted = true;
        io:println("Server Complete Sending Responses.");
    }
};

