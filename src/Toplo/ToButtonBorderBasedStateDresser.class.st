Class {
	#name : #ToButtonBorderBasedStateDresser,
	#superclass : #ToButtonAutomatonDresser,
	#instVars : [
		'downBorder',
		'initialBorder'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #private }
ToButtonBorderBasedStateDresser >> border: aBorder in: anElement [

	self
		disableBorderChangeEventIn: anElement
		while: [ anElement border: aBorder ]
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedStateDresser >> clicked: anElement [

	downBorder := nil.
	self border: self hoveredBorder in: anElement

]

{ #category : #private }
ToButtonBorderBasedStateDresser >> disableBorderChangeEventIn: anElement while: aBlock [

	anElement eventDispatcher disableEventType: BlElementBorderChangedEvent.
	aBlock ensure: [ 
		anElement eventDispatcher enableEventType: BlElementBorderChangedEvent ]
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedStateDresser >> escaped: anElement [

	downBorder := nil.
	
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedStateDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement
]

{ #category : #'border accessing' }
ToButtonBorderBasedStateDresser >> hoveredBorder [

	^ downBorder ifNil: [ (BlBorder paint: Color gray width: 1) ]

]

{ #category : #accessing }
ToButtonBorderBasedStateDresser >> initialBorder: aBorder [

	initialBorder := aBorder
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedStateDresser >> initialState: anElement [

	initialBorder ifNil: [ initialBorder := anElement border ].
	self border: initialBorder in: anElement

]

{ #category : #'api - state transitions' }
ToButtonBorderBasedStateDresser >> leaved: anElement [

	self border: initialBorder in: anElement

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> newAutomatonEventHandler [

	^ ToButtonBorderBasedAutomatonEventHandler new
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	downBorder := nil
]

{ #category : #'api - state transitions' }
ToButtonBorderBasedStateDresser >> pressed: anElement [

	self border: self pressedBorder in: anElement.
	downBorder := anElement border.

]

{ #category : #'border accessing' }
ToButtonBorderBasedStateDresser >> pressedBorder [

	^ BlBorder paint: Color gray width: 2
]
