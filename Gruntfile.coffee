webpack = require 'webpack'
ExtractTextPlugin = require "extract-text-webpack-plugin"


module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    watch:
      options:
        atBegin: true
        spawn: false
      copy:
        files: [
          'src/img/**/*'
          'src/html/**/*'
        ]
        tasks: ['copy']
      less:
        files: [
          "src/less/**/*"
        ]
        tasks: ['less']

    less:
      all:
        files:
          "dist/css/settings.css": "src/less/settings.less"

    webpack:
      options:
        cache: true
        entry:
          "browseraction":"browseraction"
          "controller":"controller"
          "settings": "settings"
          "globalaccess": "globalaccess"
        output:
          path: "dist"
          filename: "[name].js"
          chunkFilename: "[id].js"
        resolve:
          extensions: ['.coffee', '.js',]
          modulesDirectories: [
            'node_modules'
            'src'
          ]
          alias:
            underscore: 'underscore/underscore'
            jquery: 'jquery/dist/jquery'
            'jquery-ui': 'jquery-ui/jquery-ui'
        module:
          loaders: [
            {test: /\.coffee$/, loaders: ['coffee-loader']}
          ]
        stats:
          colors: true
          modules: true
          reasons: true
        failOnError: false

      production:
        watch: false
        keepalive: false

      dev:
        watch: true
        keepalive: true

    uglify:
      options:
          mangle: true
      files:
        expand: true
        flatten: false
        cwd: 'dist/'
        dest: 'dist/'
        src: '**/*.js'

    copy:
      all:
        files: [
          expand: true
          cwd: 'node_modules/jquery-ui/themes/smoothness/'
          src: '**/*'
          dest: 'dist/css/jquery-ui'
        ,
          expand: true
          cwd: 'node_modules/bootstrap/dist/css/'
          src: '**/*'
          dest: 'dist/css/bootstrap'
        ,
          expand: true
          cwd: 'src/img/'
          src: '**/*'
          dest: 'dist/img'
        ,
          expand: true
          cwd: 'src/html/'
          src: '**/*'
          dest: 'dist/html'
        ]

    cssmin:
      minify:
        expand: true
        cwd: 'dist/css'
        src: ['**/*.css'],
        dest: 'dist/css'
        ext: '.css'

    compress:
      main:
        options:
          archive: 'package.zip'
        files: [
          src: 'dist/**/*'
          dest: 'dist'
        ,
          src: 'manifest.json'
        ]





  # Load grunt plugins
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-webpack'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-compress'
  # grunt.loadNpmTasks 'grunt-svgmin'

  # Define tasks.
  grunt.registerTask 'build', ['less', 'webpack:production']
  grunt.registerTask 'optimize', ['uglify', 'cssmin',]
  grunt.registerTask 'package', ['build', 'optimize', 'compress']
  grunt.registerTask 'default', ['build']
