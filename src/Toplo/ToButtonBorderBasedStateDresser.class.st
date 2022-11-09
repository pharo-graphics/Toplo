Class {
	#name : #ToButtonBorderBasedStateDresser,
	#superclass : #ToButtonAbstractStateDresser,
	#instVars : [
		'downBorder',
		'initialBorder'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> border: aBorder in: anElement [

	self
		disableBorderChangeEventIn: anElement
		while: [ anElement border: aBorder ]
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> clicked: anElement [

	downBorder := nil.
	self border: self hoveredBorder in: anElement

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> disableBorderChangeEventIn: anElement while: aBlock [

	anElement eventDispatcher disableEventType: BlElementBorderChangedEvent.
	aBlock ensure: [ 
		anElement eventDispatcher enableEventType: BlElementBorderChangedEvent ]
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> escaped: anElement [

	downBorder := nil.
	
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> hover: anElement [

	self border: self hoveredBorder in: anElement
]

{ #category : #'border accessing' }
ToButtonBorderBasedStateDresser >> hoveredBorder [

	^ downBorder ifNil: [ (BlBorder paint: Color gray width: 1) ]

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> initialState: anElement [

	initialBorder ifNil: [ initialBorder := anElement border ].
	self border: initialBorder in: anElement

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> leaved: anElement [

	self border: initialBorder in: anElement

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement when: BlElementBorderChangedEvent do: [ initialBorder := anElement border ].
	downBorder := nil
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> pressed: anElement [

	self border: self pressedBorder in: anElement.
	downBorder := anElement border.

]

{ #category : #'border accessing' }
ToButtonBorderBasedStateDresser >> pressedBorder [

	^ BlBorder paint: Color gray width: 2
]
