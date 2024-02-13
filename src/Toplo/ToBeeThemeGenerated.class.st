Class {
	#name : #ToBeeThemeGenerated,
	#superclass : #ToGeneratedStyleSheetTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'accessing - generated' }
ToBeeThemeGenerated class >> defaultTokenProperties [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-13 16:53:35"
  ^{(ToTokenProperty name: #'animation-window-opening' value: [:win |  win opacity: 0.3.
        win addAnimation: ((BlOpacityAnimation new opacity: 1.8) duration: 600 milliSeconds) ]) . 
  (ToTokenProperty name: #'checkbox-image-builder' value: [ self defaultCheckboxBlankImage ])}
]

{ #category : #'as yet unclassified' }
ToBeeThemeGenerated class >> edit [

	<script>
	ToThemeEditorPresenter new theme: self light; open.
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initialiazeStyleRules [
  "This class has been generated using ToThemeToSourceCodeVisitor.

	By: YannLEGOFF
	2024-02-13 13:49:10"
  self select: #'space-root' asIdSelector style: [ self when: ToInstallLookEvent write: (self property: #background) with: [:e |  e valueOfTokenNamed: #'background-color' ] animation: nil ].
  self select: ToLabel asTypeSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                 weight: (e valueOfTokenNamed: #'font-weight-strong');
                 defaultFontName: (e valueOfTokenNamed: #'font-family-code');
                 defaultFontSize: (e valueOfTokenNamed: #'font-size');
                 lineSpacing: (e valueOfTokenNamed: #'line-height');
                 yourself ] animation: nil.
        self when: ToDisabledLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder foreground: (e valueOfTokenNamed: #'color-text-disabled') ] animation: nil.
        self select: #H1 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H1');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H1');
                       yourself ] animation: nil ].
        self select: #H2 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H2');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H2');
                       yourself ] animation: nil ].
        self select: #H3 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H3');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H3');
                       yourself ] animation: nil ].
        self select: #H4 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H4');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H4');
                       yourself ] animation: nil ].
        self select: #H5 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H5');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H5');
                       yourself ] animation: nil ].
        self select: #default asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text');
                       yourself ] animation: nil ].
        self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-error');
                       yourself ] animation: nil ].
        self select: #link asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-link');
                       yourself ] animation: nil ].
        self select: #primary asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text-light-solid');
                       yourself ] animation: nil ].
        self select: #secondary asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text-secondary');
                       yourself ] animation: nil ].
        self select: #success asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-success');
                       yourself ] animation: nil ].
        self select: #warning asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-warning');
                       yourself ] animation: nil ] ].
  self select: (#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #layout) with: [:e |  BlLinearLayout horizontal ] animation: nil.
        self when: ToInstallLookEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c horizontal fitContent.
              c vertical fitContent.
              c linear vertical alignCenter.
              c linear horizontal alignCenter ] ] animation: nil.
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #flexible asStampSelector atDepth: 1) not style: [ self when: ToInstallLookEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c frame vertical alignCenter.
                    c frame horizontal alignCenter.
                    c linear vertical alignCenter.
                    c linear horizontal alignCenter ] ] animation: nil ].
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #flexible asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c horizontal matchParent.
                    c vertical matchParent ] ] animation: nil ].
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #'icon-first' asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #'layout-direction') with: [:e |  BlLayoutDirection leftToRight ] animation: nil ].
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #'label-first' asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #'layout-direction') with: [:e |  BlLayoutDirection rightToLeft ] animation: nil ] ].
  self select: ToButton asTypeSelector style: [ self when: ToHoveredLookEvent write: (self property: #mouseCursor) with: [:e |  e isEnabled ifTrue: [ Cursor webLink ] ifFalse: [  ] ] animation: nil.
        self when: ToLeavedLookEvent write: (self property: #mouseCursor) with: nil animation: nil.
        self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container-disabled' ] animation: nil.
        self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container' ] animation: nil.
        self select: #vertical asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #padding) with: [:e |  BlInsets top: (e valueOfTokenNamed: #'padding-XS') / 2 left: (e valueOfTokenNamed: #'padding-content-H') / 2 bottom: (e valueOfTokenNamed: #'padding-XS') / 2 right: (e valueOfTokenNamed: #'padding-content-H') / 2 ] animation: nil.
              self select: [:e |  e constraints vertical resizer isExact ] asActionSelector not style: [ self when: ToInstallLookEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height' ] animation: nil ].
              self select: #'large-sizing' asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height-LG' ] animation: nil ].
              self select: #'small-sizing' asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height-SM' ] animation: nil ] ].
        self select: #circle asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius') ] animation: nil.
              self select: #round asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] animation: nil ] ].
        self select: (#dashed asStampSelector || #text asStampSelector || #link asStampSelector) not style: [ self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorder paint: (e valueOfTokenNamed: #'color-border-disabled') width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ] ].
        self select: #link asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ] ].
        self select: #dashed asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                       paint: (e valueOfTokenNamed: #'color-border-disabled');
                       width: (e valueOfTokenNamed: #'line-width');
                       dashArray: (e valueOfTokenNamed: #'dash-array');
                       build ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil ] ].
        self select: #text asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  Color transparent ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself) ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself) ].
              self select: #danger asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ] ].
        self select: #link asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  Color transparent ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ] ].
        self select: #primary asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container-disabled' ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
              self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ] ] ]
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-13 16:53:35"
  self initializeToLabelStyleRules.
  self initializeToButtonStyleRules.
  self select: #'space-root' asIdSelector style: [ self when: ToInstallLookEvent write: (self property: #background) with: [:e |  e valueOfTokenNamed: #'background-color' ] animation: nil ].
  self select: (#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #layout) with: [:e |  BlLinearLayout horizontal ] animation: nil.
        self when: ToInstallLookEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c horizontal fitContent.
              c vertical fitContent.
              c linear vertical alignCenter.
              c linear horizontal alignCenter ] ] animation: nil.
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #flexible asStampSelector atDepth: 1) not style: [ self when: ToInstallLookEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c frame vertical alignCenter.
                    c frame horizontal alignCenter.
                    c linear vertical alignCenter.
                    c linear horizontal alignCenter ] ] animation: nil ].
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #flexible asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c horizontal matchParent.
                    c vertical matchParent ] ] animation: nil ].
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #'icon-first' asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #'layout-direction') with: [:e |  BlLayoutDirection leftToRight ] animation: nil ].
        self select: ((#'labeled-icon' asStampSelector withParent: #button asStampSelector atDepth: 1) withParent: #'label-first' asStampSelector atDepth: 1) style: [ self when: ToInstallLookEvent write: (self property: #'layout-direction') with: [:e |  BlLayoutDirection rightToLeft ] animation: nil ] ]
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeToButtonStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-13 16:53:35"
  self select: ToButton asTypeSelector style: [ self when: ToHoveredLookEvent write: (self property: #mouseCursor) with: [:e |  e isEnabled ifTrue: [ Cursor webLink ] ifFalse: [  ] ] animation: nil.
        self when: ToLeavedLookEvent write: (self property: #mouseCursor) with: nil animation: nil.
        self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container-disabled' ] animation: nil.
        self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container' ] animation: nil.
        self select: #vertical asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #padding) with: [:e |  BlInsets top: (e valueOfTokenNamed: #'padding-XS') / 2 left: (e valueOfTokenNamed: #'padding-content-H') / 2 bottom: (e valueOfTokenNamed: #'padding-XS') / 2 right: (e valueOfTokenNamed: #'padding-content-H') / 2 ] animation: nil.
              self select: [:e |  e constraints vertical resizer isExact ] asActionSelector not style: [ self when: ToInstallLookEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height' ] animation: nil ].
              self select: #'large-sizing' asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height-LG' ] animation: nil ].
              self select: #'small-sizing' asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height-SM' ] animation: nil ] ].
        self select: #circle asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius') ] animation: nil.
              self select: #round asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] animation: nil ] ].
        self select: (#dashed asStampSelector || #text asStampSelector || #link asStampSelector) not style: [ self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorder paint: (e valueOfTokenNamed: #'color-border-disabled') width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ] ].
        self select: #link asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ] ].
        self select: #dashed asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                       paint: (e valueOfTokenNamed: #'color-border-disabled');
                       width: (e valueOfTokenNamed: #'line-width');
                       dashArray: (e valueOfTokenNamed: #'dash-array');
                       build ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             dashArray: (e valueOfTokenNamed: #'dash-array');
                             build ] animation: nil ] ].
        self select: #text asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  Color transparent ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself) ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself) ].
              self select: #danger asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ] ].
        self select: #link asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #border) with: [:e |  BlBorder paint: Color transparent width: (e valueOfTokenNamed: #'line-width') ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  Color transparent ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
                    self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil ] ].
        self select: #primary asStampSelector style: [ self when: ToDisabledLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container-disabled' ] animation: nil.
              self when: ToDisabledLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text-disabled' ] animation: nil.
              self when: ToInstallLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self when: ToLeavedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self when: ToHoveredLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self when: ToPressedLookEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
              self select: #danger asStampSelector not style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ].
              self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #TODO ] animation: (ToPropertyColorTransitionAnimation new
                             duration: 150 milliSeconds;
                             yourself).
                    self when: ToInstallLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil.
                    self when: ToLeavedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToHoveredLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderColorTransitionAnimation new
                             duration: 500 milliSeconds;
                             yourself).
                    self when: ToClickedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: (ToPropertyBorderEffectTransitionAnimation new
                             duration: 350 milliSeconds;
                             yourself).
                    self when: ToPressedLookEvent write: (self property: #border) with: [:e |  BlBorderBuilder new
                             paint: (e valueOfTokenNamed: #TODO);
                             width: (e valueOfTokenNamed: #'line-width');
                             build ] animation: nil ] ] ]
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeToLabelStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-13 16:53:35"
  self select: ToLabel asTypeSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                 weight: (e valueOfTokenNamed: #'font-weight-strong');
                 defaultFontName: (e valueOfTokenNamed: #'font-family-code');
                 defaultFontSize: (e valueOfTokenNamed: #'font-size');
                 lineSpacing: (e valueOfTokenNamed: #'line-height');
                 yourself ] animation: nil.
        self when: ToDisabledLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder foreground: (e valueOfTokenNamed: #'color-text-disabled') ] animation: nil.
        self select: #H1 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H1');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H1');
                       yourself ] animation: nil ].
        self select: #H2 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H2');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H2');
                       yourself ] animation: nil ].
        self select: #H3 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H3');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H3');
                       yourself ] animation: nil ].
        self select: #H4 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H4');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H4');
                       yourself ] animation: nil ].
        self select: #H5 asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H5');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H5');
                       yourself ] animation: nil ].
        self select: #default asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text');
                       yourself ] animation: nil ].
        self select: #danger asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-error');
                       yourself ] animation: nil ].
        self select: #link asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-link');
                       yourself ] animation: nil ].
        self select: #primary asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text-light-solid');
                       yourself ] animation: nil ].
        self select: #secondary asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text-secondary');
                       yourself ] animation: nil ].
        self select: #success asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-success');
                       yourself ] animation: nil ].
        self select: #warning asStampSelector style: [ self when: ToInstallLookEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-warning');
                       yourself ] animation: nil ] ]
]
