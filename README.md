# DeepL SDK for Julia

DeepL SDK in Julia provides basic functionality for translating text strings. This package allows you to translate text from one language to another using the DeepL API.

## Setup
To use this package, you need to set the environment variable `DEEPL_API_KEY` with your DeepL API key.

## Usage
First, import the package:
```julia
using DeepL
```

### Translate a Single Text
You can translate a single text string using either of the following syntaxes:

```julia
text = "Good morning, I would like a tea and some cake"

translate_text(text, "EN" => "DE")
# Output: "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"

translate_text(text, "EN", "DE")
# Output: "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"
```

Alternatively, specify only the target language, and DeepL will infer the source language:

```julia
translate_text(text, "DE")
# Output: "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"
```
When not specifying the source language, it's possible that being the text too short, the language won't be correctly inferred.

### Translate Multiple Texts
Translate multiple text strings in a single API call:

```julia
texts = [
    "Good morning, I would like a tea and some cake",
    "How are you doing today?",
    "I am sooo tired, man..."
]

translate_text(texts, "EN" => "DE")
# Output:
# 3-element Vector{String}:
# "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"
# "Wie geht es Ihnen heute?"
# "Ich bin sooo müde, Mann..."
```

## Resources

-  [DeepL API documentation](https://developers.deepl.com/docs/getting-started/intro).
