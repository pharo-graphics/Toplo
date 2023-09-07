Class {
	#name : #ToImageFormLook,
	#superclass : #ToMultiStateLook,
	#instVars : [
		'changeFormBlock'
	],
	#category : #'Toplo-Theme-Look'
}

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

{ #category : #initialization }
ToImageFormLook >> defaultInitialValue [

	^ Color transparent asStateValue 
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> disabledColor [

	self deprecatedInsteadOf: 'disabledColor' use: 'disabledStateValue'.
	^ self disabledStateValue

]

{ #category : #'deprecated accessing' }
ToImageFormLook >> disabledColor: aValuable [

	self deprecatedInsteadOf: 'disabledColor:' use: 'disabledStateValue:'.
	self disabledStateValue: aValuable
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> hoverColor [

	self deprecatedInsteadOf: 'hoverColor' use: 'hoveredStateValue'.
	^ self hoveredStateValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> hoverColor: aColor [

	self deprecatedInsteadOf: 'hoverColor:' use: 'hoveredStateValue:'.
	self hoveredStateValue: aColor
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> initialColor [

	self deprecatedInsteadOf: 'initialColor' use: 'initialStateValue'.
	^ self initialStateValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> initialColor: aValuable [

	self deprecatedInsteadOf: 'initialColor:' use: 'initialStateValue:'.
	self initialStateValue: aValuable
]

{ #category : #initialization }
ToImageFormLook >> initialize [ 

	super initialize.
	changeFormBlock := [ :im :c | self adaptForegroundIn: im withColor: c ]
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> pressedColor [

	self deprecatedInsteadOf: 'pressedColor' use: 'pressedStateValue'.
	^ self pressedStateValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> pressedColor: aColor [

	self deprecatedInsteadOf: 'pressedColor:' use: 'pressedStateValue:'.
	self pressedStateValue: aColor
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> selectedColor [

	self deprecatedInsteadOf: 'selectedColor' use: 'selectedStateValue'.
	^ self selectedStateValue
]

{ #category : #'deprecated accessing' }
ToImageFormLook >> selectedColor: aValuable [

	self deprecatedInsteadOf: 'selectedColor:' use: 'selectedStateValue:'.
	self selectedStateValue: aValuable
]
