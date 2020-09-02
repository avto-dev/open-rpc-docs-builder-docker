import React from 'react';
import ReactDOM from 'react-dom';
import Documentation from "@open-rpc/docs-react";
import {parseOpenRPCDocument} from "@open-rpc/schema-utils-js";
import schema from './schema/openrpc.json';
import {OpenrpcDocument as OpenRPC} from "@open-rpc/meta-schema";
import {MuiThemeProvider} from "@material-ui/core/styles";
import {CssBaseline} from "@material-ui/core";
import {darkTheme, lightTheme} from "./themes/openrpcTheme";



const theme = process.env.REACT_APP_THEME === "dark" ? darkTheme : lightTheme;

const reactJsonOptions = {
    theme: process.env.REACT_APP_THEME === "dark" ? "summerfruit" : "summerfruit:inverted"
};

parseOpenRPCDocument(schema as OpenRPC).then(rpcSchema => {
    document.title = rpcSchema.info.title;
    ReactDOM.render(
        <MuiThemeProvider theme={theme}>
            <CssBaseline />
            <Documentation schema={rpcSchema} reactJsonOptions={reactJsonOptions} />
        </MuiThemeProvider>
        , document.getElementById("root"));
}).catch(error => {
    console.log(error);
});
