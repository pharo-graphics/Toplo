Class {
	#name : 'ToRawTheme',
	#superclass : 'ToTheme',
	#traits : 'TToReadOnlyStampIndexHolder + TToPrimaryColorHolder',
	#classTraits : 'TToReadOnlyStampIndexHolder classTrait + TToPrimaryColorHolder classTrait',
	#instVars : [
		'colorPrimary',
		'colorPrimaryHover',
		'colorPrimaryPressed',
		'readOnlyStampIndex'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'accessing' }
ToRawTheme >> checkboxBlankImage [

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
	bar withAllStamps: #( #bar ).
	im withAllStamps: #( #'inner-image' #unchecked ).
	^ im
]

{ #category : 't - primary color holder' }
ToRawTheme >> defaultColorPrimary [

	^ Color blue
]

{ #category : 't - readonly stamp index holder' }
ToRawTheme >> defaultReadOnlyStampList [
	" skin managing need a list of unique stamps . "

	^ {
		  (ToReadOnlyStyleStamp name: #'background-color' value: Color white).
		
		  (ToReadOnlyStyleStamp name: #'border-radius' value: 6).
		  (ToReadOnlyStyleStamp name: #'border-radius-LG' value: 8).
		  (ToReadOnlyStyleStamp name: #'border-radius-SM' value: 4).
		  (ToReadOnlyStyleStamp name: #'checkbox-image-builder' value: [ self checkboxBlankImage ] ).
		
		  (ToReadOnlyStyleStamp name: #'color-bg-container' value: (Color fromHexString: '#ffffff')).
		  (ToReadOnlyStyleStamp name: #'color-bg-container-disabled' value: (Color black alpha: 0.04)).
		  (ToReadOnlyStyleStamp name: #'color-bg-text-active' value: (Color black alpha: 0.15)).
		  (ToReadOnlyStyleStamp name: #'color-bg-text-hover' value: (Color black alpha: 0.2)).
		  (ToReadOnlyStyleStamp name: #'color-border' value: (Color fromHexString: '#d9d9d9')).
		  (ToReadOnlyStyleStamp name: #'color-border-checkable' value: Color transparent).
		  (ToReadOnlyStyleStamp name: #'color-border-disabled' value: (Color black alpha: 0.2)).
		  (ToReadOnlyStyleStamp name: #'color-error-bg' value: (Color fromHexString: '#fff2f0')).
		  (ToReadOnlyStyleStamp name: #'color-error-hover' value: (Color fromHexString: '#ff7875')).
		  (ToReadOnlyStyleStamp name: #'color-error-pressed' value: (Color fromHexString: '#e75c5d')).
		  (ToReadOnlyStyleStamp name: #'color-error' value: (Color fromHexString: '#ff4d4f')).
		  (ToReadOnlyStyleStamp name: #'color-image-disabled' value: (Color black alpha: 1.0)).
		  (ToReadOnlyStyleStamp name: #'color-image-light-solid' value: (Color fromHexString: '#ffffff')).

		  (ToReadOnlyStyleStamp name: #'color-link' value: (Color fromHexString: '#1677ff')).
		  (ToReadOnlyStyleStamp name: #'color-link-active' value: (Color fromHexString: '#0958d9')).
		  (ToReadOnlyStyleStamp name: #'color-link-hover' value: (Color fromHexString: '#69b1ff')).
		  (ToReadOnlyStyleStamp name: #'color-primary' value: self colorPrimary).
		  (ToReadOnlyStyleStamp name: #'color-primary-pressed' value: self colorPrimaryPressed).
		  (ToReadOnlyStyleStamp name: #'color-primary-hover' value: self colorPrimaryHover).
		  (ToReadOnlyStyleStamp name: #'color-success' value: (Color fromHexString: '#52c41a')).
		  (ToReadOnlyStyleStamp name: #'color-warning' value: (Color fromHexString: '#faad14')).
		
		  (ToReadOnlyStyleStamp name: #'color-text' value: (Color black)).
		  (ToReadOnlyStyleStamp name: #'color-text-description' value: (Color black alpha: 0.45)).
		  (ToReadOnlyStyleStamp name: #'color-text-disabled' value: (Color black alpha: 0.25)).
		  (ToReadOnlyStyleStamp name: #'color-text-heading' value: (Color black alpha: 0.88)).
		  (ToReadOnlyStyleStamp name: #'color-text-light-solid' value: (Color fromHexString: '#ffffff')).
		  (ToReadOnlyStyleStamp name: #'color-text-secondary' value: (Color black alpha: 0.45)).

		  (ToReadOnlyStyleStamp name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToReadOnlyStyleStamp name: #'font-family-code' value: 'SFMono-Regular').
		  (ToReadOnlyStyleStamp name: #'font-size' value: 14).
		  (ToReadOnlyStyleStamp name: #'font-size-H1' value: 38).
		  (ToReadOnlyStyleStamp name: #'font-size-H2' value: 30).
		  (ToReadOnlyStyleStamp name: #'font-size-H3' value: 24).
		  (ToReadOnlyStyleStamp name: #'font-size-H4' value: 20).
		  (ToReadOnlyStyleStamp name: #'font-size-H5' value: 16).
		  (ToReadOnlyStyleStamp name: #'font-weight-strong' value: 600).

		  (ToReadOnlyStyleStamp name: #'line-height' value: 1.5).
		  (ToReadOnlyStyleStamp name: #'line-height-H1' value: 1.2).
		  (ToReadOnlyStyleStamp name: #'line-height-H2' value: 1.3).
		  (ToReadOnlyStyleStamp name: #'line-height-H3' value: 1.3).
		  (ToReadOnlyStyleStamp name: #'line-height-H4' value: 1.4).
		  (ToReadOnlyStyleStamp name: #'line-height-H5' value: 1.5).

		  (ToReadOnlyStyleStamp name: #'line-type' value: #solid).
		  (ToReadOnlyStyleStamp name: #'line-width' value: 1).
		  (ToReadOnlyStyleStamp name: #'line-width-focus' value: 4).

			"Size, margin and padding"
		  (ToReadOnlyStyleStamp name: #'control-height' value: 32).
		  (ToReadOnlyStyleStamp name: #'control-height-LG' value: 40).
		  (ToReadOnlyStyleStamp name: #'control-height-SM' value: 24).

		  (ToReadOnlyStyleStamp name: #'margin-XS' value: 8). 

		  (ToReadOnlyStyleStamp name: #'padding-content-H' value: 15).
		  (ToReadOnlyStyleStamp name: #'padding-content-V' value: 4).
		  (ToReadOnlyStyleStamp name: #'padding-XS' value: 8) 
	}
]

{ #category : 'initialization' }
ToRawTheme >> initialize [ 

	super initialize.
	self colorPrimary: self defaultColorPrimary
]

{ #category : 'accessing' }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : 'accessing' }
ToRawTheme >> newSkinInstanceFor: anElement [

	anElement spaceDo: [ :sp |
		sp root == self ifTrue: [ ^ ToSpaceRootSkin new ] ].
	^ anElement newRawSkin
]

{ #category : 't - primary color holder' }
ToRawTheme >> onColorPrimaryChanged [
	"Brand color is one of the most direct visual elements to reflect the characteristics and communication of the product. After you have selected the brand color, we will automatically generate a complete color palette and assign it effective design semantics"

	self rawColorPrimaryHover: self rawColorPrimary whiter whiter.
	self rawColorPrimaryPressed: self rawColorPrimary darker darker.
	self resetReadOnlyStampIndexFromList: self defaultReadOnlyStampList
]

{ #category : 't - primary color holder' }
ToRawTheme >> rawColorPrimary [

	^ colorPrimary 
]

{ #category : 't - primary color holder' }
ToRawTheme >> rawColorPrimary: aColor [

	colorPrimary := aColor
]

{ #category : 't - primary color holder' }
ToRawTheme >> rawColorPrimaryHover [

	^ colorPrimaryHover 
]

{ #category : 't - primary color holder' }
ToRawTheme >> rawColorPrimaryHover: aColor [

	colorPrimaryHover := aColor
]

{ #category : 't - primary color holder' }
ToRawTheme >> rawColorPrimaryPressed [

	^ colorPrimaryPressed 
]

{ #category : 't - primary color holder' }
ToRawTheme >> rawColorPrimaryPressed: aColor [

	colorPrimaryPressed := aColor
]

{ #category : 't - readonly stamp index holder' }
ToRawTheme >> rawReadOnlyStampIndex [

	^ readOnlyStampIndex
]

{ #category : 't - readonly stamp index holder' }
ToRawTheme >> rawReadOnlyStampIndex: aPropertyIndex [

	readOnlyStampIndex := aPropertyIndex
]
