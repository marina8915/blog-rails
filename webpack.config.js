const webpack = require("webpack");

module.exports = {
    context: __dirname + "/app/javascript/packs",

    entry: {
        application: ["application.js"],
    },

    output: {
        path: __dirname + "/public/packs",
    },
};
