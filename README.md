# doc-explorer
General documentation for kibibit thingies

We can keep getting started documents here, design documents, and even thoughts and ideas

To add a document, simply create a new `markdown` file and include the following header:

```markdown
---
title: <title>
authors:
 - <author1>
layout: <default | homepage | postmortem>
id: <title-with-dashes>
permalink: /<sub-path-to-article>
---
```

When the document is ready in your opinion, you can publish it by adding it to the navigation object located in `_data/navigation.yml`:

```yml
- title: <title>
  url: /<sub-path-to-article>
  icon: <icon>
```

if you want to add it inside a category, use `sublinks`:

```yml
- title: Postmortems
  url: /postmortem
  icon: fa-flask
  sublinks:
    - title: Shakespeare Sonnet++ Postmortem
      url: /postmortem/001
      incident: 1
```
