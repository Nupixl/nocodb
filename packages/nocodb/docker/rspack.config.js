const path = require('path');
const { rspack } = require('@rspack/core');
const nodeExternals = require('webpack-node-externals');
module.exports = {
    entry: './src/run/dockerEntry.ts',
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                exclude: /node_modules/,
                loader: 'builtin:swc-loader',
                options: {
                    jsc: {
                        parser: {
                            syntax: 'typescript',
                            tsx: true,
                            decorators: true,
                            dynamicImport: true,
                        },
                        transform: {
                            legacyDecorator: true,
                            decoratorMetadata: true,
                        },
                        target: 'es2017',
                        loose: true,
                        externalHelpers: false,
                        keepClassNames: true,
                    },
                    module: {
                        type: 'commonjs',
                        strict: false,
                        strictMode: true,
                        lazy: false,
                        noInterop: false,
                    },
                },
            },
            {
                test: /\.(html|cs)$/,
                loader: 'null-loader',
            },
        ],
    },
    resolve: {
        extensions: ['.tsx', '.ts', '.js', '.json'],
        tsConfig: {
            configFile: path.resolve('tsconfig.json'),
        },
        alias: {
            'nc-gui': path.resolve(__dirname, '../../nc-gui'),
            'social-pixl-sdk': path.resolve(__dirname, '../../social-pixl-sdk'),
            '~': path.resolve(__dirname, '../src'),
        },
    },
    output: {
        path: path.resolve('./docker'),
        filename: 'main.js',
        library: 'libs',
        libraryTarget: 'umd',
        globalObject: "typeof self !== 'undefined' ? self : this",
    },
    optimization: {
        minimize: true, //Update this to true or false
        minimizer: [
            new rspack.SwcJsMinimizerRspackPlugin({
                minimizerOptions: {
                    compress: {
                        keep_classnames: true,
                    },
                    mangle: {
                      keep_classnames: true,
                    },
                },
            }),
        ],
        nodeEnv: false,
    },
    externals: [
        nodeExternals({
            modulesDir: path.resolve(__dirname, '../../../node_modules'),
            allowlist: [/social-pixl-sdk/],
        }),
        nodeExternals({
            modulesDir: path.resolve(__dirname, '../node_modules'),
            allowlist: [/social-pixl-sdk/],
        }),
        nodeExternals({
            allowlist: [/social-pixl-sdk/],
        }),
        'cloudflare:sockets',
        'better-sqlite3',
        'sqlite3',
        'tedious',
        'oracledb',
        'pg-query-stream',
        'cardinal',
        'canvas',
        'mock-aws-s3',
        'aws-sdk',
        'snappy',
        'snappy/package.json',
    ],
    plugins: [
        new rspack.EnvironmentPlugin({
            EE: true,
        }),
    ],
    target: 'node',
    node: {
        __dirname: false,
    },
};