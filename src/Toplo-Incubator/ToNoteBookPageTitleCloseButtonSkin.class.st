Class {
	#name : 'ToNoteBookPageTitleCloseButtonSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNoteBookPageTitleCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: (Color red alpha: 0.5) ]
]

{ #category : 'event handling' }
ToNoteBookPageTitleCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | e padding: BlInsets empty ]
]
