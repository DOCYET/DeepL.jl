# Changelog

## [0.1.1] - 2025-06-03

### Fixed 
- rename: repo from DeepL to DeepL.jl
  
## [0.1.0] - 2025-06-03
 
### Added
- chore: initial release of the DeepL.jl package.
- feat: `translate_text` function for translating a single string of text.
- feat: `translate_text` function for translating multiple strings of text.

### Notes
- The package requires the `DEEPL_API_KEY` environment variable to be set for authentication.
- The package currently supports translation between specified source and target languages, defaulting to German ("DE") and English ("EN") respectively.
********