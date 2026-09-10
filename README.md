# alyosha.nyc

Personal site for the artist **Alyosha**, built with [Jekyll](https://jekyllrb.com) and hosted on GitHub Pages. Content is plain Markdown. Commit a file and GitHub rebuilds the site automatically.

## Layout

```
_data/gallery.yml      homepage curation: which photo goes in which column
assets/images/...      the image files
_config.yml            site settings
index.md, about.md, contact.md
```

The homepage is a single photo stream in the style of [wingshya.com/photographs](https://www.wingshya.com/photographs): tightly packed columns with no gutters. Desktop shows 4 columns, narrower screens 3, 2, then 1 (phones).

## Maintaining the site

Day to day there are only two things to touch:

1. **`assets/images/`** — upload photos here (any subfolder is fine, filenames must be unique across the site). **Size the image before uploading**: longest edge at most **1800px**, JPEG. Nothing on the site resizes images for you; whatever you commit is what visitors download.
2. **`_data/gallery.yml`** — decides what appears on the homepage and where. Four lists, `column01`-`column04`: the four columns as seen on desktop, top to bottom. Add a photo's bare filename (e.g. `photo.jpg`) to a column to show it; move lines around to rearrange; delete a line to remove it from the page (the file stays in the repo). Keep the four columns roughly the same length so the page ends evenly.

On narrower screens the columns are interleaved (first of each column, then second of each column, and so on) and re-dealt into 3, 2, or 1 columns, so the relative order set in the YAML carries over everywhere.

Everything else is automatic: each curated photo also gets its own page at `/photos/<filename-without-extension>/` (clicking a tile opens it; prev/next arrows follow the stream order). These pages are generated at build time by `_plugins/photo_pages.rb` — nothing to maintain.

Commit and push to `main` — the site rebuilds and deploys itself.

### Pages & settings (rarely)

- About, Contact → `about.md`, `contact.md`.
- Site name, email, share image → `_config.yml`.

## Preview locally

```bash
bundle install
bundle exec jekyll serve --livereload    # http://localhost:4000
```

## Deploy

Pushing to `main` triggers `.github/workflows/pages.yml`, which builds the site with Bundler and deploys it to GitHub Pages. (Repo setting: **Settings → Pages → Source: GitHub Actions**.)

## Custom domain (alyosha.nyc)

Because the site deploys through GitHub Actions, the `CNAME` file in this repo does not attach the domain by itself. The domain is linked in two places:

1. **GitHub:** Settings → Pages → Custom domain → `alyosha.nyc` (or `gh api -X PUT repos/alyoshanyc/alyosha.nyc/pages -f cname=alyosha.nyc`). Once DNS resolves, check **Enforce HTTPS** so GitHub provisions the certificate.
2. **DNS (GoDaddy):** point the domain at GitHub Pages with these records:

   | Type  | Name | Value               |
   |-------|------|---------------------|
   | A     | @    | 185.199.108.153     |
   | A     | @    | 185.199.109.153     |
   | A     | @    | 185.199.110.153     |
   | A     | @    | 185.199.111.153     |
   | CNAME | www  | alyoshanyc.github.io |

   Delete GoDaddy's default parked `A @` record and any domain forwarding first. GitHub redirects `www.alyosha.nyc` to the apex automatically. Verify with `dig +short alyosha.nyc` (should return the four IPs above).
