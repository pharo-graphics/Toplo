Class {
	#name : 'ToNoteBookPageTitleSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e page isSelected ifTrue: [ e background: e defaultBackground ] ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]
