# DeepL.jl

DeepL SDK in Julia. The package currently implements only the most basic functionality: translating a string of text.


## Usage 
The library can be used as follows: 

```julia 
using DeepL

text = "Good morning, I would like a tea and some cake";

translate_text(text, "EN", "DE")
# "Guten Morgen, ich hätte gerne einen Tee und ein Stück Kuchen"


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