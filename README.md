# DeepL SDK for Julia

DeepL SDK in Julia provides functionality for translating text strings, detecting languages and listing available languages. This package allows you to interact with the DeepL API from Julia.

## Setup
To use this package, you need to set the environment variable `DEEPL_API_KEY` with your DeepL API key.

## Available Functions

| Function | Description | Input | Output |
|---|---|---|---|
| `translate_text(text, source, target)` | Translate text specifying source and target languages | `String` or `Vector{String}` | `String` or `Vector{String}` |
| `translate_text(text, source => target)` | Translate text using Pair syntax | `String` or `Vector{String}` | `String` or `Vector{String}` |
| `translate_text(text, target)` | Translate text with auto-detected source language | `String` or `Vector{String}` | `String` or `Vector{String}` |
| `detect_language(text)` | Detect the language of the given text | `String` or `Vector{String}` | `String` or `Vector{String}` |
| `get_languages(type)` | List supported languages | `"source"` (default) or `"target"` | `Vector{Dict{String, Any}}` |

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

### Detect Language
Detect the language of a single text:

```julia
detect_language("Guten Morgen, ich hätte gerne einen Tee")
# Output: "DE"

detect_language("Good morning, I would like a tea")
# Output: "EN"
```

Detect the language of multiple texts in a single API call:

```julia
detect_language(["Bonjour le monde", "Hola mundo", "Ciao mondo"])
# Output: ["FR", "ES", "IT"]
```

> **Note:** Since the DeepL API does not provide a dedicated language detection endpoint, `detect_language` uses the translate endpoint internally and extracts the detected source language from the response.

### List Available Languages
Retrieve the list of supported source languages:

```julia
get_languages()
# Output: [Dict("language" => "DE", "name" => "German"), Dict("language" => "EN", "name" => "English"), ...]
```

Retrieve the list of supported target languages (includes `supports_formality` field):

```julia
get_languages("target")
# Output: [Dict("language" => "DE", "name" => "German", "supports_formality" => true), ...]
```

## Resources

-  [DeepL API documentation](https://developers.deepl.com/docs/getting-started/intro).
