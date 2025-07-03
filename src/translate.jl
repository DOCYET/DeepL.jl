# Constants 
# --------- 
const SUPPORTED_SOURCE_LANGUAGES = [
	"AR",     # Arabic
	"BG",     # Bulgarian
	"CS",     # Czech
	"DA",     # Danish
	"DE",     # German
	"EL",     # Greek
	"EN",     # English
	"ES",     # Spanish
	"ET",     # Estonian
	"FI",     # Finnish
	"FR",     # French
	"HE",     # Hebrew
	"HU",     # Hungarian
	"ID",     # Indonesian
	"IT",     # Italian
	"JA",     # Japanese
	"KO",     # Korean
	"LT",     # Lithuanian
	"LV",     # Latvian
	"NB",     # Norwegian Bokmål
	"NL",     # Dutch
	"PL",     # Polish
	"PT",     # Portuguese
	"RO",     # Romanian
	"RU",     # Russian
	"SK",     # Slovak
	"SL",     # Slovenian
	"SV",     # Swedish
	"TH",     # Thai
	"TR",     # Turkish
	"UK",     # Ukrainian
	"VI",     # Vietnamese
	"ZH"      # Chinese
]

const SUPPORTED_TARGET_LANGUAGES = [
	"AR",     # Arabic
	"BG",     # Bulgarian
	"CS",     # Czech
	"DA",     # Danish
	"DE",     # German
	"EL",     # Greek
	"EN",     # English
	"EN-GB",  # English (British)
	"EN-US",  # English (American)
	"ES",     # Spanish
	"ET",     # Estonian
	"FI",     # Finnish
	"FR",     # French
	"HE",     # Hebrew
	"HU",     # Hungarian
	"ID",     # Indonesian
	"IT",     # Italian
	"JA",     # Japanese
	"KO",     # Korean
	"LT",     # Lithuanian
	"LV",     # Latvian
	"NB",     # Norwegian Bokmål
	"NL",     # Dutch
	"PL",     # Polish
	"PT",     # Portuguese
	"PT-BR",  # Portuguese (Brazilian)
	"PT-PT",  # Portuguese (European)
	"RO",     # Romanian
	"RU",     # Russian
	"SK",     # Slovak
	"SL",     # Slovenian
	"SV",     # Swedish
	"TH",     # Thai
	"TR",     # Turkish
	"UK",     # Ukrainian
	"VI",     # Vietnamese
	"ZH",     # Chinese
	"ZH-HANS",# Chinese (Simplified)
	"ZH-HANT" # Chinese (Traditional)
]


# Public API
# -------------

"""
	translate_text(text::String, source_lang::String = "DE", target_lang::String = "EN")

Translate text using the DeepL API. The env variable `DEEPL_API_KEY` must be set.
# Arguments
- `text::String`: The text to translate.
- `source_lang::Optional{String}`: The source language. If not provided, the API will try to detect the language.
- `target_lang::String`: The target language.

# Returns
- `String`: The translated text.
"""
function translate_text(
	text::AbstractString,
	source_lang::Optional{String},
	target_lang::String,
)
	# guard: if no translation is needed, return the text to avoid unnecessary API calls
	(isempty(text) || source_lang == target_lang) && return text

	# guard: check if the source and target languages are supported
	!isnothing(source_lang) && !in(source_lang, SUPPORTED_SOURCE_LANGUAGES) && 
		throw(ArgumentError("source language '$source_lang' is not supported"))
	!in(target_lang, SUPPORTED_TARGET_LANGUAGES) && 
		throw(ArgumentError("target language '$target_lang' is not supported"))

	body = Dict("text" => [text], "target_lang" => target_lang)
	!isnothing(source_lang) && (body["source_lang"] = source_lang)

	response = post_request("/translate", body)
	error_message = handle_api_error(response)
	if !isempty(error_message)
		return error_message
	end
	result = JSON.parse(String(response.body))
	return result["translations"][1]["text"]
end

translate_text(text::AbstractString, translation::Pair{String, String}) = translate_text(text, translation.first, translation.second)
translate_text(text::AbstractString, target_lang::String) = translate_text(text, nothing, target_lang)


"""
	translate_text(text::Vector{String}, source_lang::String = "DE", target_lang::String = "EN")

Translate multiple text using the DeepL API. The env variable `DEEPL_API_KEY` must be set.
# Arguments
- `text::Vector{String}`: The list of texts to translate.
- `source_lang::Optional{String}`: The source language. If not provided, the API will try to detect the language.
- `target_lang::String`: The target language.

# Returns
- `Vector{String}`: The translated text.
"""
function translate_text(
	text::Vector{<:AbstractString},
	source_lang::Optional{String},
	target_lang::String,
)
	# guard: if no translation is needed, return the text to avoid unnecessary API calls
	(isempty(text) || source_lang == target_lang) && return text

	# guard: check if the source and target languages are supported
	!isnothing(source_lang) && !in(source_lang, SUPPORTED_SOURCE_LANGUAGES) && 
		throw(ArgumentError("source language '$source_lang' is not supported"))
	!in(target_lang, SUPPORTED_TARGET_LANGUAGES) && 
		throw(ArgumentError("target language '$target_lang' is not supported"))

	body = Dict("text" => text, "target_lang" => target_lang)
	!isnothing(source_lang) && (body["source_lang"] = source_lang)

	response = post_request("/translate", body)
	error_message = handle_api_error(response)
	if !isempty(error_message)
		return [error_message]
	end
	result = JSON.parse(String(response.body))
	return [t["text"] for t in result["translations"]]
end

function translate_text(text::Vector{<:AbstractString}, translation::Pair{String, String})
	return translate_text(text, translation.first, translation.second)
end

function translate_text(text::Vector{<:AbstractString}, target_lang::String)
	return translate_text(text, nothing, target_lang)
end


