# Generates one gallery page per gallery entry in _data/menu.yml (an entry
# with a `folder`: People, Landscape, Jamaica, ...).
#
# A gallery has four columns, like the homepage: assets/images/<folder>/
# column-1 ... column-4, each top to bottom in natural alphanumeric order.
# The page renders _layouts/theme.html. Each image also gets a page at
# <url><name>/ (name = filename without extension, slugified), rendering
# _layouts/photo.html with prev/next in display order (columns interleaved
# row by row) and Index back to <url>.
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
        used = {}
        columns = ImageUtils.columns_in(site, folder).each_with_index.map do |files, ci|
          files.map do |f|
            slug = Jekyll::Utils.slugify(f.basename)
            # The same file name in two columns: keep both pages apart.
            slug = "column-#{ci + 1}-#{slug}" if used[slug]
            used[slug] = true
            width, height = ImageUtils.jpeg_size(f.path)
            { "image" => f.relative_path, "url" => "#{url}#{slug}/", "width" => width, "height" => height }
          end
        end

        site.pages << ThemePage.new(site, url, {
          "layout" => "theme",
          "title" => item["title"],
          "columns" => columns,
        })

        photos = ImageUtils.row_major(columns)
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
