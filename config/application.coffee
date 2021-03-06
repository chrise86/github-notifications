# Exports an object that defines
# all of the configuration needed by the projects'
# depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
module.exports = require(process.env["LINEMAN_MAIN"]).config.extend "application",
  # Override application configuration here. Common examples follow in the comments.

  loadNpmTasks: ["grunt-concat-sourcemap", "grunt-contrib-stylus", "grunt-bower-task"]

  removeTasks:
    common: ["concat", "less"]

  appendTasks:
    common: ["concat_sourcemap"]

  prependTasks:
    common: ["bower:install", "stylus"]

  stylus:
    compile:
      use: [require("nib")]
      src: "app/css/app.styl"
      dest: "<%= files.stylus.generatedApp %>"

  concat_sourcemap:
    options:
      sourcesContent: true
    js:
      src: [
        "<banner:meta.banner>",
        "<%= files.js.vendor %>",
        "<%= files.template.generated %>",
        "<%= files.js.app %>",
        "<%= files.coffee.generated %>"
      ]
      dest: "<%= files.js.concatenated %>"

    spec:
      src: [
        "<%= files.js.specHelpers %>",
        "<%= files.coffee.generatedSpecHelpers %>",
        "<%= files.js.spec %>",
        "<%= files.coffee.generatedSpec %>"
      ]
      dest: "<%= files.js.concatenatedSpec %>"

    css:
      src: [
        "<%= files.stylus.generatedVendor %>",
        "<%= files.css.vendor %>",
        "<%= files.stylus.generatedApp %>",
        "<%= files.css.app %>"
      ]
      dest: "<%= files.css.concatenated %>"

  watch:
    js:
      files: ["<%= files.js.vendor %>", "<%= files.js.app %>"]
      tasks: ["concat_sourcemap:js"]

    coffee:
      files: "<%= files.coffee.app %>"
      tasks: ["coffee", "concat_sourcemap:js"]

    jsSpecs:
      files: ["<%= files.js.specHelpers %>", "<%= files.js.spec %>"]
      tasks: ["concat_sourcemap:spec"]

    coffeeSpecs:
      files: ["<%= files.coffee.specHelpers %>", "<%= files.coffee.spec %>"]
      tasks: ["coffee", "concat_sourcemap:spec"]

    css:
      files: ["<%= files.css.vendor %>", "<%= files.css.app %>"]
      tasks: ["concat_sourcemap:css"]

    stylus:
      files: ["<%= files.stylus.vendor %>", "<%= files.stylus.app %>"]
      tasks: ["stylus", "concat_sourcemap:css"]

    handlebars:
      tasks: ["handlebars", "concat_sourcemap:js"]

    underscore:
      tasks: ["jst", "concat_sourcemap:js"]

  webfonts:
    dev:
      expand: true, cwd: '<%= files.webfonts.cwd %>', src: "<%= files.webfonts.src %>", dest: "generated/<%= files.webfonts.dest %>"
    dist:
      expand: true, cwd: '<%= files.webfonts.cwd %>', src: "<%= files.webfonts.src %>", dest: "dist/<%= files.webfonts.dest %>"

  bower:
    install: {  }
