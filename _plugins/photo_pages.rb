# Generates a dedicated page per curated photo (like wingshya.com/photographs/d/41),
# so the maintainer only ever touches _data/gallery.yml and assets/images/.
#
# For every path listed in _data/gallery.yml (relative to assets/images/, for
# example people/birdbeach.jpg) this creates /photos/<name>/ (name = the path
# without extension, slugified: people-birdbeach), rendering _layouts/photo.html
# with the image path plus prev/next links that follow the stream's display
# order: the YAML columns interleaved row-major (col1[0], col2[0], col3[0],
# col4[0], col1[1], ...), the same order the homepage uses on narrow screens.
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

  class PhotoPageGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      gallery = site.data["gallery"]
      return unless gallery

      columns = gallery.keys.sort.map { |k| Array(gallery[k]) }
      sequence = []
      (0...columns.map(&:length).max.to_i).each do |row|
        columns.each { |col| sequence << col[row] if col[row] }
      end

      by_path = {}
      site.static_files.each { |f| by_path[f.relative_path] = f }

      photos = sequence.filter_map do |fn|
        file = by_path["/assets/images/#{fn}"]
        unless file
          Jekyll.logger.warn "photo_pages:", "no file assets/images/#{fn} - skipped"
          next
        end
        slug = Jekyll::Utils.slugify(fn.delete_suffix(File.extname(fn)))
        { "slug" => slug, "image" => file.relative_path }
      end

      photos.each_with_index do |photo, i|
        prev_p = i > 0 ? photos[i - 1] : nil
        next_p = i < photos.length - 1 ? photos[i + 1] : nil
        site.pages << PhotoPage.new(site, photo["slug"], {
          "layout" => "photo",
          "title" => photo["slug"],
          "image" => photo["image"],
          "prev_url" => prev_p && "/photos/#{prev_p["slug"]}/",
          "next_url" => next_p && "/photos/#{next_p["slug"]}/",
        })
      end
    end
  end
end
