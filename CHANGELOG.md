# Changelog

## [0.3.0] - 2026-02-19

No breaking changes

### Added
- feat: `detect_language` function for detecting the language of a single string of text
- feat: `detect_language` function for detecting the language of multiple strings of text
- feat: `get_languages` function to retrieve the list of supported source or target languages from the DeepL API
- feat: `CLAUDE.md` file

### Notes
Since the DeepL API does not provide a dedicated language detection endpoint, `detect_language` uses the translate endpoint internally and extracts the `detected_source_language` field from the response.

## [0.2.0] - 2025-06-03

No breaking changes 

### Added 
- feat: add alternative syntax for `translate_text` using a `Pair{String, String}` to specify the source and target languages
- feat: add alternative syntax that requires to only specify the target langauge, allowing DeepL to infer the source language
- feat: GitHub Actions pipeline with Unit Testing

## [0.1.0] - 2025-06-03
 
### Added
- chore: initial release of the DeepL.jl package.
- feat: `translate_text` function for translating a single string of text.
- feat: `translate_text` function for translating multiple strings of text.

### Notes
- The package requires the `DEEPL_API_KEY` environment variable to be set for authentication.
- The package currently supports translation between specified source and target languages, defaulting to German ("DE") and English ("EN") respectively.
********