---
title: MkDocs
---

# Introduction to MkDocs Markdown
MkDocs is a straightforward static site generator designed for creating project documentation. It uses Markdown for source files and a single YAML configuration file for settings. With features like live reloading and easy customization, it's a practical tool for developers who need to create clear and concise documentation for their projects.

This chapter is designed to introduce you to some of the main Markdown commands that may be helpful when writing documentation. This documentation uses the theme Material for MkDocs which comes with additional plugins and extensions.

In case you'd like to browse detailed instructions how to use various features of the mkdocs Markdown visit the [mkdocs material theme homepage](https://squidfunk.github.io/mkdocs-material/reference/admonitions/ "Material for MkDocs homepage").

Since we're also using the [MkDocs Awesome Pages Plugin](https://github.com/lukasgeiter/mkdocs-awesome-pages-plugin) you can set the custom order of your pages by providing a .pages file and providing the order of the markdown documents like this:

```yaml title="docs / .pages" linenums="1"
nav:
    - index.md
    - general.md
    - advanced.md
    - visual.md
```

*[Markdown]: Markdown is a simple text formatting system that lets you create styled text using easy-to-read and easy-to-write plain text syntax.

