Class {
	#name : #ToAddTabButtonSkin,
	#superclass : #ToIconicAddButtonSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToAddTabButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (e valueOfTokenNamed: #'border-paint') ]
]

{ #category : #'event handling' }
ToAddTabButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color transparent ]
]
