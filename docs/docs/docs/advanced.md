---
title: Advanced
---

# Introduction to MkDocs Markdown
### Advanced Formatting
As part of this section you will get introduced to some of the more advanced markdown commands and formatting techniques.

#### Tables
In cases where you might need tables you can crate these as well:

| Method      | Description                          |
| :---------- | :----------------------------------- |
| `GET`       | :material-check:     Fetch resource  |
| `PUT`       | :material-check-all: Update resource |
| `DELETE`    | :material-close:     Delete resource |


```markdown linenums="1"
| Method      | Description                          |
| :---------- | :----------------------------------- |
| `GET`       | :material-check:     Fetch resource  |
| `PUT`       | :material-check-all: Update resource |
| `DELETE`    | :material-close:     Delete resource |
```

#### Code
Normal code blocks:

```typescript title="helloWorld.ts" linenums="1"
// This is my very complex code
console.log('hello world');
```

```markdown title="normal code blocks" linenums="1"

    ```typescript title="helloWorld.ts" linenums="1"
    // This is my very complex code
    console.log('hello world');
    ```
```

Stacked code blocks:

=== "C"

    ``` c title="helloWorld.c" linenums="1"
    #include <stdio.h>

    int main(void) {
      printf("Hello world!\n");
      return 0;
    }
    ```

=== "C++"

    ``` c++ title="helloWorld.cpp" linenums="1"
    #include <iostream>

    int main(void) {
      std::cout << "Hello world!" << std::endl;
      return 0;
    }
    ```

```markdown title="stacked code block" linenums="1"

    === "C"

        ``` c title="helloWorld.c" linenums="1"
            #include <stdio.h>

            int main(void) {
            printf("Hello world!\n");
            return 0;
            }
        ```

    === "C++"

        ``` c++ title="helloWorld.cpp" linenums="1"
            #include <iostream>

            int main(void) {
            std::cout << "Hello world!" << std::endl;
            return 0;
            }
        ```
```

#### Admonitions

!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

```markdown linenums="1"
!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

??? info "Some custom title expandable"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

```markdown linenums="1"
??? info "Some custom title expandable"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

???+ example "my custom example expanded"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

```markdown linenums="1"
???+ example "my custom example expanded"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

List of all types: `note`, `abstract`, `info`, `tip`, `success`, `question`, `warning`, `failure`, `danger`, `bug`, `example`, `quote`.


#### Annotations


Lorem ipsum dolor sit amet, (1) consectetur adipiscing elit.
{ .annotate }

1.  :man_raising_hand: I'm an annotation! I can contain `code`, __formatted
    text__, images, ... basically anything that can be expressed in Markdown.

```markdown linenums="1"
Lorem ipsum dolor sit amet, (1) consectetur adipiscing elit.
{ .annotate }

1.  :man_raising_hand: I'm an annotation! I can contain `code`, __formatted
    text__, images, ... basically anything that can be expressed in Markdown.
```

#### Footnotes

Lorem ipsum[^1] dolor sit amet, consectetur adipiscing elit.[^2]
[^1]: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
[^2]:
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

```markdown linenums="1"
Lorem ipsum[^1] dolor sit amet, consectetur adipiscing elit.[^2]
[^1]: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
[^2]:
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

#### Definitions

The HTML specification is maintained by the W3C.

*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium

```markdown linenums="1"
The HTML specification is maintained by the W3C.

*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
```