Class {
	#name : #ToTabSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #'event handling' }
ToTabSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e selectedBackground ]
]

{ #category : #'event handling' }
ToTabSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary-hover') width: (e valueOfTokenNamed: #'line-width')).
		e isChecked
			ifTrue: [ e background: e selectedBackground ]
			ifFalse: [ e background: e hoveredBackground ] ]
]

{ #category : #'event handling' }
ToTabSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e vFitContent.
		e border: (BlBorder paint: (e valueOfTokenNamed: #'color-border') width: (e valueOfTokenNamed: #'line-width')).
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-content-H')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-content-H')).
		e geometry: e defaultGeometry ]
]

{ #category : #'event handling' }
ToTabSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e isChecked ifFalse: [e background: e defaultBackground].
		e border: (BlBorder paint: (e valueOfTokenNamed: #'color-border') width: (e valueOfTokenNamed: #'line-width')).
		e isChecked ifTrue: [ ^ self ] ].

]

{ #category : #'event handling' }
ToTabSkin >> pressedLookEvent: anEvent [

	anEvent elementDo: [ :e | e isChecked ifTrue: [ ^ self ] ].
	super pressedLookEvent: anEvent
]

{ #category : #'event handling' }
ToTabSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]
