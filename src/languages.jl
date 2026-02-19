# Public API
# ----------

"""
	get_languages(type::String="source")

Retrieve the list of languages supported by the DeepL API. The env variable `DEEPL_API_KEY` must be set.

# Arguments
- `type::String`: The type of languages to retrieve. Must be `"source"` or `"target"`. Defaults to `"source"`.

# Returns
- `Vector{Dict{String, Any}}`: A list of language objects, each containing:
  - `"language"`: The language code (e.g. `"DE"`, `"EN"`, `"EN-GB"`).
  - `"name"`: The human-readable language name (e.g. `"German"`, `"English"`).
  - `"supports_formality"`: Whether formality options are available (target languages only).
"""
function get_languages(type::String="source")
	type in ("source", "target") || throw(ArgumentError("type must be \"source\" or \"target\", got \"$type\""))

	response = get_request("/languages"; params=Dict("type" => type))
	handle_api_error(response)
	return JSON.parse(String(response.body))
end
