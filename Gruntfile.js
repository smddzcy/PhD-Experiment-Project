module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        concat: {
            options: {
                banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n',
            },
            js: {
                options: {
                    separator: ';', // separator between concatenated files
                    nonull: true
                },
                src: ["src/**/*.js", "dist/**/*.coffee.js"], // all the js files in "src" folder
                dest: 'dist/main.js' // destination fie, which is "dist / this package's name . js"

            },
            css: {
                src: ["src/**/*.css", "dist/**/*.less.css"], // all the js files in "src" folder
                dest: 'dist/main.css' // destination fie, which is "dist / this package's name . js"
            }
        },

        uglify: {
            options: {
                // the banner is inserted at the top of the output
                banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
            },
            dist: {
                src: "dist/main.js",
                dest: "dist/main.min.js"
            }
        },

        jshint: {
            // define the files to lint
            files: ['Gruntfile.js', 'src/**/*.js', 'test/**/*.js'],
            // configure JSHint (documented at http://www.jshint.com/docs/)
            options: {
                // more options here if you want to override JSHint defaults
                globals: {
                    jQuery: true,
                    console: true,
                    module: true
                }
            }
        },

        coffee: {
            dist: {
                src: ['src/**/*.coffee'],
                dest: 'dist/main.coffee.js'
            }
        },

        less: {
            dist: {
                src: ['src/**/*.less'],
                dest: 'dist/main.less.css'
            }
        },

        autoprefixer: {
            dist: {
                files: {
                    'dist/main.css': 'dist/main.css'
                }
            }
        },

        cssmin: {
            dist: {
              src: ['src/**/*.css', 'dist/**/*.less.css'],
              dest: 'dist/main.min.css'
            }
        },

        watch: {
            all: {
                files: ['<%= jshint.files %>'],
                tasks: ['jshint']
            }
        },

        clean: {
            all: {
                src: ["dist/"]
            },
            build: {
                src: ["dist/**/*.coffee.js", "dist/**/*.less.css", "!dist/**/*.min.js", "!dist/**/*.min.css", ]
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-autoprefixer');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-cssmin');

    grunt.loadNpmTasks('grunt-serve');

    grunt.registerTask('default', ['jshint', 'clean:all', 'coffee', 'less', 'concat', 'autoprefixer', 'uglify', 'cssmin', 'clean:build']);

};
