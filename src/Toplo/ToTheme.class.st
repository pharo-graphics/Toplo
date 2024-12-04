Class {
	#name : #ToTheme,
	#superclass : #Object,
	#instVars : [
		'icons',
		'tokenProperties'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToTheme class >> canBeDefault [

	^ false
]

{ #category : #accessing }
ToTheme class >> defaultCheckboxBlankImage [

	| bar im |
	bar := BlElement new id: #'indeterminate-bar'.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 3.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	bar margin: (BlInsets left: 2 right: 2).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	im := BlElement new id: #'icon-image'.
	im layout: BlFrameLayout new.
	im size: 14 asPoint.
	im addChild: bar.
	im addAllStamps: #( #'inner-image' #unchecked ).
	^ im
]

{ #category : #accessing }
ToTheme class >> defaultColorPrimary [

	^ Color fromHexString: '#1677ff'
]

{ #category : #accessing }
ToTheme class >> defaultTokenProperties [
	" skin managing need a list of unique stamps . "

	^ {
		  (ToTokenProperty
			   name: #'sh-style-table'
			   value: SHRBTextStyler defaultStyleTable).
		  (ToTokenProperty name: #'background-color' value: Color white).

		  (ToTokenProperty name: #'border-radius' value: 6).
		  (ToTokenProperty name: #'border-radius-LG' value: 8).
		  (ToTokenProperty name: #'border-radius-SM' value: 4).

		  (ToTokenProperty
			   name: #'animation-window-opening'
			   value: [ :win |
				   win opacity: 0.1.
				   win addAnimation:
					   ((BlOpacityAnimation new opacity: 1.9) duration:
						    900 milliSeconds) ]).

		  (ToTokenProperty
			   name: #'effect-window'
			   value: (BlGaussianShadowEffect
					    color: (Color veryLightGray alpha: 0.5)
					    width: 20
					    offset: 0 @ 4)).

		  (ToTokenProperty
			   name: #'effect-window-menu'
			   value: (BlGaussianShadowEffect
					    color: Color lightGray
					    width: 15
					    offset: 0 asPoint)).

		  (ToTokenProperty
			   name: #'color-bg-container'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-bg-container-disabled'
			   value: (Color black alpha: 0.04)).
		  (ToTokenProperty name: #'color-bg-tooltip' value: Color white).
		  (ToTokenProperty
			   name: #'color-bg-text-active'
			   value: (Color black alpha: 0.15)).
		  (ToTokenProperty
			   name: #'color-bg-text-hover'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border'
			   value: (Color fromHexString: '#d9d9d9')).
		  (ToTokenProperty
			   name: #'color-border-checkable'
			   value: Color transparent).
		  (ToTokenProperty
			   name: #'color-border-disabled'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border-indeterminate'
			   value: self defaultColorPrimary lighter).
		  (ToTokenProperty
			   name: #'color-error-bg'
			   value: (Color fromHexString: '#fff2f0')).
		  (ToTokenProperty
			   name: #'color-error-hover'
			   value: (Color fromHexString: '#ff7875')).
		  (ToTokenProperty
			   name: #'color-error-pressed'
			   value: (Color fromHexString: '#e75c5d')).
		  (ToTokenProperty
			   name: #'color-error'
			   value: (Color fromHexString: '#ff4d4f')).
		  (ToTokenProperty
			   name: #'color-image-disabled'
			   value: (Color black alpha: 1.0)).
		  (ToTokenProperty
			   name: #'color-image-light-solid'
			   value: (Color fromHexString: '#ffffff')).

		  (ToTokenProperty
			   name: #'color-link'
			   value: (Color fromHexString: '#1677ff')).
		  (ToTokenProperty
			   name: #'color-link-active'
			   value: (Color fromHexString: '#0958d9')).
		  (ToTokenProperty
			   name: #'color-link-hover'
			   value: (Color fromHexString: '#69b1ff')).

		  (ToTokenProperty
			   name: #'color-primary'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'color-primary-pressed'
			   value: self defaultColorPrimary darker darker).
		  (ToTokenProperty
			   name: #'color-primary-checked'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'text-color-primary-checked'
			   value: Color white).
		  (ToTokenProperty
			   name: #'color-primary-unchecked'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-primary-indeterminate'
			   value: (self defaultColorPrimary alpha: 0.5)).
		  (ToTokenProperty
			   name: #'color-primary-hover'
			   value: self defaultColorPrimary lighter lighter).

		  (ToTokenProperty
			   name: #'color-success'
			   value: (Color fromHexString: '#52c41a')).
		  (ToTokenProperty
			   name: #'color-warning'
			   value: (Color fromHexString: '#faad14')).

		  (ToTokenProperty name: #'color-text' value: Color black).
		  (ToTokenProperty
			   name: #'color-text-description'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'color-text-disabled'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'color-text-heading'
			   value: (Color black alpha: 0.88)).
		  (ToTokenProperty
			   name: #'color-text-light-solid'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-text-secondary'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'label-selected-focused'
			   value: Color white).
		  (ToTokenProperty
			   name: #'label-selected-unfocused'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'text-foreground-in-tooltip'
			   value: (Color fromHexString: '#313339')).

		  (ToTokenProperty name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToTokenProperty name: #'font-family-code' value: 'Courier').
		  (ToTokenProperty name: #'font-size' value: 14).
		  (ToTokenProperty name: #'font-size-in-tooltip' value: 12).
		  (ToTokenProperty name: #'font-size-H1' value: 38).
		  (ToTokenProperty name: #'font-size-H2' value: 30).
		  (ToTokenProperty name: #'font-size-H3' value: 24).
		  (ToTokenProperty name: #'font-size-H4' value: 20).
		  (ToTokenProperty name: #'font-size-H5' value: 16).
		  (ToTokenProperty name: #'font-weight-strong' value: 600).

		  (ToTokenProperty name: #'line-height' value: 1).
		  (ToTokenProperty name: #'line-height-H1' value: 1.2).
		  (ToTokenProperty name: #'line-height-H2' value: 1.3).
		  (ToTokenProperty name: #'line-height-H3' value: 1.3).
		  (ToTokenProperty name: #'line-height-H4' value: 1.4).
		  (ToTokenProperty name: #'line-height-H5' value: 1.5).

		  (ToTokenProperty name: #'line-type' value: #solid).
		  (ToTokenProperty name: #'line-width' value: 1).
		  (ToTokenProperty name: #'focus-border-width' value: 2).
		  (ToTokenProperty
			   name: #'focus-border-paint'
			   value: self defaultColorPrimary).
		  (ToTokenProperty name: #'border-width' value: 1).
		  (ToTokenProperty name: #'border-paint' value: Color lightGray).

		  "Size, margin and padding"
		  (ToTokenProperty name: #'control-height' value: 32).
		  (ToTokenProperty name: #'control-height-LG' value: 40).
		  (ToTokenProperty name: #'control-height-SM' value: 24).

		  (ToTokenProperty name: #'margin-XS' value: 8).

		  (ToTokenProperty name: #'padding-content-H' value: 6).
		  (ToTokenProperty name: #'padding-content-HS' value: 4).
		  (ToTokenProperty name: #'padding-content-HXS' value: 2).
		  (ToTokenProperty name: #'padding-content-V' value: 6).
		  (ToTokenProperty name: #'padding-content-VS' value: 4).
		  (ToTokenProperty name: #'padding-content-VXS' value: 2).
		  (ToTokenProperty name: #'padding-XS' value: 8).
		  (ToTokenProperty name: #'padding-XXS' value: 3).

		  (ToTokenProperty name: #'button-interspace' value: 6).
		  (ToTokenProperty name: #'list-padding-H' value: 6).
		  (ToTokenProperty name: #'list-padding-V' value: 6).
		  (ToTokenProperty name: #'list-node-padding-H' value: 3).
		  (ToTokenProperty name: #'list-node-padding-V' value: 1).
		  (ToTokenProperty name: #'bar-node-padding-H' value: 3).
		  (ToTokenProperty name: #'bar-node-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-node-padding-H' value: 1).
		  (ToTokenProperty name: #'menu-node-padding-V' value: 1).
		  (ToTokenProperty name: #'menu-button-padding-H' value: 3).
		  (ToTokenProperty name: #'menu-button-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-window-padding-H' value: 6).
		  (ToTokenProperty name: #'menu-window-padding-V' value: 6).
		  (ToTokenProperty name: #'segmented-node-padding-H' value: 0).
		  (ToTokenProperty name: #'segmented-node-padding-V' value: 0).
		  (ToTokenProperty name: #'segmented-border-radius' value: 12).
		  (ToTokenProperty
			   name: #'segmented-background'
			   value: (Color veryLightGray alpha: 0.06)).


		  (ToTokenProperty
			   name: #'text-editor-background-disabled'
			   value: (Color black alpha: 0.1)).
		  (ToTokenProperty name: #'text-editor-padding-H' value: 3).
		  (ToTokenProperty name: #'text-editor-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-item-start-alignment' value: 25).
		  (ToTokenProperty
			   name: #'checkbox-image-builder'
			   value: [ self defaultCheckboxBlankImage ]).
		  (ToTokenProperty
			   name: #'switch-checked-background'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'switch-unchecked-background'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'switch-disabled-background'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'switch-handle-disabled-background'
			   value: Color veryLightGray).
		  (ToTokenProperty
			   name: #'switch-handle-enabled-background'
			   value: Color white).

		  (ToTokenProperty
			   name: #'color-primary-selection-focused'
			   value: (self defaultColorPrimary alpha: 0.6)).
		  (ToTokenProperty
			   name: #'color-primary-selection-over-focused'
			   value: (self defaultColorPrimary alpha: 0.1)).
		  (ToTokenProperty
			   name: #'color-primary-selection-unfocused'
			   value: (self defaultColorPrimary alpha: 0.1)).
		  (ToTokenProperty
			   name: #'color-primary-selection-over-unfocused'
			   value: (self defaultColorPrimary alpha: 0.05)).
		  (ToTokenProperty
			   name: #'color-primary-selection-disabled'
			   value: (Color gray alpha: 0.3)).

		  (ToTokenProperty name: #'border-width-primary-selection' value: 1).
		  (ToTokenProperty
			   name: #'border-color-danger-selection'
			   value: Color red).
		  (ToTokenProperty
			   name: #'border-color-primary-selection'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'list-context-menu-selection-border-gap'
			   value: 1.0) }
]

{ #category : #accessing }
ToTheme class >> label [

	^ 'Unsupported abstract theme'
]

{ #category : #accessing }
ToTheme class >> technicalTokenProperties [
	" toplo need a list of unique stamps for widget technical parameters. "

	^ {  }
]

{ #category : #accessing }
ToTheme >> addTokenProperties: aCollection [

	tokenProperties addAll: aCollection
]

{ #category : #accessing }
ToTheme >> addTokenProperty: aTokenProperty [

	tokenProperties add: aTokenProperty
]

{ #category : #accessing }
ToTheme >> defaultSkinFor: anElement [

	anElement skinManager setUp: anElement forTheme: self.
	^ self expectedSkinFor: anElement
]

{ #category : #accessing }
ToTheme >> defaultTokenProperties [

	^ self class defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> expectedSkinFor: anElement [

	^ anElement skinManager ifNotNil: [:sm | sm defaultSkin ]
]

{ #category : #accessing }
ToTheme >> icons [

	^ icons
]

{ #category : #accessing }
ToTheme >> icons: aThemeIcons [

	icons := aThemeIcons
]

{ #category : #initialization }
ToTheme >> initialize [

	super initialize.
	tokenProperties := self technicalTokenProperties asOrderedCollection.
	tokenProperties addAll: self defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> name [

	^ self class label
]

{ #category : #accessing }
ToTheme >> newSkinFor: anElement [

	anElement ensuredSkinManager setUp: anElement forTheme: self.
	^ self newSkinInstanceFor: anElement
]

{ #category : #accessing }
ToTheme >> newSkinInstanceFor: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToTheme >> onInstalledIn: anElement [

	anElement toThemePreInstall: self.
	anElement addAllTokenProperties: self tokenProperties.
	anElement toThemeInstalled
]

{ #category : #'api - hooks' }
ToTheme >> onUninstalledIn: anElement [

	anElement removeAllTokenPropertiesFromNames: (self tokenProperties collect: [:tp | tp name]).
	anElement toThemeUninstalled: self
]

{ #category : #printing }
ToTheme >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' [ ';
		nextPutAll: self name;
		nextPutAll: ' ]'
]

{ #category : #hook }
ToTheme >> setUpElement: anElement [
]

{ #category : #styling }
ToTheme >> styleSheet [ 

	^ nil
]

{ #category : #accessing }
ToTheme >> technicalTokenProperties [

	^ self class technicalTokenProperties
]

{ #category : #accessing }
ToTheme >> tokenProperties [

	^ tokenProperties 
]
