# oapi-codegen v2.5.0 Updates

This document outlines the updates made to support the latest oapi-codegen v2.5.0 release.

## 🎉 New Features Added

### 1. `x-omitzero` Extension Support

Added `x-omitzero` extensions throughout the API schema to leverage Go 1.24+ `omitzero` JSON tags. Removed all legacy `x-go-type-skip-optional-pointer` extensions in favor of the new `x-omitzero` approach:

- **Required fields**: Set `x-omitzero: false` to ensure they're always included in JSON
- **Optional fields**: Set `x-omitzero: true` to use `omitzero` tags for better zero-value handling

**Example:**
```yaml
properties:
  message:
    type: string
    x-omitzero: false  # Always include in JSON
  priority:
    type: integer
    x-omitzero: true   # Use omitzero tag
```

**Migration:** All `x-go-type-skip-optional-pointer: true` extensions have been replaced with `x-omitzero: true` for better compatibility with Go 1.24+.

### 2. Enhanced Configuration File

Created `oapi-codegen-config.yaml` with new v2.5.0 features:

#### Global Optional Pointer Control
```yaml
output-options:
  # Skip optional pointers globally
  prefer-skip-optional-pointer: false
  
  # Use omitzero with skip optional pointers (Go 1.24+)
  # prefer-skip-optional-pointer-with-omitzero: false
```

#### Custom Initialisms
```yaml
output-options:
  name-normalizer: ToCamelCaseWithInitialisms
  additional-initialisms:
    - API
    - ID
    - UUID
    - HTTP
    - JSON
    - gRPC
    - CSP
```

### 3. Improved Schema Definitions

Updated all schema properties with appropriate `x-omitzero` values:

- **Required fields**: `x-omitzero: false`
- **Optional fields with defaults**: `x-omitzero: true`
- **Optional fields without defaults**: `x-omitzero: true`

## 🔧 Configuration Options

### Using the New Configuration

1. **Generate with new config:**
   ```bash
   go run github.com/deepmap/oapi-codegen/v2/cmd/oapi-codegen --config=oapi-codegen-config.yaml api.yaml
   ```

2. **Enable omitzero support (Go 1.24+):**
   ```yaml
   output-options:
     prefer-skip-optional-pointer: true
     prefer-skip-optional-pointer-with-omitzero: true
   ```

3. **Add custom initialisms:**
   ```yaml
   output-options:
     name-normalizer: ToCamelCaseWithInitialisms
     additional-initialisms:
       - YOUR_CUSTOM_ACRONYM
   ```

## 📋 Requirements

- **oapi-codegen**: v2.5.0+
- **Go version**: 1.22.5+ (minimum), 1.24+ (for omitzero features)
- **go.mod**: Should include `go 1.24` directive for omitzero support

## 🚀 Benefits

1. **Better JSON handling**: `omitzero` tags provide more precise control over JSON serialization
2. **Reduced boilerplate**: Global optional pointer control reduces repetitive field annotations
3. **Improved naming**: Custom initialisms ensure consistent naming conventions
4. **Future-proof**: Ready for OpenAPI 3.1 support when available
5. **Cleaner schema**: Removed legacy extensions in favor of modern approaches

## 🔄 Migration Notes

- Existing generated code will continue to work
- New features are opt-in via configuration
- `x-omitzero` extensions are backward compatible
- All legacy `x-go-type-skip-optional-pointer` extensions have been removed
- Minimum Go version requirement increased to 1.22.5

## 🧹 Cleanup Summary

### Removed Extensions
- `x-go-type-skip-optional-pointer: true` - Replaced with `x-omitzero: true`
- All legacy optional pointer controls - Now handled globally via configuration

### Added Extensions
- `x-omitzero: true` - For optional fields
- `x-omitzero: false` - For required fields

## 📚 References

- [oapi-codegen v2.5.0 Release Notes](https://github.com/oapi-codegen/oapi-codegen/releases/tag/v2.5.0)
- [Go 1.24 omitzero Documentation](https://go.dev/doc/go1.24#encoding/json)
- [OpenAPI 3.1 Support Discussion](https://github.com/oapi-codegen/oapi-codegen/issues/373)
