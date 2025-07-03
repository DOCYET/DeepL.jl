"""
	translate_text(text::String, source_lang::String = "DE", target_lang::String = "EN")

Translate text using the DeepL API. The env variable `DEEPL_API_KEY` must be set.
# Arguments
- `text::String`: The text to translate.
- `source_lang::String`: The source language. Defaults to "DE".
- `target_lang::String`: The target language. Defaults to "EN".

# Returns
- `String`: The translated text.
"""
function translate_text(
    text::AbstractString,
    source_lang::String = "DE",
    target_lang::String = "EN",
)
    if isempty(text) || source_lang == target_lang
        return text
    end
    headers = Dict(
        "Authorization" => "DeepL-Auth-Key " * DEEPL_API_KEY,
        "Content-Type" => "application/json",
    )
    body = JSON.json(
        Dict("text" => [text], "source_lang" => source_lang, "target_lang" => target_lang),
    )
    url = DEEPL_API_URL * "/translate"
    response = HTTP.post(url, headers, body)
    error_message = handle_api_error(response)
    if !isempty(error_message)
        return error_message
    end
    result = JSON.parse(String(response.body))
    return result["translations"][1]["text"]
end

"""
	translate_text(text::Vector{String}, source_lang::String = "DE", target_lang::String = "EN")

Translate multiple text using the DeepL API. The env variable `DEEPL_API_KEY` must be set.
# Arguments
- `text::Vector{String}`: The list of texts to translate.
- `source_lang::String`: The source language. Defaults to "DE".
- `target_lang::String`: The target language. Defaults to "EN".

# Returns
- `Vector{String}`: The translated text.
"""
function translate_text(
    text::Vector{<:AbstractString},
    source_lang::String = "DE",
    target_lang::String = "EN",
)
    if isempty(text) || source_lang == target_lang
        return text
    end
    headers = Dict(
        "Authorization" => "DeepL-Auth-Key " * DEEPL_API_KEY,
        "Content-Type" => "application/json",
    )
    body = JSON.json(
        Dict("text" => text, "source_lang" => source_lang, "target_lang" => target_lang),
    )
    url = DEEPL_API_URL * "/translate"
    response = HTTP.post(url, headers, body)
    error_message = handle_api_error(response)
    if !isempty(error_message)
        return [error_message]
    end
    result = JSON.parse(String(response.body))
    return [t["text"] for t in result["translations"]]
end

"""
	translate_document(file_path::String, source_lang::String = "DE", target_lang::String = "EN")

Translate a document using the DeepL API. The env variable `DEEPL_API_KEY` must be set.
# Arguments
- `file_path::String`: The path to the document to translate.
- `source_lang::String`: The source language. Defaults to "DE".
- `target_lang::String`: The target language. Defaults to "EN".

# Returns
- `String`: The translated document content or an error message if not implemented.
"""
function translate_document(
    file_path::AbstractString,
    source_lang::String = "DE",
    target_lang::String = "EN",
)
    # Placeholder for document translation functionality
    return "Document translation is not implemented in this SDK."
end
