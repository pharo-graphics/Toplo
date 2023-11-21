Class {
	#name : 'ToRawTheme',
	#superclass : 'ToTheme',
	#instVars : [
		'colorPrimary',
		'colorPrimaryHover',
		'colorPrimaryPressed',
		'stampIndex'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'accessing' }
ToRawTheme >> buildStampIndexFromList: aStyleStampCollection [

	stampIndex := self newStampIndexFromStampList: aStyleStampCollection
]

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

{ #category : 'accessing' }
ToRawTheme >> colorPrimary [

	^ colorPrimary ifNil: [ self colorPrimary: self defaultColorPrimary. colorPrimary  ]
]

{ #category : 'accessing' }
ToRawTheme >> colorPrimary: aColor [
	"Brand color is one of the most direct visual elements to reflect the characteristics and communication of the product. After you have selected the brand color, we will automatically generate a complete color palette and assign it effective design semantics"

	colorPrimary = aColor ifTrue: [ ^ self ].
	colorPrimary := aColor.
	colorPrimaryHover := colorPrimary whiter whiter.
	colorPrimaryPressed := colorPrimary darker darker.
	self buildStampIndexFromList: self defaultStampList
]

{ #category : 'accessing' }
ToRawTheme >> colorPrimaryHover [

	^ colorPrimaryHover
]

{ #category : 'accessing' }
ToRawTheme >> colorPrimaryPressed [

	^ colorPrimaryPressed
]

{ #category : 'accessing' }
ToRawTheme >> defaultColorPrimary [

	^ Color blue
]

{ #category : 'initialization' }
ToRawTheme >> defaultStampList [
	" skin managing need a list of unique stamps . "

	^ {
		  (ToStyleStamp name: #'background-color' value: Color white).
		
		  (ToStyleStamp name: #'border-radius' value: 6).
		  (ToStyleStamp name: #'border-radius-LG' value: 8).
		  (ToStyleStamp name: #'border-radius-SM' value: 4).
		  (ToStyleStamp name: #'checkbox-image-builder' value: [ self checkboxBlankImage ] ).
		  (ToStyleStamp name: #'color-bg-container' value: (Color fromHexString: '#ffffff')).
		  (ToStyleStamp name: #'color-bg-container-disabled' value: (Color black alpha: 0.04)).
		  (ToStyleStamp name: #'color-bg-text-active' value: (Color black alpha: 0.15)).
		  (ToStyleStamp name: #'color-bg-text-hover' value: (Color black alpha: 0.2)).
		  (ToStyleStamp name: #'color-border' value: (Color fromHexString: '#d9d9d9')).
		  (ToStyleStamp name: #'color-border-checkable' value: Color transparent).
		  (ToStyleStamp name: #'color-border-disabled' value: (Color black alpha: 0.2)).
		  (ToStyleStamp name: #'color-error-bg' value: (Color fromHexString: '#fff2f0')).
		  (ToStyleStamp name: #'color-error-hover' value: (Color fromHexString: '#ff7875')).
		  (ToStyleStamp name: #'color-error-pressed' value: (Color fromHexString: '#e75c5d')).
		  (ToStyleStamp name: #'color-error' value: (Color fromHexString: '#ff4d4f')).
		  (ToStyleStamp name: #'color-image-disabled' value: (Color black alpha: 1.0)).
		  (ToStyleStamp name: #'color-image-light-solid' value: (Color fromHexString: '#ffffff')).

		  (ToStyleStamp name: #'color-link' value: (Color fromHexString: '#1677ff')).
		  (ToStyleStamp name: #'color-link-active' value: (Color fromHexString: '#0958d9')).
		  (ToStyleStamp name: #'color-link-hover' value: (Color fromHexString: '#69b1ff')).
		  (ToStyleStamp name: #'color-primary' value: self colorPrimary).
		  (ToStyleStamp name: #'color-primary-pressed' value: self colorPrimaryPressed).
		  (ToStyleStamp name: #'color-primary-hover' value: self colorPrimaryHover).
		  (ToStyleStamp name: #'color-success' value: (Color fromHexString: '#52c41a')).
		  (ToStyleStamp name: #'color-warning' value: (Color fromHexString: '#faad14')).
		
		  (ToStyleStamp name: #'color-text' value: (Color black)).
		  (ToStyleStamp name: #'color-text-description' value: (Color black alpha: 0.45)).
		  (ToStyleStamp name: #'color-text-disabled' value: (Color black alpha: 0.25)).
		  (ToStyleStamp name: #'color-text-heading' value: (Color black alpha: 0.88)).
		  (ToStyleStamp name: #'color-text-light-solid' value: (Color fromHexString: '#ffffff')).
		  (ToStyleStamp name: #'color-text-secondary' value: (Color black alpha: 0.45)).

		  (ToStyleStamp name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToStyleStamp name: #'font-family-code' value: 'SFMono-Regular').
		  (ToStyleStamp name: #'font-size' value: 14).
		  (ToStyleStamp name: #'font-size-H1' value: 38).
		  (ToStyleStamp name: #'font-size-H2' value: 30).
		  (ToStyleStamp name: #'font-size-H3' value: 24).
		  (ToStyleStamp name: #'font-size-H4' value: 20).
		  (ToStyleStamp name: #'font-size-H5' value: 16).
		  (ToStyleStamp name: #'font-weight-strong' value: 600).

		  (ToStyleStamp name: #'line-height' value: 1.5).
		  (ToStyleStamp name: #'line-height-H1' value: 1.2).
		  (ToStyleStamp name: #'line-height-H2' value: 1.3).
		  (ToStyleStamp name: #'line-height-H3' value: 1.3).
		  (ToStyleStamp name: #'line-height-H4' value: 1.4).
		  (ToStyleStamp name: #'line-height-H5' value: 1.5).

		  (ToStyleStamp name: #'line-type' value: #solid).
		  (ToStyleStamp name: #'line-width' value: 1).
		  (ToStyleStamp name: #'line-width-focus' value: 4).

			"Size, margin and padding"
		  (ToStyleStamp name: #'control-height' value: 32).
		  (ToStyleStamp name: #'control-height-LG' value: 40).
		  (ToStyleStamp name: #'control-height-SM' value: 24).

		  (ToStyleStamp name: #'margin-XS' value: 8). 

		  (ToStyleStamp name: #'padding-content-H' value: 15).
		  (ToStyleStamp name: #'padding-content-V' value: 4).
		  (ToStyleStamp name: #'padding-XS' value: 8) 
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

	^ anElement newRawSkin
]

{ #category : 'accessing' }
ToRawTheme >> stampIndex [

	^ stampIndex
]

{ #category : 'styling' }
ToRawTheme >> stampNamed: aName [

	^ self stampIndex ifNotNil: [ :si | si propertyNamed: aName ]
]
