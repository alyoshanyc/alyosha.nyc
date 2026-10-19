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

    IMAGE_EXTS = %w[.jpg .jpeg .png .webp .gif].freeze

    def generate(site)
      Array(site.data["menu"]).each do |item|
        folder = item["folder"].to_s.strip.delete_prefix("/").delete_suffix("/")
        next if folder.empty?

        url = item["url"].to_s
        prefix = "/assets/images/#{folder}/"
        files = site.static_files
          .select { |f| f.relative_path.start_with?(prefix) && IMAGE_EXTS.include?(f.extname.downcase) }
          .sort_by { |f| natural_key(f.relative_path) }

        photos = files.map do |f|
          slug = Jekyll::Utils.slugify(f.basename)
          width, height = jpeg_size(f.path)
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

    private

    # Displayed pixel size of a JPEG, read from its start-of-frame header, so
    # the gallery can balance column heights before any image loads. Browsers
    # rotate photos by their EXIF Orientation tag, so for orientations 5-8
    # (quarter turns) width and height swap. nil for other formats.
    def jpeg_size(path)
      orientation = 1
      File.open(path, "rb") do |io|
        return nil unless io.read(2) == "\xFF\xD8".b
        loop do
          marker = io.read(2)
          return nil unless marker && marker.getbyte(0) == 0xFF
          type = marker.getbyte(1)
          length = io.read(2).unpack1("n")
          if (0xC0..0xCF).cover?(type) && ![0xC4, 0xC8, 0xCC].include?(type)
            height, width = io.read(5).unpack("xnn")
            return orientation >= 5 ? [height, width] : [width, height]
          end
          segment = io.read(length - 2)
          orientation = exif_orientation(segment) || orientation if type == 0xE1
        end
      end
    rescue StandardError
      nil
    end

    # EXIF Orientation (tag 0x0112) from an APP1 segment, or nil.
    def exif_orientation(segment)
      return nil unless segment.start_with?("Exif\0\0".b)
      tiff = segment.byteslice(6..)
      fmt = { "II" => "v", "MM" => "n" }[tiff.byteslice(0, 2)] or return nil
      long = fmt == "v" ? "V" : "N"
      ifd = tiff.byteslice(4, 4).unpack1(long)
      tiff.byteslice(ifd, 2).unpack1(fmt).times do |i|
        entry = ifd + 2 + i * 12
        return tiff.byteslice(entry + 8, 2).unpack1(fmt) if tiff.byteslice(entry, 2).unpack1(fmt) == 0x0112
      end
      nil
    end

    # Alphanumeric order as a file browser shows it: case-insensitive, and
    # digit runs compare as numbers, so photo-2 sorts before photo-10.
    def natural_key(path)
      path.downcase.scan(/\d+|\D+/).map { |s| s.match?(/\A\d/) ? [0, s.to_i, s] : [1, 0, s] }
    end
  end
end
