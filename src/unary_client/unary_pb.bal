import ballerina/grpc;

public type TravelGuideBlockingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function GetFinalDestination(grpc:Headers? headers = ()) returns ([Location, grpc:Headers]|grpc:Error) {
        Empty req = {};
        var payload = check self.grpcClient->blockingExecute("TravelGuide/GetFinalDestination", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<Location>result, resHeaders];
        
    }

};

public type TravelGuideClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function GetFinalDestination(service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        Empty req = {};
        return self.grpcClient->nonBlockingExecute("TravelGuide/GetFinalDestination", req, msgListener, headers);
    }

};

public type Empty record {|
    
|};


public type Location record {|
    string name = "";
    int latitude = 0;
    int longitude = 0;
    
|};



const string ROOT_DESCRIPTOR = "0A0B756E6172792E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22580A084C6F636174696F6E12120A046E616D6518012001280952046E616D65121A0A086C6174697475646518022001280552086C61746974756465121C0A096C6F6E67697475646518032001280552096C6F6E67697475646532470A0B54726176656C477569646512380A1347657446696E616C44657374696E6174696F6E12162E676F6F676C652E70726F746F6275662E456D7074791A092E4C6F636174696F6E620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "unary.proto":"0A0B756E6172792E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22580A084C6F636174696F6E12120A046E616D6518012001280952046E616D65121A0A086C6174697475646518022001280552086C61746974756465121C0A096C6F6E67697475646518032001280552096C6F6E67697475646532470A0B54726176656C477569646512380A1347657446696E616C44657374696E6174696F6E12162E676F6F676C652E70726F746F6275662E456D7074791A092E4C6F636174696F6E620670726F746F33",
        "google/protobuf/empty.proto":"0A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942760A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A276769746875622E636F6D2F676F6C616E672F70726F746F6275662F7074797065732F656D707479F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
        
    };
}

