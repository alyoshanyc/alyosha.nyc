# alyosha.nyc

Personal site for the photographer **Alyosha**. The site uses [Jekyll](https://jekyllrb.com) and GitHub Pages. A commit to `main` builds and deploys the site automatically.

The homepage is one photo stream, in the style of [wingshya.com/photographs](https://www.wingshya.com/photographs). The menu has four gallery pages (People, Landscape, Fashion, and Street-Stories) plus an About page with the contact details. Desktop screens show 4 columns. Narrow screens show 3, 2, or 1 column. Each photo links to its own page, with previous/next navigation.

## How you update the site

You do all updates on github.com, in the browser. You do not need to install anything.

- Every change that you save on GitHub is a **commit**. When you commit to the `main` branch, the site rebuilds and goes live in approximately 2 minutes.
- On each commit screen, select **Commit directly to the `main` branch**, then click **Commit changes**.
- To see if the site updated, open the **Actions** tab at the top of the repository. A green check on the newest run means the site is live. A red cross means the build failed. Click the run to see the error.

You maintain these files and folders. Do not change other files for day-to-day updates.

| File or folder | Purpose |
|---|---|
| `assets/images/people/`, `landscape/`, `fashion/`, `street-stories/` | The photos of each gallery page. |
| `_data/gallery.yml` | The homepage layout. Four lists = the four desktop columns, top to bottom. |
| `_data/menu.yml` | The menu items, and the photo folder for each gallery page. |

All other content is automatic. The build creates the gallery pages, one page per gallery photo (for example `alyosha.nyc/people/birdbeach/`), and one page per homepage photo (for example `alyosha.nyc/photos/people-birdbeach/`).

## Prepare a photo (on your computer, before you upload)

The site does not resize or compress photos. Visitors download the file that you upload. Export each photo from Lightroom, Photoshop, or Capture One with these settings:

- **Format:** JPEG (`.jpg`).
- **Size:** longest edge 1800 pixels. Do not upload camera or scanner originals (3000+ pixels). Do not go below 1200 pixels, or the photo can look soft on large screens.
- **Quality:** 80-85 on a 0-100 scale. Most photos then come in under 500 KB. Photos with heavy film grain or fine detail can be larger. Do not lower the quality to make them smaller.
- **Color space:** sRGB. Adobe RGB photos can look flat on phones and in some browsers.
- **Rotation:** look at the exported file before you upload it. If it shows sideways in the gallery after upload, rotate it in your editor, export it again, and replace it.
- **File name:** use only letters, numbers, and `-` or `_`. Remove ` copy` and other leftovers. The name becomes part of the photo page address. On GitHub you cannot rename a photo after you upload it. To rename, delete it and upload it again.
- **File size limit:** GitHub accepts files up to 25 MB in the browser. A correctly exported photo is far below this.

## Add photos to a gallery

1. Open the repository on github.com.
2. Go to the gallery folder: click `assets`, then `images`, then the gallery (for example `people`).
3. Click **Add file** (top right), then **Upload files**.
4. Drag the photos into the page. You can upload many photos at one time.
5. Click **Commit changes**.

The gallery page shows the new photos automatically. You do not list them in a file.

## Remove a photo from a gallery

1. Go to the gallery folder and click the photo.
2. Click the **...** menu (top right), then **Delete file**.
3. Click **Commit changes**.
4. If the photo is also on the homepage, remove its line from `_data/gallery.yml` (see [Change the homepage](#change-the-homepage)). If you do not, the homepage skips the photo and the build log shows a warning.

## Gallery order and columns

- A gallery shows its photos in alphanumeric order of the file names (`photo-2.jpg` before `photo-10.jpg`). To set the order, start the file names with numbers: `01-boatman.jpg`, `02-pony.jpg`, and so on.
- The photos read down the columns: column 1 top to bottom, then column 2, and so on. The site selects the column breaks that make the column heights as equal as possible. A portrait photo is approximately 2.3 times as tall as a landscape photo, so the columns can contain different numbers of photos. Narrow screens split the same order into 3, 2, or 1 columns.
- The columns cannot always end level. A column breaks only between two photos, and the order is fixed. To make the columns end more evenly, change the order of the files, or add or remove a photo.
- Each photo has its own page. Previous/next follow the gallery order. **Index** goes back to the gallery.
- A gallery with no photos shows "Photos coming soon."

## Change the homepage

The homepage shows the photos listed in `_data/gallery.yml`. To edit it:

1. Open `_data` on github.com, then click `gallery.yml`.
2. Click the pencil icon (**Edit this file**, top right).
3. Make the change. The rules are below.
4. Click **Commit changes**, then **Commit changes** again in the dialog.

The rules:

- The four lists (`column01` to `column04`) are the four desktop columns, top to bottom.
- Each line is `  - ` (two spaces, a dash, and a space) and then a path: the gallery folder, a `/`, and the file name. For example `  - people/birdbeach.jpg`. The folder shows the gallery that the photo comes from.
- The path must match the file exactly, including upper and lower case and the extension (`.jpg` is not `.JPG`). To get it right, open the photo on GitHub and copy its name from the top of the page.
- Put the path in quotes if the file name contains a space: `  - "fashion/Anga 2.jpg"`.
- To add a photo, add a line. The photo must be in a gallery folder first.
- To move a photo, cut its line and paste it in another place.
- To remove a photo from the homepage, delete its line. The photo stays in its gallery.
- Keep the four columns approximately equal in height, not in number of photos. A portrait photo is approximately 2.3 times as tall as a landscape photo. To make a column shorter, move a portrait photo out of it, or swap it for a landscape photo from a shorter column.
- On narrow screens the site interleaves the columns row by row (first of each column, then second of each column, and so on). It then re-deals that order into 3, 2, or 1 columns.

## Change the About page

The About page has three parts, each in its own file: the text, the contact details, and the photo.

### Change the text

1. Click `about.md` in the main folder of the repository.
2. Click the pencil icon (**Edit this file**, top right).
3. Change the text. The rules are below.
4. Click **Commit changes**, then **Commit changes** again in the dialog.

The file looks like this:

```markdown
---
layout: page
title: About
permalink: /about/
image: /assets/images/about/about-mailbox.jpg
contact: true
---
{:.prose__lead}
Alyosha is a photographer based in New York.

Portraits and documentary work, made in the studio and out on the street and the road, mostly on film. ...

Available for commissions: portraits, editorial, events, and travel. ...
```

The rules:

- Do not change the lines between the two `---` lines, except `title` (the page heading) and `image` (see [Change the photo](#change-the-photo)).
- The text starts after the second `---`.
- Put an empty line between paragraphs. One line break without an empty line does not start a new paragraph.
- The `{:.prose__lead}` line makes the paragraph directly below it larger. Keep it above the first paragraph. Do not put an empty line between it and that paragraph.
- To make a word bold, put two asterisks on each side: `**film**`. For italics, use one asterisk: `*film*`.
- To add a link, write `[link text](https://example.com)`.

### Change the contact details

The contact details (Email, Based in, Available for) show below the text.

- **Email and Based in:** edit `_config.yml`, the lines `email:` and `location:`. The footer of every page uses the same values.
- **Available for:** edit `_includes/contact-details.html`. Change only the text between `<dd>` and `</dd>` on the line below `<dt>Available for</dt>`.
- To remove the contact details from the About page, delete the `contact: true` line in `about.md`.
- The old Contact address (`/contact/`) forwards to the About page. Do not delete `contact.md`, or old links stop working.

### Change the photo

The photo is `assets/images/about/about-mailbox.jpg`. The `image:` line in `about.md` selects it. The photo also shows when someone shares a link to the About page.

1. Prepare the new photo the same as a gallery photo (see [Prepare a photo](#prepare-a-photo-on-your-computer-before-you-upload)).
2. Upload it to `assets/images/about/` (see [Add photos to a gallery](#add-photos-to-a-gallery)).
3. In `about.md`, change the `image:` line to the new file name, for example `image: /assets/images/about/new-photo.jpg`.
4. Optional: delete the old photo.

## Change the menu

Edit `_data/menu.yml` the same way as `gallery.yml` (pencil icon, then **Commit changes**). The entries are in menu order, left to right.

- To rename a menu item, change its `title`.
- To move a menu item, move its lines (`- title`, `url`, and `folder` if there is one) together.
- About is a normal page, not a gallery. Its entry has no `folder`. See [Change the About page](#change-the-about-page).
- To add a gallery:
  1. Make the folder: open `assets/images`, click **Add file**, then **Create new file**. Type the folder name, a `/`, and `.gitkeep` (for example `portraits/.gitkeep`). Click **Commit changes**.
  2. Upload photos into the new folder.
  3. Add an entry to `_data/menu.yml` with `title`, `url`, and `folder`, the same as the People entry.

## If a photo does not appear

Do these checks:

1. Open the **Actions** tab. Make sure the newest run is green. If it is still running (yellow), wait for it to finish.
2. Reload the page in the browser. If the old page still shows, wait a minute and reload again.
3. For the homepage: make sure the path in `_data/gallery.yml` matches the file name exactly (see [Change the homepage](#change-the-homepage)). Click the newest run in **Actions**, then **build**, to see a warning for each path that has no file.

## Settings (rare changes)

- Site name, email, location, and share image → `_config.yml`.

## Preview the site locally (developers)

```bash
bundle install
bundle exec jekyll serve --livereload    # http://localhost:4000
```

The gallery pages and photo pages come from build plugins: `_plugins/theme_pages.rb` and `_plugins/photo_pages.rb`. This is why the site uses the `jekyll` gem, not the `github-pages` gem (that gem does not permit custom plugins).

## Deploy

A push to `main` starts `.github/workflows/pages.yml`. The workflow builds the site and deploys it to GitHub Pages. Repository setting: **Settings → Pages → Source: GitHub Actions**.

## Custom domain (alyosha.nyc)

The site deploys through GitHub Actions, so the `CNAME` file in this repository does not attach the domain by itself. The domain is linked in two places:

1. **GitHub:** Settings → Pages → Custom domain → `alyosha.nyc` (or `gh api -X PUT repos/alyoshanyc/alyosha.nyc/pages -f cname=alyosha.nyc`). When DNS resolves, set **Enforce HTTPS** so GitHub provisions the certificate.
2. **DNS (GoDaddy):** point the domain at GitHub Pages with these records:

   | Type  | Name | Value               |
   |-------|------|---------------------|
   | A     | @    | 185.199.108.153     |
   | A     | @    | 185.199.109.153     |
   | A     | @    | 185.199.110.153     |
   | A     | @    | 185.199.111.153     |
   | CNAME | www  | alyoshanyc.github.io |

   Delete GoDaddy's default parked `A @` record and any domain forwarding first. GitHub redirects `www.alyosha.nyc` to the apex automatically. Verify with `dig +short alyosha.nyc` (it must return the four IPs above).
