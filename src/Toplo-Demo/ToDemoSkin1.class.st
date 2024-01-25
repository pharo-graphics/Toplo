"
A skin is a BlEventHandler that manages ToElementLookEvent events.
The look event that is dispatched when a skin is installed is ToInstallLookEvent.
If a particular skin implements a #installLookEvent: method, then, it is runned when the skin is installed.
To set the skin of an element, one use the #defaultRawSkin: method (theme dependent)
"
Class {
	#name : #ToDemoSkin1,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #'event handling' }
ToDemoSkin1 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e background: Color blue.
		e size: 50 @ 50 ]
]
