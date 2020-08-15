# react-up
> Single bash script to create a `React` project with `Typescript`.

## Usage
> To generate a project, simply execute the script with these arguments:
```
./reactup.sh <project-name>
```
> When it's all done, you will be prompted to do **one** single manual step:
```
Add the following to your package.json , and then it's all done!
"scripts": {
    "dev": "webpack-dev-server --open --config webpack.dev.ts",
    "build": "webpack --mode production --config webpack.prod.ts"
}
--- When you have edited the package.json, you can start developing ---

To start dev server:		 npm run dev
To build project:		 npm run build

--- Happy hacking ---
```
