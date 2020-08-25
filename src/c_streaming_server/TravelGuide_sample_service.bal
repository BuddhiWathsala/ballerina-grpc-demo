import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9092);

service TravelGuide on ep {

    resource function SendRoute(grpc:Caller caller, stream<Location,error> clientStream) {
        log:printInfo("Client connected sucessfully.");
        error? e = clientStream.forEach(function(Location location) {
            log:printInfo("Server received greet: " + location.name);
        });

        if (e is grpc:EOS) {
            grpc:Error? err = caller->send("Ack");
            if (err is grpc:Error) {
                log:printError("Error from Connector: " + err.message());
            }

            grpc:Error? result = caller->complete();
            if (result is grpc:Error) {
                log:printError("Error in sending completed notification to caller", err = result);
            } else {
                log:printInfo("Server completed");
            }

        } else if (e is error) {
            log:printError("Error from Connector: " + e.message());
        }
    }
}

public type Empty record {|
    
|};

public type Location record {|
    string name = "";
    int latitude = 0;
    int longitude = 0;
    
|};



const string ROOT_DESCRIPTOR = "0A11635F73747265616D696E672E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22580A084C6F636174696F6E12120A046E616D6518012001280952046E616D65121A0A086C6174697475646518022001280552086C61746974756465121C0A096C6F6E67697475646518032001280552096C6F6E676974756465323F0A0B54726176656C477569646512300A0953656E64526F75746512092E4C6F636174696F6E1A162E676F6F676C652E70726F746F6275662E456D7074792801620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "c_streaming.proto":"0A11635F73747265616D696E672E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22580A084C6F636174696F6E12120A046E616D6518012001280952046E616D65121A0A086C6174697475646518022001280552086C61746974756465121C0A096C6F6E67697475646518032001280552096C6F6E676974756465323F0A0B54726176656C477569646512300A0953656E64526F75746512092E4C6F636174696F6E1A162E676F6F676C652E70726F746F6275662E456D7074792801620670726F746F33",
        "google/protobuf/empty.proto":"0A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942760A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A276769746875622E636F6D2F676F6C616E672F70726F746F6275662F7074797065732F656D707479F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
        
    };
}

