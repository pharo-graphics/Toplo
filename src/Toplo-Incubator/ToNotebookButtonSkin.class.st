Class {
	#name : 'ToNotebookButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNotebookButtonSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e selectedBackground ]
]

{ #category : 'event handling' }
ToNotebookButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand.
		e border: (BlBorder paint: (e toValueOf: #'color-primary-hover') width: (e toValueOf: #'line-width')).
		e isChecked
			ifTrue: [ e background: e selectedBackground ]
			ifFalse: [ e background: e hoveredBackground ] ]
]

{ #category : 'event handling' }
ToNotebookButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder paint: (e toValueOf: #'color-border') width: (e toValueOf: #'line-width')).
		e padding: (BlInsets
				 top: (e toValueOf: #'padding-content-V')
				 left: (e toValueOf: #'padding-content-H')
				 bottom: (e toValueOf: #'padding-content-V')
				 right: (e toValueOf: #'padding-content-H')).
		e geometry: e defaultGeometry ]
]

{ #category : 'event handling' }
ToNotebookButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder paint: (e toValueOf: #'color-border') width: (e toValueOf: #'line-width')).
		e isChecked ifTrue: [ ^ self ] ].

]

{ #category : 'event handling' }
ToNotebookButtonSkin >> pressedLookEvent: anEvent [

	anEvent elementDo: [ :e | e isChecked ifTrue: [ ^ self ] ].
	super pressedLookEvent: anEvent
]

{ #category : 'event handling' }
ToNotebookButtonSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]
