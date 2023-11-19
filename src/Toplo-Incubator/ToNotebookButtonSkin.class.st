Class {
	#name : 'ToNotebookButtonSkin',
	#superclass : 'ToGeneralButtonSkin',
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
		e isChecked
			ifTrue: [ e background: e selectedBackground ]
			ifFalse: [ e background: e hoveredBackground ] ]
]

{ #category : 'event handling' }
ToNotebookButtonSkin >> leavedLookEvent: anEvent [

	anEvent elementDo: [ :e | e isChecked ifTrue: [ ^ self ] ].
	super leavedLookEvent: anEvent.

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
