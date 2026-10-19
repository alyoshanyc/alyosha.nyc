# alyosha.nyc

Personal site for the photographer **Alyosha**. The site uses [Jekyll](https://jekyllrb.com) and GitHub Pages. A commit to `main` builds and deploys the site automatically.

The homepage is one photo stream, in the style of [wingshya.com/photographs](https://www.wingshya.com/photographs). The menu has four gallery pages (People, Landscape, Fashion, and Street-Stories), an About page with the contact details, and a Home link. A "..." button at the right of the menu opens more galleries (Jamaica, Guadeloupe, and France). Desktop screens show 4 columns. Narrow screens show 3, 2, or 1 column. Each photo links to its own page, with previous/next navigation.

## How you update the site

You do all updates on github.com, in the browser. You do not need to install anything.

- Every change that you save on GitHub is a **commit**. When you commit to the `main` branch, the site rebuilds and goes live in approximately 2 minutes.
- On each commit screen, select **Commit directly to the `main` branch**, then click **Commit changes**.
- To see if the site updated, open the **Actions** tab at the top of the repository. A green check on the newest run means the site is live. A red cross means the build failed. Click the run to see the error.

You maintain these files and folders. Do not change other files for day-to-day updates.

| File or folder | Purpose |
|---|---|
| `assets/images/home/column-1/` to `column-4/` | The homepage photos. One folder per desktop column, left to right. |
| `assets/images/<gallery>/column-1/` to `column-4/` | The photos of each gallery page, the same way (for example `assets/images/people/column-1/`). |
| `_data/menu.yml` | The menu items, the photo folder of each gallery, and which items are in the "..." list. |
| `about.md` and `assets/images/about/` | The About page text and photo. |
| `_config.yml` | The site name, email, and location (rare changes). |

All other content is automatic. The build creates the gallery pages, one page per gallery photo (for example `alyosha.nyc/jamaica/boatman/`), and one page per homepage photo (for example `alyosha.nyc/photos/column-1-01-boatman/`).

## Prepare a photo (on your computer, before you upload)

The site does not resize or compress photos. Visitors download the file that you upload. Export each photo from Lightroom, Photoshop, or Capture One with these settings:

- **Format:** JPEG (`.jpg`).
- **Size:** longest edge 1800 pixels. Do not upload camera or scanner originals (3000+ pixels). Do not go below 1200 pixels, or the photo can look soft on large screens.
- **Quality:** 80-85 on a 0-100 scale. Most photos then come in under 500 KB. Photos with heavy film grain or fine detail can be larger. Do not lower the quality to make them smaller.
- **Color space:** sRGB. Adobe RGB photos can look flat on phones and in some browsers.
- **Rotation:** look at the exported file before you upload it. If it shows sideways on the site after upload, rotate it in your editor, export it again, and replace it (see [Replace a photo](#replace-a-photo)).
- **File name:** use only letters, numbers, and `-` or `_`. Remove ` copy` and other leftovers. The name becomes part of the photo page address. On GitHub you cannot rename a photo after you upload it. To rename, delete it and upload it again.
- **File size limit:** GitHub accepts files up to 25 MB in the browser. A correctly exported photo is far below this.

## Photo columns

The homepage and every gallery page show their photos in four columns on a desktop screen. Each column is a folder. You manage a page by uploading photos to its column folders and deleting them there.

| Page | Column folders (left to right) |
|---|---|
| Homepage | `assets/images/home/column-1/` to `column-4/` |
| People | `assets/images/people/column-1/` to `column-4/` |
| Landscape | `assets/images/landscape/column-1/` to `column-4/` |
| Fashion | `assets/images/fashion/column-1/` to `column-4/` |
| Street-Stories | `assets/images/street-stories/column-1/` to `column-4/` |
| Jamaica | `assets/images/jamaica/column-1/` to `column-4/` |
| Guadeloupe | `assets/images/guadeloupe/column-1/` to `column-4/` |
| France | `assets/images/france/column-1/` to `column-4/` |

The rules:

- **Order in a column:** each column shows its photos top to bottom in alphanumeric order of the file names (`photo-2.jpg` before `photo-10.jpg`). To set the order, start each file name with a number: `01-boatman.jpg`, `02-pony.jpg`, and so on. To put a photo between `03-` and `04-`, name it `03b-...jpg`.
- **Only column folders:** put every photo in a `column-1` to `column-4` folder. A photo directly in the page folder (for example `assets/images/people/boatman.jpg`) does not show.
- **Copies are independent:** to show a photo on two pages (for example People and the homepage), upload it to a column folder of each page. Deleting one copy does not delete the other.
- **Even columns:** keep the four columns approximately equal in height, not in number of photos. A portrait photo is approximately 2.3 times as tall as a landscape photo. To make a column shorter, move a portrait photo out of it, or swap it for a landscape photo from a shorter column.
- **Move a photo to another column:** GitHub cannot move a file. Delete it from one column folder and upload it to the other.
- **Narrow screens:** the site interleaves the columns row by row (first photo of each column, then second photo of each column, and so on). It then re-deals that order into 3, 2, or 1 columns. Previous/next on the photo pages follow the same order.
- **Empty page:** a gallery with no photos shows "Photos coming soon."
- **The `.gitkeep` files:** an empty column folder contains a `.gitkeep` file, because GitHub does not keep empty folders. Leave it. It does not show on the site.

## Add photos

1. Open the repository on github.com.
2. Go to the column folder: click `assets`, then `images`, then the page folder (for example `people` or `home`), then the column (for example `column-2`).
3. Click **Add file** (top right), then **Upload files**.
4. Drag the photos into the page. You can upload many photos at one time.
5. Click **Commit changes**.

The page shows the new photos automatically. You do not list them in a file.

## Replace a photo

Upload the new version to the same column folder with exactly the same file name, including upper and lower case and the extension. GitHub replaces the old file. The photo keeps its place and its page address.

## Remove a photo

1. Go to the column folder and click the photo.
2. Click the **...** menu (top right), then **Delete file**.
3. Click **Commit changes**.

If the same photo is on another page too, delete it there as well. Each page has its own copy.

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
2. Upload it to `assets/images/about/` (the same steps as [Add photos](#add-photos)).
3. In `about.md`, change the `image:` line to the new file name, for example `image: /assets/images/about/new-photo.jpg`.
4. Optional: delete the old photo.

## Change the menu

Edit `_data/menu.yml` on github.com: click the file, click the pencil icon (**Edit this file**, top right), make the change, then click **Commit changes** twice.

Each menu item is a group of lines that starts with `- title:`. The items are in menu order, left to right. An item can have these lines:

| Line | Meaning |
|---|---|
| `- title: Jamaica` | The label in the menu. |
| `  url: /jamaica/` | The page address. Start and end it with `/`. |
| `  folder: jamaica` | Only for a gallery: its folder in `assets/images/`. |
| `  extra: true` | Optional. The item is not in the menu bar. It is in the list that opens when a visitor clicks "..." at the right of the menu. |

Keep the two spaces at the start of each line after the first.

- To rename a menu item, change its `title`.
- To move a menu item, move all its lines together.
- To move an item into the "..." list, add the line `  extra: true`. To move it back into the menu bar, delete that line.
- About is a normal page, not a gallery. Its item has no `folder`. See [Change the About page](#change-the-about-page).
- On phones, the full-screen menu shows the "..." items below the other items.

To add a gallery (for example Italy):

1. Make the four column folders. Open `assets/images`, click **Add file**, then **Create new file**. Type `italy/column-1/.gitkeep` as the file name and click **Commit changes**. Do the same for `italy/column-2/.gitkeep`, `italy/column-3/.gitkeep`, and `italy/column-4/.gitkeep`.
2. Upload photos into the column folders (see [Add photos](#add-photos)).
3. Add an item to `_data/menu.yml`, for example:

   ```yaml
   - title: Italy
     url: /italy/
     folder: italy
     extra: true
   ```

## If a photo does not appear

Do these checks:

1. Open the **Actions** tab. Make sure the newest run is green. If it is still running (yellow), wait for it to finish.
2. Reload the page in the browser. If the old page still shows, force a full reload: **Cmd-Shift-R** on a Mac, **Ctrl-F5** on Windows. Browsers keep parts of the site for up to 10 minutes.
3. Make sure the photo is in a column folder (`column-1` to `column-4`), not directly in the page folder. Click the newest run in **Actions**, then **build**, to see a warning for each photo outside a column folder.

## Settings (rare changes)

Edit `_config.yml` on github.com (pencil icon, then **Commit changes** twice):

- `title:` the site name in the top left corner and in browser tabs.
- `email:` and `location:` the contact details in the footer and on the About page.
- `hero_image:` the photo that shows when someone shares a link to the site. Use a path such as `/assets/images/home/column-1/01-boatman.jpg`.

Do not change the other lines.

## Preview the site locally (developers)

```bash
bundle install
bundle exec jekyll serve --livereload    # http://localhost:4000
```

The gallery pages and photo pages come from build plugins: `_plugins/theme_pages.rb` and `_plugins/home_pages.rb`. This is why the site uses the `jekyll` gem, not the `github-pages` gem (that gem does not permit custom plugins).

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
