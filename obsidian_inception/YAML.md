## Overview
YAML is a human-readable data serialization language that is often used for writing configuration files. Depending on whom you ask, YAML stands for yet another markup language or YAML ain’t markup language (a recursive acronym), which emphasizes that YAML is for data, not documents. 

YAML files use a .yml or .yaml extension, and follow specific syntax rules. 

YAML has features that come from Perl, C, XML, HTML, and other programming languages. YAML is also a superset of JSON, so JSON files are valid in YAML.

There are no usual format symbols, such as braces, square brackets, closing tags, or quotation marks. And YAML files are simpler to read as they use Python-style indentation to determine the structure and indicate nesting. Tab characters are not allowed by design, to maintain portability across systems, so whitespaces—literal space characters—are used instead. 

Comments can be identified with a pound or hash symbol (#). It’s always a best practice to use comments, as they describe the intention of the code. YAML does not support multi-line comment, each line needs to be suffixed with the pound character.

A common question for YAML beginners is “What do the 3 dashes mean?” 3 dashes (---) are used to signal the start of a document, while each document ends with three dots (...).  

This is a very basic example of a YAML file:

```YAML
#Comment: This is a supermarket list using YAML
#Note that - character represents the list
---
food: 
  - vegetables: tomatoes #first list item
  - fruits: #second list item
      citrics: oranges 
      tropical: bananas
      nuts: peanuts
      sweets: raisins
```

Note that the structure of a YAML file is a map or a list, and it follows a hierarchy depending on the indentation, and how you define your key values. Maps allow you to associate key-value pairs. Each key must be unique, and the order doesn't matter. Think of a Python dictionary or a variable assignment in a Bash script.

A map in YAML needs to be resolved before it can be closed, and a new map is created. A new map can be created by either increasing the indentation level or by resolving the previous map and starting an adjacent map.

A list includes values listed in a specific order and may contain any number of items needed. A list sequence starts with a dash (-) and a space, while indentation separates it from the parent. You can think of a sequence as a Python list or an array in Bash or Perl. A list can be embedded into a map.

In the example provided above “vegetables” and “fruits” represent items that are part of the list named “food”.

YAML also contains scalars, which are arbitrary data (encoded in Unicode) that can be used as values such as strings, integers, dates, numbers, or booleans.

When creating a YAML file, you’ll need to ensure that you follow these syntax rules and that your file is valid. To achieve it, you can use a linter—an application that verifies the syntax of a file. The yamllint command can help to ensure you’ve created a valid YAML file before you hand it over to an application.
## Resources
[- What is YAML?](https://www.redhat.com/en/topics/automation/what-is-yaml)