gulp = 				 require('gulp')
gutil = 			 require('gulp-util')
es = 					 require('event-stream')
http = 				 require('http')
runSequence =  require('run-sequence')
sass = 				 require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
minifycss =    require('gulp-minify-css')
jshint =       require('gulp-jshint')
rename =       require('gulp-rename')
uglify =       require('gulp-uglify')
clean =        require('gulp-clean')
concat =       require('gulp-concat')
imagemin =     require('gulp-imagemin')
cache =        require('gulp-cache')
open =         require('gulp-open')
livereload =   require('gulp-livereload')
embedlr =      require('gulp-embedlr')
coffee =       require('gulp-coffee')
ecstatic =     require('ecstatic')
lr =           require('tiny-lr')

server = lr()

config =
	http_port: '3255'
	livereload_port: '35729'
	startpage: 'public/index.html'
	
	# html
	src_html: 'app/**/*.html'
	
	# styles
	src_sass: 'app/assets/styles/**/*.scss'
	dest_css: 'public/assets/styles'
	
	# scripts
	src_scripts: 'app/assets/scripts/**/*'
	src_coffee: 'app/assets/scripts/**/*.coffee'
	src_js: 'app/assets/scripts/**/*.js'
	dest_js: 'public/assets/scripts'
	dest_test: 'test'
	js_concat_target: 'main.js'
	
	# plugins
	src_plugins: 'app/assets/scripts/plugins/*.js'
	dest_plugins: 'public/assets/scripts'
	plugins_concat: 'plugins.js'
	
	# images
	src_img: 'app/assets/images/**/*.*'
	dest_img: 'public/assets/images'


# sass task
gulp.task 'styles', ->
	gulp.src(config.src_sass)
		.pipe(sass(style: 'expanded', errLogToConsole: true))
		.pipe(autoprefixer('last 2 version', 'safari 5', 'ie 7', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
		.pipe(gulp.dest(config.dest_css))
		.pipe(rename(suffix: '.min'))
		.pipe(minifycss())
		.pipe(gulp.dest(config.dest_css))
		.pipe livereload(server)


# concat & minify js
gulp.task 'scripts', ->
	# ".jshintrc" 
	es.concat(
		gulp.src(config.src_js),
		gulp.src(config.src_coffee)
			.pipe(coffee().on('error', gutil.log))
			# save compiled coffeescript to /test for unit testing
			.pipe(gulp.dest(config.dest_test))
	)
	.pipe(jshint())
	.pipe(jshint.reporter('default'))
	.pipe(concat(config.js_concat_target))
	.pipe(gulp.dest(config.dest_js))
	.pipe(rename(suffix: '.min'))
	.pipe(uglify())
	.pipe(gulp.dest(config.dest_js))
	.pipe livereload(server)


# concat & minify plugins
gulp.task 'plugins', ->
	# ".jshintrc" 
	gulp.src(config.src_plugins)
		.pipe(jshint())
		.pipe(jshint.reporter('default'))
		.pipe(concat(config.plugins_concat))
		.pipe(gulp.dest(config.dest_plugins))
		.pipe(rename(suffix: '.min'))
		.pipe(uglify())
		.pipe(gulp.dest(config.dest_js))
		.pipe livereload(server)


# minify images
gulp.task 'images', ->
	gulp.src(config.src_img)
		.pipe(imagemin())
		.pipe gulp.dest(config.dest_img)


# watch html & embed lr
gulp.task 'html', ->
	gulp.src(config.src_html)
		.pipe(embedlr())
		.pipe(gulp.dest('public/'))
		.pipe livereload(server)


# clean '.public/'
gulp.task 'clean', ->
	gulp.src(['./public/**/*.*'],
		read: true
	)
	.pipe clean()


# site launcher
gulp.task 'open', ->
	gulp.src(config.startpage)
		.pipe open(config.startpage,
		url: 'http://localhost:' + config.http_port
	)


# default task -- run 'gulp' from cli
gulp.task 'default', (callback) ->
	runSequence 'clean', [
		'plugins'
		'scripts'
		'styles'
		'images'
		'html'
	], 'open', callback
	server.listen config.livereload_port
	http.createServer(ecstatic(root: 'public/')).listen config.http_port

	gulp.watch(config.src_sass, ['styles'])._watcher.on 'all', livereload
	gulp.watch(config.src_plugins, ['plugins'])._watcher.on 'all', livereload
	gulp.watch(config.src_scripts, ['scripts'])._watcher.on 'all', livereload
	gulp.watch(config.src_html, ['html'])._watcher.on 'all', livereload
	gulp.watch(config.src_img, ['images'])._watcher.on 'all', livereload

