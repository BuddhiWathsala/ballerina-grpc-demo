import ballerina/grpc;
import ballerina/io;

boolean isCompleted = false;
public function main (string... args) {

    TravelGuideClient endpoint = new("http://localhost:9092");

    grpc:StreamingClient streamingClient;
    var res = endpoint->SendRoute(TravelGuideMessageListener);

    if (res is grpc:Error) {
        io:println("Error from Connector: " + res.message());
        return;
    } else {
        io:println("Initialized connection sucessfully.");
        streamingClient = res;
    }
    
    Location[] route = [
        {name: "London", latitude: 88, longitude: 100},
        {name: "Tokyo", latitude: 78, longitude: 82},
        {name: "Sydney", latitude: 40, longitude: 62}
    ];
    foreach Location location in route {
        grpc:Error? connErr = streamingClient->send(location);
        if (connErr is grpc:Error) {
            io:println("Error from Connector: " + connErr.message());
        } else {
            io:println("Send location: " + location.name);
        }
    }

    grpc:Error? result = streamingClient->complete();
    if (result is grpc:Error) {
        io:println("Error in sending complete message", result);
    }

    while (!isCompleted) {}
    io:println("Completed successfully");

}

service TravelGuideMessageListener = service {

    resource function onMessage(Location location) {
        isCompleted = true;
        io:println("Response received from server: " + location.name);
    }

    resource function onError(error err) {
        io:println("Error reported from server: " + err.message());
    }

    resource function onComplete() {
        isCompleted = true;
        io:println("Server Complete Sending Responses.");
    }
};

