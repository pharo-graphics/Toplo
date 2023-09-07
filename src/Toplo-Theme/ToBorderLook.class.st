Class {
	#name : #ToBorderLook,
	#superclass : #ToMultiStateLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #private }
ToBorderLook >> apply: aStateValue on: anElement [

	| border |
	border := (aStateValue valueIn: anElement) asBlBorder.
	anElement border: border
]

{ #category : #'depecated accessing' }
ToBorderLook >> dashArray: anArray [
	
	self deprecated: ''
]

{ #category : #initialization }
ToBorderLook >> defaultInitialValue [

	^ BlBorder empty asStateValue 
]

{ #category : #'depecated accessing' }
ToBorderLook >> disabledPaint [

	self deprecatedInsteadOf: 'disabledPaint' use: 'disabledStateValue'.
	^ self disabledStateValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> disabledPaint: aValuable [

	self deprecatedInsteadOf: 'disabledPaint:' use: 'disabledStateValue:'.
	self disabledStateValue: aValuable

]

{ #category : #'depecated accessing' }
ToBorderLook >> hoverPaint [

	self deprecatedInsteadOf: 'hoverPaint' use: 'hoveredStateValue'.
	^ self hoveredStateValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> hoverPaint: aValuable [

	self deprecatedInsteadOf: 'hoverPaint:' use: 'hoveredStateValue:'.
	self hoveredStateValue: aValuable

]

{ #category : #'depecated accessing' }
ToBorderLook >> initialPaint [

	self deprecatedInsteadOf: 'initialPaint' use: 'initialStateValue'.
	^ self initialStateValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> initialPaint: aValuable [

	self deprecatedInsteadOf: 'initialPaint:' use: 'initialStateValue:'.
	self initialStateValue: aValuable
]

{ #category : #'depecated accessing' }
ToBorderLook >> pressedPaint [

	self deprecatedInsteadOf: 'pressedPaint' use: 'pressedStateValue'.
	^ self pressedStateValue

]

{ #category : #'depecated accessing' }
ToBorderLook >> pressedPaint: aValuable [

	self deprecatedInsteadOf: 'pressedPaint:' use: 'pressedStateValue:'.
	self pressedStateValue: aValuable
]

{ #category : #'depecated accessing' }
ToBorderLook >> selectedPaint [

	self deprecatedInsteadOf: 'selectedPaint' use: 'selectedStateValue'.
	^ self selectedStateValue
]

{ #category : #'depecated accessing' }
ToBorderLook >> selectedPaint: aValuable [

	self deprecatedInsteadOf: 'selectedPaint:' use: 'selectedStateValue:'.
	self selectedStateValue: aValuable

]

{ #category : #'depecated accessing' }
ToBorderLook >> width [

	^ self deprecated: ''
]

{ #category : #'depecated accessing' }
ToBorderLook >> width: aValuable [
	
	self deprecated: ''
]
