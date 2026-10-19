# Helpers shared by the homepage and gallery generators.
module Alyosha
  module ImageUtils
    IMAGE_EXTS = %w[.jpg .jpeg .png .webp .gif].freeze

    module_function

    # Static files under /assets/images/<folder>/ (subfolders included), in
    # natural alphanumeric order.
    def images_in(site, folder)
      prefix = "/assets/images/#{folder}/"
      site.static_files
        .select { |f| f.relative_path.start_with?(prefix) && IMAGE_EXTS.include?(f.extname.downcase) }
        .sort_by { |f| natural_key(f.relative_path) }
    end

    # The photo columns of a folder: <folder>/column-1 ... column-<count>, each
    # a list of static files top to bottom in natural alphanumeric order. Logs
    # a warning for images directly in <folder>, which no column shows.
    def columns_in(site, folder, count = 4)
      loose = images_in(site, folder).reject { |f| f.relative_path.match?(%r{/column-\d+/}) }
      loose.each { |f| Jekyll.logger.warn "columns:", "#{f.relative_path} is not in a column-N folder - not shown" }
      (1..count).map { |n| images_in(site, "#{folder}/column-#{n}") }
    end

    # The display order of columns: interleaved row by row (col1[0], col2[0],
    # col3[0], col4[0], col1[1], ...), the order narrow screens use. Previous
    # and next on the photo pages follow it.
    def row_major(columns)
      (0...columns.map(&:length).max.to_i).flat_map { |row| columns.filter_map { |col| col[row] } }
    end

    # Alphanumeric order as a file browser shows it: case-insensitive, and
    # digit runs compare as numbers, so photo-2 sorts before photo-10.
    def natural_key(path)
      path.downcase.scan(/\d+|\D+/).map { |s| s.match?(/\A\d/) ? [0, s.to_i, s] : [1, 0, s] }
    end

    # Displayed pixel size of a JPEG, read from its start-of-frame header, so
    # the page can size tiles and balance column heights before any image
    # loads. Browsers rotate photos by their EXIF Orientation tag, so for
    # orientations 5-8 (quarter turns) width and height swap. nil for other
    # formats.
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
  end
end
