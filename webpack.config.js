const { resolve } = require("path");

module.exports = {
  entry: "./src/index.ts",
  output: {
    filename: "bundle.js",
    path: resolve(__dirname, "public"),
    clean: true,
  },
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.ts$/,
        exclude: /node_module/,
        use: "ts-loader",
      },
    ],
  },
  resolve: {
    extensions: [".js", ".ts"],
  },
  devServer: {
    static: {
      directory: resolve(__dirname, ""),
    },
  },
  target: "node",
  mode: "development",
  watch: true,
  watchOptions: {
    ignored: /node_modules/,
  },
  externals: ["pg", "sqlite3", "tedious", "pg-hstore"],
};
