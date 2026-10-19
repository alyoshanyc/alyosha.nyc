# Builds the homepage photo stream from folders, so the maintainer only
# uploads files: assets/images/home/column-1 ... column-4 are the four desktop
# columns, each read top to bottom in natural alphanumeric order. A photo can
# also be in a gallery folder; the homepage copy is independent.
#
# Sets site.data["home_columns"] (one list of photos per column) for
# _layouts/home.html, and creates a page per photo at /photos/<name>/
# (name = column folder + file name without extension, slugified:
# column-1-01-boatman), rendering _layouts/photo.html with prev/next in the
# stream's display order: the columns interleaved row-major (col1[0],
# col2[0], col3[0], col4[0], col1[1], ...), the order narrow screens use.
module Alyosha
  class PhotoPage < Jekyll::Page
    def initialize(site, slug, data)
      @site = site
      @base = site.source
      @dir = File.join("photos", slug)
      @basename = "index"
      @ext = ".html"
      @name = "index.html"
      @data = data
    end
  end

  class HomePageGenerator < Jekyll::Generator
    safe true
    priority :low

    COLUMNS = 4

    def generate(site)
      columns = (1..COLUMNS).map do |n|
        ImageUtils.images_in(site, "home/column-#{n}").map do |f|
          rel = f.relative_path.delete_prefix("/assets/images/home/")
          slug = Jekyll::Utils.slugify(rel.delete_suffix(f.extname))
          width, height = ImageUtils.jpeg_size(f.path)
          { "image" => f.relative_path, "url" => "/photos/#{slug}/", "slug" => slug,
            "width" => width, "height" => height }
        end
      end
      site.data["home_columns"] = columns

      sequence = []
      (0...columns.map(&:length).max.to_i).each do |row|
        columns.each { |col| sequence << col[row] if col[row] }
      end

      sequence.each_with_index do |photo, i|
        prev_p = i > 0 ? sequence[i - 1] : nil
        next_p = i < sequence.length - 1 ? sequence[i + 1] : nil
        site.pages << PhotoPage.new(site, photo["slug"], {
          "layout" => "photo",
          "title" => "Photo",
          "image" => photo["image"],
          "prev_url" => prev_p && prev_p["url"],
          "next_url" => next_p && next_p["url"],
        })
      end
    end
  end
end
