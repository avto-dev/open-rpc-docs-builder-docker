import React from 'react';
import ReactDOM from 'react-dom';
import Documentation from "@open-rpc/docs-react";
import {parseOpenRPCDocument} from "@open-rpc/schema-utils-js/build/src/index-web";
import schema from './schemas/openrpc.json';
import {OpenRPC} from "@open-rpc/meta-schema/build/src";
import {MuiThemeProvider} from "@material-ui/core/styles";
import {CssBaseline} from "@material-ui/core";
import {darkTheme} from "./themes/openrpcTheme";

const reactJsonOptions = {
    theme: "summerfruit"
};

parseOpenRPCDocument(schema as OpenRPC).then(rpcSchema => {
    ReactDOM.render(
        <MuiThemeProvider theme={darkTheme}>
            <CssBaseline />
            <Documentation schema={rpcSchema} reactJsonOptions={reactJsonOptions} />
        </MuiThemeProvider>
        , document.getElementById("root"));
}).catch(error => {
    console.log(error);
});


