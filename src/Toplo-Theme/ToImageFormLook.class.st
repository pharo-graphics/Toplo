Class {
	#name : #ToImageFormLook,
	#superclass : #ToMultiStateLook,
	#instVars : [
		'changeFormBlock'
	],
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #testing }
ToImageFormLook class >> isDeprecated [ 

	^ true
]

{ #category : #private }
ToImageFormLook >> adaptForegroundIn: aToImage withColor: aColor [

	aToImage
		withInnerFormDo: [ :form |
			| newForm |
			newForm := form collectColors: [ :color | aColor alpha: color alpha ].
			aToImage innerImage: newForm ]
		ifNone: [  ]
]

{ #category : #private }
ToImageFormLook >> apply: aStateValue on: anElement [

	changeFormBlock value: anElement value: (aStateValue valueIn: anElement)
]

{ #category : #accessing }
ToImageFormLook >> changeFormBlock: aBlock [
 	" ABlock adapt the ToImage form from a color.
	aBlock takes the ToImage (first) and the color as arguments "
	
	changeFormBlock := aBlock
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> disabledColor [

	self deprecatedInsteadOf: 'disabledColor' use: 'disabledStateValue'.
	^ self disabledValue

]

{ #category : #'deprecated accessing' }
ToImageFormLook >> disabledColor: aValuable [

	self deprecatedInsteadOf: 'disabledColor:' use: 'disabledStateValue:'.
	self whenDisabled: aValuable
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> hoverColor [

	self deprecatedInsteadOf: 'hoverColor' use: 'hoveredStateValue'.
	^ self hoveredValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> hoverColor: aColor [

	self deprecatedInsteadOf: 'hoverColor:' use: 'hoveredStateValue:'.
	self whenHovered: aColor
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> initialColor [

	self deprecatedInsteadOf: 'initialColor' use: 'initialStateValue'.
	^ self initialValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> initialColor: aValuable [

	self deprecatedInsteadOf: 'initialColor:' use: 'initialStateValue:'.
	self whenInitialized: aValuable
]

{ #category : #initialization }
ToImageFormLook >> initialize [ 

	super initialize.
	changeFormBlock := [ :im :c | self adaptForegroundIn: im withColor: c ]
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> pressedColor [

	self deprecatedInsteadOf: 'pressedColor' use: 'pressedStateValue'.
	^ self pressedValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> pressedColor: aColor [

	self deprecatedInsteadOf: 'pressedColor:' use: 'pressedStateValue:'.
	self whenPressed: aColor
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> selectedColor [

	self deprecatedInsteadOf: 'selectedColor' use: 'selectedStateValue'.
	^ self selectedValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> selectedColor: aValuable [

	self deprecatedInsteadOf: 'selectedColor:' use: 'selectedStateValue:'.
	self whenSelected: aValuable
]
