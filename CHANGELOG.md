# Changelog

## [Unreleased](https://github.com/gusbrs/zref-vario/compare/v0.1.9...HEAD)

### Changed
- Don't use `expl3` public scratch temporary variables.
- Prefer `e-type` expansion.
- Require 2023-11-01 LaTeX kernel.

## [v0.1.9](https://github.com/gusbrs/zref-vario/compare/v0.1.8...v0.1.9) (2023-08-15)

### Changed
- `zref-vario` no longer delays the loading of `varioref`.  So there's no
  longer need to load the latter separately but, on the other hand,
  `zref-vario` becomes subject to the same load order restrictions as
  `varioref`.
- Use `\label` instead of `\zlabel` in regression tests.

## [v0.1.8](https://github.com/gusbrs/zref-vario/compare/v0.1.7...v0.1.8) (2023-06-14)

### Changed
- Improvements to User manual.
- Simplify and improve regression tests.

## [v0.1.7](https://github.com/gusbrs/zref-vario/compare/v0.1.6...v0.1.7) (2023-01-03)

### Changed
- Improved Italian localization (see issue
  [#1](https://github.com/gusbrs/zref-vario/issues/1)).

## [v0.1.6](https://github.com/gusbrs/zref-vario/compare/v0.1.5...v0.1.6) (2022-12-29)

### Added
- Hyperlinking for the nearby page references and for the page part of paired
  references.
- Localization for Italian.

## [v0.1.5](https://github.com/gusbrs/zref-vario/compare/v0.1.4...v0.1.5) (2022-07-08)

### Added
- `\zvsetup` for package options settings.
- `pageprop` option to set the reference property used for page comparisons.
  This option lifts `varioref`'s restriction of depending on the arabic page
  numbering to distinguish between nearby and far away references.  See the
  user manual for details.

## [v0.1.4](https://github.com/gusbrs/zref-vario/compare/v0.1.3-alpha...v0.1.4) (2022-04-24)

### Changed
- Improved loading of dependencies.

## [v0.1.3-alpha](https://github.com/gusbrs/zref-vario/compare/v0.1.2-alpha...v0.1.3-alpha) (2022-02-11)

### Changed
- (Internal) Option variables setting was reviewed, ensuring proper scope is
  in use and that they are always properly declared.  `expl3` debugging
  enabled in regression tests.

## [v0.1.2-alpha](https://github.com/gusbrs/zref-vario/compare/v0.1.1-alpha...v0.1.2-alpha) (2022-02-08)

### Added
- Integration with `zref-check` and new corresponding option `vcheck`.

## [v0.1.1-alpha](https://github.com/gusbrs/zref-vario/compare/v0.1.0-alpha...v0.1.1-alpha) (2022-02-01)

### Changed
- Improved loading setup of required packages.

## [v0.1.0-alpha](https://github.com/gusbrs/zref-vario/releases/tag/v0.1.0-alpha) (2022-01-31)

### Added
- Initial release.
