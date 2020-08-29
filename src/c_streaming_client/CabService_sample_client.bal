import ballerina/grpc;
import ballerina/io;

boolean isCompleted = false;
public function main (string... args) {

    CabServiceClient endpoint = new("http://localhost:9092");

    grpc:StreamingClient streamingClient;
    var res = endpoint->sendCurrentLocation(CabServiceMessageListener);

    if (res is grpc:Error) {
        io:println("Error from Connector: " + res.message());
        return;
    } else {
        io:println("Initialized connection sucessfully.");
        streamingClient = res;
    }
    
    Location[] route = [
            {name: "Palace Hotel", latitude: 82, longitude: 90},
            {name: "City College", latitude: 71, longitude: 82},
            {name: "VSA Market", latitude: 70, longitude: 62}
        ];
    foreach Location location in route {
        grpc:Error? connErr = streamingClient->send(location);
        if (connErr is grpc:Error) {
            io:println("Error from Connector: " + connErr.message());
        } else {
            io:println("Sent location: " + location.name);
        }
    }

    grpc:Error? result = streamingClient->complete();
    if (result is grpc:Error) {
        io:println("Error in sending complete message", result);
    }

    while (!isCompleted) {}
    io:println("Completed successfully");

}

service CabServiceMessageListener = service {

    resource function onMessage(Location location) {
        isCompleted = true;
        io:println("Response received from server: " + location.name);
    }

    resource function onError(error err) {
        io:println("Error reported from server: " + err.message());
    }

    resource function onComplete() {
        isCompleted = true;
        io:println("Server completed sending responses.");
    }
};

