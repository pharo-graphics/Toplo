Class {
	#name : #ToBeeThemeGenerated,
	#superclass : #ToEmptyStyleSheetThemeGenerated,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'accessing - generated' }
ToBeeThemeGenerated class >> defaultTokenProperties [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-15 16:53:33"
  ^{(ToTokenProperty name: #'background-color' value: Color white) . 
  (ToTokenProperty name: #'border-radius' value: 6) . 
  (ToTokenProperty name: #'border-radius-large' value: 8) . 
  (ToTokenProperty name: #'border-radius-small' value: 4) . 
  (ToTokenProperty name: #'animation-window-opening' value: [:win |  win opacity: 0.3.
        win addAnimation: ((BlOpacityAnimation new opacity: 1.8) duration: 600 milliSeconds) ]) . 
  (ToTokenProperty name: #'color-bg-container' value: Color white) . 
  (ToTokenProperty name: #'color-bg-container-disabled' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.0392156862745098)) . 
  (ToTokenProperty name: #'color-bg-tooltip' value: Color white) . 
  (ToTokenProperty name: #'color-bg-text-active' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.14901960784313725)) . 
  (ToTokenProperty name: #'color-bg-text-hover' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.2)) . 
  (ToTokenProperty name: #'color-border' value: (Color r: 0.8514173998044966 g: 0.8514173998044966 b: 0.8514173998044966 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-border-checkable' value: Color transparent) . 
  (ToTokenProperty name: #'color-border-disabled' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.2)) . 
  (ToTokenProperty name: #'color-error-bg' value: (Color r: 1.0 g: 0.9491691104594331 b: 0.9413489736070382 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-error-hover' value: (Color r: 1.0 g: 0.4701857282502444 b: 0.458455522971652 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-error-pressed' value: (Color r: 0.906158357771261 g: 0.36070381231671556 b: 0.364613880742913 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-error' value: (Color r: 1.0 g: 0.3020527859237537 b: 0.3098729227761486 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-image-disabled' value: Color black) . 
  (ToTokenProperty name: #'color-image-light-solid' value: Color white) . 
  (ToTokenProperty name: #'color-link' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-link-active' value: (Color r: 0.03519061583577713 g: 0.34506353861192574 b: 0.8514173998044966 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-link-hover' value: (Color r: 0.4115347018572825 g: 0.6940371456500489 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-primary' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-primary-pressed' value: (Color r: 0.06549364613880743 g: 0.3548387096774194 b: 0.7595307917888563 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-primary-hover' value: (Color r: 0.2072336265884653 g: 0.5366568914956011 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-success' value: (Color r: 0.32160312805474095 g: 0.7683284457478006 b: 0.10166177908113393 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-warning' value: (Color r: 0.9804496578690127 g: 0.678396871945259 b: 0.07820136852394917 alpha: 1.0)) . 
  (ToTokenProperty name: #'color-text' value: Color black) . 
  (ToTokenProperty name: #'color-text-description' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.4470588235294118)) . 
  (ToTokenProperty name: #'color-text-disabled' value: Color lightGray) . 
  (ToTokenProperty name: #'color-text-heading' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.8784313725490196)) . 
  (ToTokenProperty name: #'color-text-light-solid' value: Color white) . 
  (ToTokenProperty name: #'color-text-secondary' value: (Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.4470588235294118)) . 
  (ToTokenProperty name: #'text-foreground-in-tooltip' value: (Color r: 0.19257086999022482 g: 0.20039100684261973 b: 0.2238514173998045 alpha: 1.0)) . 
  (ToTokenProperty name: #'dash-array' value: #(3 3)) . 
  (ToTokenProperty name: #'font-family-code' value: 'SFMono-Regular') . 
  (ToTokenProperty name: #'font-size' value: 14) . 
  (ToTokenProperty name: #'font-size-in-tooltip' value: 12) . 
  (ToTokenProperty name: #'font-size-H1' value: 38) . 
  (ToTokenProperty name: #'font-size-H2' value: 30) . 
  (ToTokenProperty name: #'font-size-H3' value: 24) . 
  (ToTokenProperty name: #'font-size-H4' value: 20) . 
  (ToTokenProperty name: #'font-size-H5' value: 16) . 
  (ToTokenProperty name: #'font-weight-strong' value: 600) . 
  (ToTokenProperty name: #'line-height' value: 1.5) . 
  (ToTokenProperty name: #'line-height-H1' value: 1.2) . 
  (ToTokenProperty name: #'line-height-H2' value: 1.3) . 
  (ToTokenProperty name: #'line-height-H3' value: 1.3) . 
  (ToTokenProperty name: #'line-height-H4' value: 1.4) . 
  (ToTokenProperty name: #'line-height-H5' value: 1.5) . 
  (ToTokenProperty name: #'line-type' value: #solid) . 
  (ToTokenProperty name: #'line-width' value: 1) . 
  (ToTokenProperty name: #'focus-border-width' value: 2) . 
  (ToTokenProperty name: #'focus-border-paint' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'border-width' value: 1) . 
  (ToTokenProperty name: #'border-paint' value: Color lightGray) . 
  (ToTokenProperty name: #'control-height' value: 32) . 
  (ToTokenProperty name: #'control-height-large' value: 40) . 
  (ToTokenProperty name: #'control-height-small' value: 24) . 
  (ToTokenProperty name: #'margin-XS' value: 8) . 
  (ToTokenProperty name: #'padding-content-H' value: 15) . 
  (ToTokenProperty name: #'padding-content-V' value: 4) . 
  (ToTokenProperty name: #'padding-content-V-S' value: 2) . 
  (ToTokenProperty name: #'padding-content-V-XS' value: 0) . 
  (ToTokenProperty name: #'padding-XS' value: 8) . 
  (ToTokenProperty name: #'list-infinite-padding-H' value: 4) . 
  (ToTokenProperty name: #'list-infinite-padding-V' value: 1) . 
  (ToTokenProperty name: #'list-padding-H' value: 1) . 
  (ToTokenProperty name: #'list-padding-V' value: 1) . 
  (ToTokenProperty name: #'list-node-padding-H' value: 2) . 
  (ToTokenProperty name: #'list-node-padding-V' value: 1) . 
  (ToTokenProperty name: #'text-editor-padding-H' value: 3) . 
  (ToTokenProperty name: #'text-editor-padding-V' value: 2) . 
  (ToTokenProperty name: #'checkbox-image-builder' value: [ self defaultCheckboxBlankImage ]) . 
  (ToTokenProperty name: #'switch-checked-background' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'switch-unchecked-background' value: Color lightGray) . 
  (ToTokenProperty name: #'switch-disabled-background' value: Color lightGray) . 
  (ToTokenProperty name: #'switch-handle-disabled-background' value: Color veryLightGray) . 
  (ToTokenProperty name: #'switch-handle-enabled-background' value: Color white) . 
  (ToTokenProperty name: #'color-primary-selection-focused' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 0.6)) . 
  (ToTokenProperty name: #'color-primary-selection-unfocused' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 0.09803921568627451)) . 
  (ToTokenProperty name: #'border-width-primary-selection' value: 1) . 
  (ToTokenProperty name: #'border-color-primary-selection' value: (Color r: 0.08602150537634409 g: 0.4662756598240469 b: 1.0 alpha: 1.0)) . 
  (ToTokenProperty name: #'height-normal' value: 24) . 
  (ToTokenProperty name: #'color-primary-text' value: Color white) . 
  (ToTokenProperty name: #'color-primary-text' value: Color white)}
]

{ #category : #'scripting - generated' }
ToBeeThemeGenerated class >> edit [
  < script>
  ToThemeEditorPresenter new
     theme: self new;
     open
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-15 16:53:33"
  self initializeToLabeledIconStyleRules.
  self initializeToLabelStyleRules.
  self initializeToButtonStyleRules.
  self select: #'space-root' asIdSelector style: [ self when: ToInstallSkinEvent write: (self property: #background) with: [:e |  e valueOfTokenNamed: #'background-color' ] animation: nil ]
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeToButtonStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-15 16:53:33"
  self select: ToButton asTypeSelector style: [ self when: ToHoveredSkinEvent write: (self property: #mouseCursor) with: [:e |  e isEnabled ifTrue: [ Cursor webLink ] ifFalse: [  ] ] animation: nil.
        self when: ToLeavedSkinEvent write: (self property: #mouseCursor) with: nil animation: nil.
        self when: ToDisabledSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container-disabled' ] animation: nil.
        self when: ToInstallSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container' ] animation: nil.
        self when: ToInstallSkinEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height' ] animation: nil.
        self when: ToInstallSkinEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius') ] animation: nil.
        self when: ToUninstallSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container' ] animation: nil.
        self when: ToUninstallSkinEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height' ] animation: nil.
        self when: ToUninstallSkinEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius') ] animation: nil.
        self when: ToInstallSkinEvent write: (self property: #'border-with-builder') with: [:e |  e borderBuilder
                 dashArray: #();
                 paint: (e valueOfTokenNamed: #'color-border');
                 width: (e valueOfTokenNamed: #'border-width-primary-selection') ] animation: nil.
        self when: ToUninstallSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder
                 dashArray: #();
                 paint: (e valueOfTokenNamed: #'color-border');
                 width: (e valueOfTokenNamed: #'border-width-primary-selection') ] animation: nil.
        self when: ToHoveredSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary-hover' ] animation: nil.
        self when: ToHoveredSkinEvent write: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: (e valueOfTokenNamed: #'color-primary-hover') ] animation: nil.
        self when: ToLeavedSkinEvent write: (self property: #'border-with-builder') with: [:e |  e borderBuilder
                 dashArray: #();
                 paint: (e valueOfTokenNamed: #'color-border');
                 width: (e valueOfTokenNamed: #'border-width-primary-selection') ] animation: nil.
        self when: ToInstallSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text' ] animation: nil.
        self when: ToUninstallSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text' ] animation: nil.
        self when: ToLeavedSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text' ] animation: nil.
        self when: ToPressedSkinEvent write: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: (e valueOfTokenNamed: #'color-primary-pressed') ] animation: nil.
        self when: ToPressedSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary-pressed' ] animation: nil.
        self select: #'small-sizing' asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height-small' ] animation: nil.
              self when: ToInstallSkinEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius-small') ] animation: nil ].
        self select: #'large-sizing' asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #height) with: [:e |  e valueOfTokenNamed: #'control-height-large' ] animation: nil.
              self when: ToInstallSkinEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: 'border-radius-large') ] animation: nil ].
        self select: #round asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #geometry) with: [:e |  BlRoundedRectangleGeometry cornerRadius: e requestedHeight ] animation: nil ].
        self select: #text asStampSelector || #link asStampSelector style: [ self when: ToInstallSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: Color transparent ] animation: nil.
              self when: ToHoveredSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: Color transparent ] animation: nil.
              self when: ToLeavedSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: Color transparent ] animation: nil.
              self when: ToPressedSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: Color transparent ] animation: nil ].
        self select: #primary asStampSelector style: [ self when: ToInstallSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: (e valueOfTokenNamed: #'color-primary') ] animation: nil.
              self when: ToInstallSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-primary' ] animation: nil.
              self when: ToInstallSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary-text' ] animation: nil.
              self when: ToPressedSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary-text' ] animation: nil.
              self when: ToHoveredSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary-text' ] animation: nil.
              self when: ToLeavedSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary-text' ] animation: nil.
              self when: ToLeavedSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder paint: (e valueOfTokenNamed: #'color-primary') ] animation: nil.
              self when: ToHoveredSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-primary-hover' ] animation: nil.
              self when: ToLeavedSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-primary' ] animation: nil.
              self when: ToPressedSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-primary-pressed' ] animation: nil ].
        self select: #dashed asStampSelector style: [ self when: ToInstallSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder dashArray: (e valueOfTokenNamed: #'dash-array') ] animation: nil.
              self when: ToHoveredSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder dashArray: (e valueOfTokenNamed: #'dash-array') ] animation: nil.
              self when: ToLeavedSkinEvent supplement: (self property: #'border-with-builder') with: [:e |  e borderBuilder dashArray: (e valueOfTokenNamed: #'dash-array') ] animation: nil ].
        self select: #text asStampSelector style: [ self when: ToLeavedSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-container' ] animation: nil.
              self when: ToPressedSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-text-hover' ] animation: nil.
              self when: ToHoveredSkinEvent write: (self property: #'background-color') with: [:e |  e valueOfTokenNamed: #'color-bg-text-active' ] animation: nil.
              self when: ToHoveredSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text' ] animation: nil.
              self when: ToPressedSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-text' ] animation: nil ].
        self select: #link asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary' ] animation: nil.
              self when: ToLeavedSkinEvent write: (self property: #'button-label-text-foreground') with: [:e |  e valueOfTokenNamed: #'color-primary' ] animation: nil ] ]
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeToLabelStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-15 16:53:33"
  self select: ToLabel asTypeSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                 weight: (e valueOfTokenNamed: #'font-weight-strong');
                 defaultFontName: (e valueOfTokenNamed: #'font-family-code');
                 defaultFontSize: (e valueOfTokenNamed: #'font-size');
                 lineSpacing: (e valueOfTokenNamed: #'line-height');
                 yourself ] animation: nil.
        self when: ToDisabledSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder foreground: (e valueOfTokenNamed: #'color-text-disabled') ] animation: nil.
        self select: #H1 asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H1');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H1');
                       yourself ] animation: nil ].
        self select: #H2 asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H2');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H2');
                       yourself ] animation: nil ].
        self select: #H3 asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H3');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H3');
                       yourself ] animation: nil ].
        self select: #H4 asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H4');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H4');
                       yourself ] animation: nil ].
        self select: #H5 asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       defaultFontSize: (e valueOfTokenNamed: #'font-size-H5');
                       lineSpacing: (e valueOfTokenNamed: #'line-height-H5');
                       yourself ] animation: nil ].
        self select: #default asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text');
                       yourself ] animation: nil ].
        self select: #danger asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-error');
                       yourself ] animation: nil ].
        self select: #link asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-link');
                       yourself ] animation: nil ].
        self select: #primary asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text-light-solid');
                       yourself ] animation: nil ].
        self select: #secondary asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-text-secondary');
                       yourself ] animation: nil ].
        self select: #success asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-success');
                       yourself ] animation: nil ].
        self select: #warning asStampSelector style: [ self when: ToInstallSkinEvent write: (self property: #'text-attributes-with-builder') with: [:e |  e textAttributesBuilder
                       foreground: (e valueOfTokenNamed: #'color-warning');
                       yourself ] animation: nil ] ]
]

{ #category : #'initialization - generated' }
ToBeeThemeGenerated >> initializeToLabeledIconStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-15 16:53:33"
  self select: ToLabeledIcon asTypeSelector style: [ self when: ToInstallSkinEvent write: (self property: #layout) with: [:e |  BlLinearLayout horizontal ] animation: nil.
        self when: ToInstallSkinEvent write: (self property: #'layout-constraints') with: [:e |  [:c |  c horizontal fitContent.
              c vertical fitContent.
              c linear vertical alignCenter.
              c linear horizontal alignCenter ] ] animation: nil.
        self select: ((ToUniversalSelector new withParent: ToButton asTypeSelector atDepth: 1) withParent: #'icon-first' asStampSelector atDepth: 1) style: [ self when: ToInstallSkinEvent write: (self property: #'layout-direction') with: [:e |  BlLayoutDirection leftToRight ] animation: nil ].
        self select: ((ToUniversalSelector new withParent: ToButton asTypeSelector atDepth: 1) withParent: #'label-first' asStampSelector atDepth: 1) style: [ self when: ToInstallSkinEvent write: (self property: #'layout-direction') with: [:e |  BlLayoutDirection rightToLeft ] animation: nil ] ]
]
