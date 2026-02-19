# Public API
# ----------

"""
	detect_language(text::AbstractString)

Detect the language of the given text using the DeepL API. The env variable `DEEPL_API_KEY` must be set.

Since the DeepL API does not provide a dedicated language detection endpoint, this function
uses the translate endpoint without specifying a source language and extracts the detected
language from the response.

# Arguments
- `text::AbstractString`: The text whose language should be detected.

# Returns
- `String`: The detected language code (e.g. "DE", "EN", "FR").
"""
function detect_language(text::AbstractString)
	isempty(text) && throw(ArgumentError("text must not be empty"))

	body = Dict("text" => [text], "target_lang" => "EN")

	response = post_request("/translate", body)
	handle_api_error(response)
	result = JSON.parse(String(response.body))
	return result["translations"][1]["detected_source_language"]
end

"""
	detect_language(text::Vector{<:AbstractString})

Detect the language of each text in the given vector using the DeepL API. The env variable `DEEPL_API_KEY` must be set.

# Arguments
- `text::Vector{<:AbstractString}`: The texts whose languages should be detected.

# Returns
- `Vector{String}`: The detected language codes (e.g. ["DE", "EN", "FR"]).
"""
function detect_language(text::Vector{<:AbstractString})
	isempty(text) && throw(ArgumentError("text must not be empty"))

	body = Dict("text" => text, "target_lang" => "EN")

	response = post_request("/translate", body)
	handle_api_error(response)
	result = JSON.parse(String(response.body))
	return [t["detected_source_language"] for t in result["translations"]]
end
