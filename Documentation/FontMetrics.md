# FontMetrics

A `UIFontMetrics` wrapper, allowing iOS 11 devices to take advantage of `UIFontMetrics` scaling,
while earlier iOS versions fall back on a scale calculation.

``` swift
public struct FontMetrics
```

## Properties

## scaler

A scale value based on the current device text size setting. With the device using the
default Large setting, `scaler` will be `1.0`. Only used when `UIFontMetrics` is not
available.

``` swift
var scaler: CGFloat
```

## Methods

## scaledFont(for:)

Returns a version of the specified font that adopts the current font metrics.

``` swift
public static func scaledFont(for font: UIFont) -> UIFont
```

  - Parameter font: A font at its default point size.

### Returns

The font at its scaled point size.

## scaledFont(for:maximumPointSize:)

Returns a version of the specified font that adopts the current font metrics and is
constrained to the specified maximum size.

``` swift
public static func scaledFont(for font: UIFont, maximumPointSize: CGFloat) -> UIFont
```

### Parameters

  - font: A font at its default point size.
  - maximumPointSize: The maximum point size to scale up to.

### Returns

The font at its constrained scaled point size.

## scaledValue(for:)

Scales an arbitrary layout value based on the current Dynamic Type settings.

``` swift
public static func scaledValue(for value: CGFloat) -> CGFloat
```

  - Parameter value: A default size value.

### Returns

The value scaled based on current Dynamic Type settings.