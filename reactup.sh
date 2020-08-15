if [ "$1" = "" ]
then
  echo "Usage: $0 <project-name>"
  exit
fi

mkdir $1 && cd $1

npm init -y
npm i react react-dom

# development deps
npm i -D awesome-typescript-loader @types/react @types/react-dom html-webpack-plugin @types/html-webpack-plugin typescript webpack webpack-cli @types/webpack webpack-dev-server ts-node

# create directory structure
mkdir src && cd src && touch index.tsx && touch index.html && mkdir components && cd components && touch App.tsx && cd ../..

read -r -d '' WEBPACK_DEV_SRC << EOF
import * as webpack from "webpack";
import * as HtmlWebPackPlugin from "html-webpack-plugin";

const htmlPlugin = new HtmlWebPackPlugin({
  template: "./src/index.html"
});

const config: webpack.Configuration = {
  mode: "development",
  entry: "./src/index.tsx",
  resolve: {
    // Add '.ts' and '.tsx' as resolvable extensions.
    extensions: [".ts", ".tsx", ".js", ".json"]
  },

  module: {
    rules: [
      // All files with a '.ts' or '.tsx' extension will be handled by 'awesome-typescript-loader'.
      { test: /\.tsx?$/, loader: "awesome-typescript-loader" }
    ]
  },
  plugins: [htmlPlugin]
};

export default config;
EOF

read -r -d '' WEBPACK_PROD_SRC << EOF
import * as path from "path";
import * as webpack from "webpack";
import * as HtmlWebPackPlugin from "html-webpack-plugin";

const htmlPlugin = new HtmlWebPackPlugin({
  template: "./src/index.html",
  filename: "./index.html"
});

const config: webpack.Configuration = {
  mode: "production",
  entry: "./src/index.tsx",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js"
  },
  resolve: {
    // Add '.ts' and '.tsx' as resolvable extensions.
    extensions: [".ts", ".tsx", ".js", ".json"]
  },

  module: {
    rules: [
      // All files with a '.ts' or '.tsx' extension will be handled by 'awesome-typescript-loader'.
      { test: /\.tsx?$/, loader: "awesome-typescript-loader" }
    ]
  },
  plugins: [htmlPlugin]
};

export default config;
EOF

read -r -d '' TSCONFIG_SRC << EOF
{
	"compilerOptions": {
		"outDir": "./dist/",
		"noImplicitAny": true,
		"target": "es5",
		"lib": ["es5", "es6", "dom"],
		"jsx": "react",
		"allowJs": true,
		"moduleResolution": "node"
	}
}
EOF

read -r -d '' INDEX_HTML_SRC << EOF
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta http-equiv="X-UA-Compatible" content="ie=edge" />
		<title>React Typescript from Scratch</title>
	</head>
	<body>
		<section id="root"></section>
	</body>
</html>
EOF

read -r -d '' APP_TSX_SRC << EOF
import * as React from "react";

export interface IAppProps {}

export default function IApp(props: IAppProps) {
  return <h1>Hello React Typescript!</h1>;
}
EOF

read -r -d '' INDEX_TSX_SRC << EOF
import * as React from "react";
import * as ReactDOM from "react-dom";
import App from "./components/App";

const Index = () => {
  return <App />;
};

ReactDOM.render(<Index />, document.getElementById("root"));
EOF

read -r -d '' SCRIPTS_VALUE << EOF
"scripts": {
    "dev": "webpack-dev-server --open --config webpack.dev.ts",
    "build": "webpack --mode production --config webpack.prod.ts"
}
EOF

echo "$WEBPACK_DEV_SRC" > webpack.dev.ts
echo "$WEBPACK_PROD_SRC" > webpack.prod.ts
echo "$TSCONFIG_SRC" > tsconfig.json
echo "$INDEX_HTML_SRC" > src/index.html
echo "$APP_TSX_SRC" > src/components/App.tsx
echo "$INDEX_TSX_SRC" > src/index.tsx

echo "!!! important !!!"
echo "Add the following to your package.json , and then it's all done!"
echo "$SCRIPTS_VALUE"

echo "--- When you have edited the package.json, you can start developing ---"
printf "\n"
printf "To start dev server:\t\t npm run dev\n"
printf "To build project:\t\t npm run build\n"
printf "\n"
echo "--- Happy hacking ---"

