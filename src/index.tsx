import React from 'react';
import ReactDOM from 'react-dom';
import Documentation from "@open-rpc/docs-react";
import {parseOpenRPCDocument} from "@open-rpc/schema-utils-js/build/src/index-web";
import schema from './openRpc.json';
import {OpenRPC} from "@open-rpc/meta-schema/build/src";

const reactJsonOptions = {
    theme: "summerfruit"
};


parseOpenRPCDocument(schema as OpenRPC).then(rpcSchema => {
    ReactDOM.render(<Documentation schema={rpcSchema} reactJsonOptions={reactJsonOptions} />, document.getElementById("root"));
}).catch(error => {
    console.log(error);
});


