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
ToButtonBorderBasedStateDresser >> clicked: anElement [

	downBorder := nil.
	anElement border: self hoveredBorder 

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> escaped: anElement [

	downBorder := nil.
	
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> hover: anElement [

	anElement border: self hoveredBorder 

]

{ #category : #'border accessing' }
ToButtonBorderBasedStateDresser >> hoveredBorder [

	^ downBorder ifNil: [ (BlBorder paint: Color gray width: 1) ]

]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> initialState: anElement [

	initialBorder ifNil: [ initialBorder := anElement border ].
	anElement border: initialBorder
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> leaved: anElement [

	anElement border: initialBorder
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement border: BlBorder empty.	
	downBorder := nil
]

{ #category : #'api - hooks' }
ToButtonBorderBasedStateDresser >> pressed: anElement [

	anElement border: self pressedBorder.
	downBorder := anElement border.

]

{ #category : #'border accessing' }
ToButtonBorderBasedStateDresser >> pressedBorder [

	^ BlBorder paint: Color gray width: 2
]
