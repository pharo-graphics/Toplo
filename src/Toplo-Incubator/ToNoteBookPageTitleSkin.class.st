Class {
	#name : 'ToNoteBookPageTitleSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e page isSelected ifTrue: [ e background: e defaultBackground ] ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> leavedLookEvent: anEvent [

	anEvent elementDo: [ :e | e page isSelected ifTrue: [ ^ self ] ].
	super leavedLookEvent: anEvent.

]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> pressedLookEvent: anEvent [

	anEvent elementDo: [ :e | e page isSelected ifTrue: [ ^ self ] ].
	super pressedLookEvent: anEvent
]
