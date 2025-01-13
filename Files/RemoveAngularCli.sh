#!/usr/bin/env bash

# Step 1: Uninstall Angular CLI
# First, uninstall Angular CLI from your project if it is installed locally

npm uninstall @angular/cli

# Step 2: Update webpack.config.js
# Ensure your webpack.config.js is configured to handle Angular files and dependencies.
echo "const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  mode: 'development', // or 'production'
  entry: './src/main.ts',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  resolve: {
    extensions: ['.ts', '.js']
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: [
          {
            loader: 'ts-loader',
            options: { configFile: 'tsconfig.app.json' }
          },
          'angular2-template-loader'
        ],
        exclude: /node_modules/
      },
      {
        test: /\.html$/,
        use: 'html-loader'
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      }
    ]
  },
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      template: './src/index.html'
    }),
    new MiniCssExtractPlugin()
  ],
  optimization: {
    minimizer: [new TerserPlugin()]
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist')
    },
    compress: true,
    port: 4200
  }
};
" > webpack.config.js

# Step 3: Update tsconfig.app.json
# Ensure your tsconfig.app.json is configured correctly for the Angular project.

echo '{
  "extends": "../tsconfig.json",
  "compilerOptions": {
    "outDir": "../out-tsc/app",
    "types": []
  },
  "files": [
    "src/main.ts",
    "src/polyfills.ts"
  ],
  "include": [
    "src/**/*.d.ts"
  ]
}' > src/tsconfig.app.json

# Step 4: Update package.json Scripts
# Update the scripts section in your package.json to use Webpack.

#'"scripts": {
#   "start": "webpack serve --config webpack.config.js --open",
#   "build": "webpack --config webpack.config.js"
# }'

# Step 5: Install Required Dependencies
# Install the necessary Webpack and Angular dependencies.
npm install --save-dev webpack webpack-cli webpack-dev-server html-webpack-plugin clean-webpack-plugin mini-css-extract-plugin terser-webpack-plugin ts-loader angular2-template-loader html-loader css-loader style-loader
npm i

# Step 6: Update Angular Project Files
# Ensure your Angular project files (main.ts, polyfills.ts, etc.) are correctly set up for Webpack.
# After completing these steps, you should be able to build and serve your Angular project using Webpack directly.

# To check if your Angular project is correctly configured to use Webpack, follow these steps:
# Build the Project: Run the build script to compile your project using Webpack.
npm run build
# Serve the Project: Start the development server to serve your project locally.
npm start
# Open the Application: After running the start script, your default web browser should open automatically. If not, open your browser and navigate to http://localhost:4200.
# Check the Console: Open the browser's developer console to check for any errors or warnings.
# Verify Output: Ensure that the application is running as expected and that all components are rendered correctly.
# By following these steps, you can verify that your Angular project is correctly configured to use Webpack.

cp -rv src/* dist/
