# Generates one gallery page per themed menu entry (People, Landscape, ...).
#
# Every entry in _data/menu.yml that has a `folder` gets a page at its `url`,
# rendering _layouts/theme.html with all images under assets/images/<folder>/
# (subfolders included), in natural alphanumeric order. Each image gets a page
# at <url><name>/ (name = filename without extension, slugified), rendering
# _layouts/photo.html with prev/next in gallery order and Index back to <url>.
module Alyosha
  class ThemePage < Jekyll::Page
    def initialize(site, dir, data)
      @site = site
      @base = site.source
      @dir = dir
      @basename = "index"
      @ext = ".html"
      @name = "index.html"
      @data = data
    end
  end

  class ThemePageGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      Array(site.data["menu"]).each do |item|
        folder = item["folder"].to_s.strip.delete_prefix("/").delete_suffix("/")
        next if folder.empty?

        url = item["url"].to_s
        files = ImageUtils.images_in(site, folder)

        photos = files.map do |f|
          slug = Jekyll::Utils.slugify(f.basename)
          width, height = ImageUtils.jpeg_size(f.path)
          { "image" => f.relative_path, "url" => "#{url}#{slug}/", "width" => width, "height" => height }
        end

        site.pages << ThemePage.new(site, url, {
          "layout" => "theme",
          "title" => item["title"],
          "photos" => photos,
        })

        photos.each_with_index do |photo, i|
          prev_p = i > 0 ? photos[i - 1] : nil
          next_p = i < photos.length - 1 ? photos[i + 1] : nil
          site.pages << ThemePage.new(site, photo["url"], {
            "layout" => "photo",
            "title" => item["title"],
            "image" => photo["image"],
            "index_url" => url,
            "prev_url" => prev_p && prev_p["url"],
            "next_url" => next_p && next_p["url"],
          })
        end
      end
    end
  end
end
