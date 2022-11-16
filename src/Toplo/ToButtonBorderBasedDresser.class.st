Class {
	#name : #ToButtonBorderBasedDresser,
	#superclass : #ToButtonAutomatonDresser,
	#instVars : [
		'downBorder',
		'initialBorder'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #private }
ToButtonBorderBasedDresser >> border: aBorder in: anElement [

	self
		disableBorderChangeEventIn: anElement
		while: [ anElement border: aBorder ]
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedDresser >> clicked: anElement [

	downBorder := nil.
	self border: self hoveredBorder in: anElement

]

{ #category : #private }
ToButtonBorderBasedDresser >> disableBorderChangeEventIn: anElement while: aBlock [

	anElement eventDispatcher disableEventType: BlElementBorderChangedEvent.
	aBlock ensure: [ 
		anElement eventDispatcher enableEventType: BlElementBorderChangedEvent ]
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedDresser >> escaped: anElement [

	downBorder := nil.
	
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement
]

{ #category : #'border accessing' }
ToButtonBorderBasedDresser >> hoveredBorder [

	^ downBorder ifNil: [ (BlBorder paint: Color gray width: 1) ]

]

{ #category : #accessing }
ToButtonBorderBasedDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedDresser >> initialState: anElement [

	initialBorder ifNil: [ initialBorder := anElement border ].
	self border: initialBorder in: anElement

]

{ #category : #'api - state transitions' }
ToButtonBorderBasedDresser >> leaved: anElement [

	self border: initialBorder in: anElement

]

{ #category : #'api - hooks' }
ToButtonBorderBasedDresser >> newAutomatonEventHandler [

	^ ToButtonBorderBasedAutomatonEventHandler new
]

{ #category : #'api - hooks' }
ToButtonBorderBasedDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	downBorder := nil
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedDresser >> pressed: anElement [

	self border: self pressedBorder in: anElement.
	downBorder := anElement border.

]

{ #category : #'border accessing' }
ToButtonBorderBasedDresser >> pressedBorder [

	^ BlBorder paint: Color gray width: 2
]
