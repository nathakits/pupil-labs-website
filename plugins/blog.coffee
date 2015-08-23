# credit: https://github.com/acdlite/andrewphilipclark.com/blob/master/plugins/blog.coffee

module.exports = (env, callback) ->

  defaults =
    postsDir: 'articles' # directory containing blog posts
    template: 'article.jade'
    filenameTemplate: '/blog/:year-:month/:title/index.html'

  # assign defaults for any option not set in the config file
  options = env.config.blog or {}
  for key, value of defaults
    options[key] ?= defaults[key]

  class BlogPostsPages extends env.plugins.MarkdownPage
    ### DRYer subclass of MarkdownPage ###

    getTemplate: ->
      @metadata.template or options.template or super()

    getFilenameTemplate: ->
      @metadata.filenameTemplate or options.filenameTemplate or super()

  # register the plugin
  prefix = if options.postsDir then options.postsDir + '/' else ''
  env.registerContentPlugin 'posts', prefix + '**/*.*(markdown|mkd|md)', BlogPostsPages

  # done!
  callback()