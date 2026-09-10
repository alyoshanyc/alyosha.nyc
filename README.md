# alyosha.nyc

Personal site for the photographer **Alyosha**. The site uses [Jekyll](https://jekyllrb.com) and GitHub Pages. A push to `main` builds and deploys the site automatically.

The homepage is one photo stream, in the style of [wingshya.com/photographs](https://www.wingshya.com/photographs). Desktop screens show 4 columns. Narrow screens show 3, 2, or 1 column. Each photo links to its own page, with previous/next navigation in stream order.

## Files you maintain

You maintain two things. Do not change other files for day-to-day updates.

| File or folder | Purpose |
|---|---|
| `assets/images/` | The photo files. Subfolders are permitted. |
| `_data/gallery.yml` | The homepage layout. Four lists = the four desktop columns, top to bottom. |

All other content is automatic. The build creates one page per listed photo at `/photos/<filename-without-extension>/`.

## Add a photo

1. Prepare the photo before you upload it. The site does not resize or compress photos. Visitors download the file that you commit.
   - **Format:** JPEG (`.jpg`).
   - **Dimensions:** make the longest edge 1800 pixels or less. Do not upload camera originals (4000+ pixels). Keep the longest edge at 1200 pixels or more, or the photo can look soft on large screens.
   - **File size:** keep each file under 500 KB. Export at JPEG quality 80-85 to reach this. The photos on the site today average approximately 200 KB.
2. Give the file a name that no other file in the repository has.
   - **CAUTION:** If two files have the same name, the site shows only one of them. It selects the file silently. It does not show an error.
3. Put the file in `assets/images/`. You can use any subfolder.
4. Open `_data/gallery.yml`. Add the file name (for example `photo.jpg`) to one of the four columns. Do not include the folder path.
5. Commit the two changes. Push to `main`. The site rebuilds and deploys automatically.

## Change the homepage layout

- The four lists in `_data/gallery.yml` are the four desktop columns, top to bottom.
- Move a line to move a photo.
- Remove a line to remove a photo from the homepage. The file stays in the repository.
- Keep the four columns approximately equal in length. Then the page ends evenly.
- On narrow screens the site interleaves the columns row by row (first of each column, then second of each column, and so on). It then re-deals that order into 3, 2, or 1 columns. The relative order that you set applies on all screens.

## If a photo does not appear

Do these checks:

1. Make sure the file name in `_data/gallery.yml` is the same as the file name in `assets/images/`. Do not include the folder path in the YAML.
2. Make sure no other file in the repository has the same name.
3. Make sure the deploy succeeded: repository → **Actions** tab → newest run is green. The build log shows a warning for each YAML entry that has no matching file.

## Pages and settings (rare changes)

- About page → `about.md`. Contact page → `contact.md`.
- Site name, email, and share image → `_config.yml`.

## Preview the site locally (developers)

```bash
bundle install
bundle exec jekyll serve --livereload    # http://localhost:4000
```

The photo pages come from a build plugin: `_plugins/photo_pages.rb`. This is why the site uses the `jekyll` gem, not the `github-pages` gem (that gem does not permit custom plugins).

## Deploy

A push to `main` starts `.github/workflows/pages.yml`. The workflow builds the site and deploys it to GitHub Pages. Repository setting: **Settings → Pages → Source: GitHub Actions**.

## Custom domain (alyosha.nyc)

The site deploys through GitHub Actions, so the `CNAME` file in this repository does not attach the domain by itself. The domain is linked in two places:

1. **GitHub:** Settings → Pages → Custom domain → `alyosha.nyc` (or `gh api -X PUT repos/alyosmo/alyosha.nyc/pages -f cname=alyosha.nyc`). When DNS resolves, set **Enforce HTTPS** so GitHub provisions the certificate.
2. **DNS (GoDaddy):** point the domain at GitHub Pages with these records:

   | Type  | Name | Value               |
   |-------|------|---------------------|
   | A     | @    | 185.199.108.153     |
   | A     | @    | 185.199.109.153     |
   | A     | @    | 185.199.110.153     |
   | A     | @    | 185.199.111.153     |
   | CNAME | www  | alyosmo.github.io |

   Delete GoDaddy's default parked `A @` record and any domain forwarding first. GitHub redirects `www.alyosha.nyc` to the apex automatically. Verify with `dig +short alyosha.nyc` (it must return the four IPs above).
