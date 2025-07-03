# DeepLSDK.jl

DeepL SDK in Julia. The package currently implements only the most basic functionality: translating a string of text. 



## Setup 
You need to define the enviroment variable `DEEPL_API_KEY`.

## Usage 
Import the package 
```julia
using DeepL
```

Translate a single text

```julia
text = "Good morning, I would like a tea and some cake";

translate_text(text, "EN", "DE")
# "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"
```

or translate several texts with a single API call
```julia
texts = [
    "Good morning, I would like a tea and some cake",
    "How are you doing today?",
    "I am sooo tired, man..."
]

translate_text(texts, "EN", "DE")
#3-element Vector{String}:
# "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"
# "Wie geht es Ihnen heute?"
# "Ich bin sooo müde, Mann..."

```

## Resources 

-  [Deep API documentation](https://developers.deepl.com/docs/getting-started/intro).
