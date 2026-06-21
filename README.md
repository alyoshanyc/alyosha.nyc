# alyosha.nyc

Personal site for the artist **Alyosha**, built with [Jekyll](https://jekyllrb.com) and hosted on GitHub Pages. Content is plain Markdown. Commit a file and GitHub rebuilds the site automatically.

## Layout

```
_config.yml            site settings + project list
index.md, about.md, contact.md
projects/<id>.md       one page per project (and subproject)
_posts/<project>/       posts for a project   (e.g. _posts/jamaica/)
_posts/<parent>/<sub>/  posts for a subproject (e.g. _posts/models/caitlin/)
assets/images/...       images, mirroring the same hierarchy
```

Current projects: **Models** (with subprojects Anga, Lulu, Caitlin), **Jamaica**, **NYC**.

## Add content

### A post (a work, photo, or note)

1. Put the image in **`assets/images/<project>/`**.
2. Create **`_posts/<project>/YYYY-MM-DD-title.md`** (the date prefix is required). For a subproject, mirror the hierarchy: **`_posts/<parent>/<subproject>/...`** (e.g. `_posts/models/lulu/`):

   ```markdown
   ---
   layout: post
   title: "Title"
   date: 2025-07-23
   project: jamaica                    # id of the project it belongs to (see _config.yml)
   image: /assets/images/jamaica/photo.jpg
   caption: "Film stock · place, year" # optional
   focus: top                          # optional: vertical crop for the thumbnail
   cover: true                         # optional: use as the subproject tile image
   ---
   Your text here. Blank line between paragraphs. *Italics* and [links](https://example.com) work.
   ```

Posts live in a folder per project under `_posts/` for tidiness, but the `project:` field is what actually ties a post to its project.

**`focus` (thumbnail framing).** Project thumbnails are cropped to a 4:3 box, so tall photos lose part of their height. `focus` controls which part stays. It is the vertical half of CSS `object-position`, so it accepts `top`, `center` (the default), `bottom`, or any percentage:

- `0%` (= `top`) shows the very top of the photo; `100%` (= `bottom`) shows the very bottom.
- **Lower** the percentage to reveal more of the **top** (use this when a head is getting clipped). **Raise** it to reveal more of the **bottom** (use this when the subject sits too low).
- Fine-tune in small steps. Typical headshots land around `15%`-`45%`; a subject set low in the frame (foreground below, sky or foliage above) may want `55%`-`70%`. Percentages give pixel-level control, so prefer them over the keywords when a face is close to an edge.
- Landscape photos (wider than 4:3) are not cropped vertically, so `focus` has no effect on them.

(Single post pages always show the full, uncropped image; `focus` only affects the thumbnail.)

The post appears on its project page and in that project's homepage row.

### A project (a body of work)

1. Add an entry under `projects:` in **`_config.yml`**:

   ```yaml
   projects:
     - id: my-project
       title: "My Project"
   ```

2. Give it a page: copy `projects/jamaica.md` to `projects/my-project.md` and change `project_id` and `permalink` to match the id.

**Subprojects.** Add `parent: <other-id>` to a project to nest it (e.g. `anga` and `lulu` under `models`). The parent's page shows one tile per subproject, using that subproject's `cover: true` post (or its newest post) as the tile image. Subprojects are hidden from the top nav. Mirror the hierarchy in `_posts/` (e.g. `_posts/models/lulu/`).

### Pages & settings

- Homepage intro, About, Contact → `index.md`, `about.md`, `contact.md`.
- Site name, email, hero image, and project names/order → `_config.yml`.

## Preview locally

```bash
bundle install
bundle exec jekyll serve --livereload    # http://localhost:4000
```

## Deploy

Pushing to `main` triggers `.github/workflows/pages.yml`, which builds the site with Bundler and deploys it to GitHub Pages. (Repo setting: **Settings → Pages → Source: GitHub Actions**.) The custom domain `alyosha.nyc` is set by the `CNAME` file; point the domain's DNS at GitHub Pages to make it live.
