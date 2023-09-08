Class {
	#name : #ToBorderLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #testing }
ToBorderLook class >> isDeprecated [ 

	^ true
]

{ #category : #private }
ToBorderLook >> apply: aStateValue on: anElement [

	| border |
	border := aStateValue valueIn: anElement.
	anElement border: border
]

{ #category : #'depecated accessing' }
ToBorderLook >> dashArray: anArray [
	
	self deprecated: ''
]

{ #category : #'depecated accessing' }
ToBorderLook >> disabledPaint [

	self deprecatedInsteadOf: 'disabledPaint' use: 'disabledStateValue'.
	^ self disabledValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> disabledPaint: aValuable [

	self deprecatedInsteadOf: 'disabledPaint:' use: 'disabledStateValue:'.
	self disabledValue: aValuable

]

{ #category : #'depecated accessing' }
ToBorderLook >> hoverPaint [

	self deprecatedInsteadOf: 'hoverPaint' use: 'hoveredStateValue'.
	^ self hoveredValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> hoverPaint: aValuable [

	self deprecatedInsteadOf: 'hoverPaint:' use: 'hoveredStateValue:'.
	self hoveredValue: aValuable

]

{ #category : #'depecated accessing' }
ToBorderLook >> initialPaint [

	self deprecatedInsteadOf: 'initialPaint' use: 'initialStateValue'.
	^ self initialValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> initialPaint: aValuable [

	self deprecatedInsteadOf: 'initialPaint:' use: 'initialStateValue:'.
	self initialValue: aValuable
]

{ #category : #'depecated accessing' }
ToBorderLook >> pressedPaint [

	self deprecatedInsteadOf: 'pressedPaint' use: 'pressedStateValue'.
	^ self pressedValue

]

{ #category : #'depecated accessing' }
ToBorderLook >> pressedPaint: aValuable [

	self deprecatedInsteadOf: 'pressedPaint:' use: 'pressedStateValue:'.
	self pressedValue: aValuable
]

{ #category : #'depecated accessing' }
ToBorderLook >> selectedPaint [

	self deprecatedInsteadOf: 'selectedPaint' use: 'selectedStateValue'.
	^ self selectedValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> selectedPaint: aValuable [

	self deprecatedInsteadOf: 'selectedPaint:' use: 'selectedStateValue:'.
	self selectedValue: aValuable

]

{ #category : #'depecated accessing' }
ToBorderLook >> width [

	^ self deprecated: ''
]

{ #category : #'depecated accessing' }
ToBorderLook >> width: aValuable [
	
	self deprecated: ''
]
