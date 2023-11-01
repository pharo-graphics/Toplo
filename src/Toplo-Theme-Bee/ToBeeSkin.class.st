Class {
	#name : 'ToBeeSkin',
	#superclass : 'ToStyleSheetSkin',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'event handling' }
ToBeeSkin >> initialLookEvent: anEvent [

	anEvent elementDo: [ :e | e initialBeeStyle ].
	super initialLookEvent: anEvent

]

{ #category : 'event handling' }
ToBeeSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | e installBeeStyle ].

]
