Class {
	#name : 'ToNotebookPageButtonSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNotebookPageButtonSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e selectedBackground ]
]

{ #category : 'event handling' }
ToNotebookPageButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSelected
			ifTrue: [ e background: e selectedBackground ]
			ifFalse: [ e background: e hoveredBackground ] ]
]

{ #category : 'event handling' }
ToNotebookPageButtonSkin >> leavedLookEvent: anEvent [

	anEvent elementDo: [ :e | e isSelected ifTrue: [ ^ self ] ].
	super leavedLookEvent: anEvent.

]

{ #category : 'event handling' }
ToNotebookPageButtonSkin >> pressedLookEvent: anEvent [

	anEvent elementDo: [ :e | e page isSelected ifTrue: [ ^ self ] ].
	super pressedLookEvent: anEvent
]

{ #category : 'event handling' }
ToNotebookPageButtonSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]
