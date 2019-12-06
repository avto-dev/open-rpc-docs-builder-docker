import React from 'react';
import ReactDOM from 'react-dom';
import Documentation from "@open-rpc/docs-react";
import {parseOpenRPCDocument} from "@open-rpc/schema-utils-js/build/src/index-web";
import schema from './openRpc.json';

parseOpenRPCDocument(schema).then(rpcSchema => {
    ReactDOM.render(<Documentation schema={rpcSchema} />, document.getElementById("root"));
}).catch(error => {
    console.log(error);
});


