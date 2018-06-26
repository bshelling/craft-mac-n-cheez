const path = require('path');
const ExtractText = require('extract-text-webpack-plugin');


module.exports = {
    
    module:{
        rules:[
            {
                test: /\.sass$|\.scss$/,
                loader: ExtractText.extract({
                    fallback: 'style-loader',
                    use: ['css-loader','sass-loader']
                }) 
            }
        ]
    },
    plugins:[
      new ExtractText('../../assets/css/style.css')
    ],
    entry: './index.js',
    mode: 'development'


};