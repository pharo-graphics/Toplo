Class {
	#name : #ToTheme,
	#superclass : #Object,
	#instVars : [
		'variant'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToTheme class >> canBeDefault [

	^ false
]

{ #category : #'instance creation' }
ToTheme class >> dark [

	^ self variant: ToThemeDarkVariant new
]

{ #category : #accessing }
ToTheme class >> defaultCheckboxBlankImage [

	| bar im |
	bar := ToElement new id: #bar.
	bar withoutSkin.
	bar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 3.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	bar margin: (BlInsets left: 2 right: 2).
	bar geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	im := ToElement new.
	im layout: BlFrameLayout new.
	im size: 16 asPoint.
	im addChild: bar.
	im withoutSkin.
	bar addAllStamps: #( #bar ).
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
		  (ToTokenProperty name: #'background-color' value: Color white).

		  (ToTokenProperty name: #'border-radius' value: 6).
		  (ToTokenProperty name: #'border-radius-LG' value: 8).
		  (ToTokenProperty name: #'border-radius-SM' value: 4).

		  (ToTokenProperty name: #'animation-window-opening' value: [ :win |
			   win opacity: 0.3.
			   win addAnimation:
				   ((BlOpacityAnimation new opacity: 1.8) duration:
					    600 milliSeconds) ]).

		  (ToTokenProperty
			   name: #'effect-window'
			   value:
			   (BlGaussianShadowEffect
				    color: Color gray
				    width: 20
				    offset: 0 asPoint)).
	
		  (ToTokenProperty
			   name: #'effect-window-menu'
			   value:
			   (BlGaussianShadowEffect
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
			   name: #'label-in-list-foreground-selected-focused'
			   value: (Color white)).
		(ToTokenProperty
			   name: #'label-in-list-foreground-selected-unfocused'
			   value: (self defaultColorPrimary)).
		(ToTokenProperty
			   name: #'label-in-list-foreground-deselected'
			   value: (Color black)).
		  (ToTokenProperty
			   name: #'text-foreground-in-tooltip'
			   value: (Color fromHexString: '#313339')).

		  (ToTokenProperty name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToTokenProperty name: #'font-family-code' value: 'SFMono-Regular').
		  (ToTokenProperty name: #'font-size' value: 14).
		  (ToTokenProperty name: #'font-size-in-tooltip' value: 12).
		  (ToTokenProperty name: #'font-size-H1' value: 38).
		  (ToTokenProperty name: #'font-size-H2' value: 30).
		  (ToTokenProperty name: #'font-size-H3' value: 24).
		  (ToTokenProperty name: #'font-size-H4' value: 20).
		  (ToTokenProperty name: #'font-size-H5' value: 16).
		  (ToTokenProperty name: #'font-weight-strong' value: 600).

		  (ToTokenProperty name: #'line-height' value: 1.5).
		  (ToTokenProperty name: #'line-height-H1' value: 1.2).
		  (ToTokenProperty name: #'line-height-H2' value: 1.3).
		  (ToTokenProperty name: #'line-height-H3' value: 1.3).
		  (ToTokenProperty name: #'line-height-H4' value: 1.4).
		  (ToTokenProperty name: #'line-height-H5' value: 1.5).

		  (ToTokenProperty name: #'line-type' value: #solid).
		  (ToTokenProperty name: #'line-width' value: 1).
		  (ToTokenProperty name: #'focus-border-width' value: 2).
		  (ToTokenProperty name: #'focus-border-paint' value: self defaultColorPrimary ).
		  (ToTokenProperty name: #'border-width' value: 1).
		  (ToTokenProperty name: #'border-paint' value: Color lightGray ).

		  "Size, margin and padding"
		  (ToTokenProperty name: #'control-height' value: 32).
		  (ToTokenProperty name: #'control-height-LG' value: 40).
		  (ToTokenProperty name: #'control-height-SM' value: 24).

		  (ToTokenProperty name: #'margin-XS' value: 8).

		  (ToTokenProperty name: #'padding-content-H' value: 15).
		  (ToTokenProperty name: #'padding-content-V' value: 4).
		  (ToTokenProperty name: #'padding-content-V-S' value: 2).
		  (ToTokenProperty name: #'padding-content-V-XS' value: 0).
		  (ToTokenProperty name: #'padding-XS' value: 8).

		  (ToTokenProperty name: #'list-infinite-padding-H' value: 4).
		  (ToTokenProperty name: #'list-infinite-padding-V' value: 1).

		  (ToTokenProperty name: #'list-padding-H' value: 1).
		  (ToTokenProperty name: #'list-padding-V' value: 1).
		  (ToTokenProperty name: #'list-node-padding-H' value: 2).
		  (ToTokenProperty name: #'list-node-padding-V' value: 1).
		
		  (ToTokenProperty name: #'text-editor-padding-H' value: 3).
		  (ToTokenProperty name: #'text-editor-padding-V' value: 2).
		
		

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
			   name: #'primary-selection-geometry-class'
			   value: BlRoundedRectangleGeometry).
		  (ToTokenProperty
			   name: #'color-primary-selection-focused'
			   value: (self defaultColorPrimary alpha: 0.6) ).
		  (ToTokenProperty
			   name: #'color-primary-selection-unfocused'
			   value: (self defaultColorPrimary alpha: 0.1)).

		  (ToTokenProperty name: #'border-width-primary-selection' value: 1).
		  (ToTokenProperty
			   name: #'border-color-primary-selection'
			   value: self defaultColorPrimary) }
]

{ #category : #accessing }
ToTheme class >> label [

	^ 'Unsupported abstract theme'
]

{ #category : #'instance creation' }
ToTheme class >> light [

	^ self variant: ToThemeLightVariant new
]

{ #category : #'instance creation' }
ToTheme class >> new [

	self error: 'Use one of the builder methods'
]

{ #category : #'instance creation' }
ToTheme class >> variant: aThemeVariant [

	^ self basicNew initialize variant: aThemeVariant
]

{ #category : #accessing }
ToTheme >> defaultTokenProperties [

	^ self class defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> name [

	^ self class label, ' - ', self variant class label
]

{ #category : #accessing }
ToTheme >> newSkinFor: anElement [

	anElement setUpForTheme: self.
	^ self newSkinInstanceFor: anElement
]

{ #category : #accessing }
ToTheme >> newSkinInstanceFor: anElement [

	^ self subclassResponsibility 
]

{ #category : #'space configurating' }
ToTheme >> onInstalledIn: aSpace [

	aSpace root addAllTokenProperties: self defaultTokenProperties.
	self variant onInstalledIn: aSpace
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
ToTheme >> variant [

	^ variant
]

{ #category : #accessing }
ToTheme >> variant: aThemeVariant [

	variant ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	variant := aThemeVariant
]
