Class {
	#name : 'ToBeeSkin',
	#superclass : 'ToStyleSheetSkin',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'event handling' }
ToBeeSkin >> installLookEvent: anEvent [

	anEvent elementDo: [ :e | e installBeeStyle ].
	super installLookEvent: anEvent

]
