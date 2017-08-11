'use strict';


module.exports = function ( { toPath } ) {

  return new ( require( 'favicons-webpack-plugin' ) )( {

    logo: toPath( './source/favicon.png' ),

    emitStats: true,

    prefix: 'favicons-[hash]/',

    statsFilename: 'favicons.json',

    // title: 'Replace',

  } );

};
