"
A skin is an event handler that manages `ToSkinEvent` events.
The event that is dispatched when a skin is installed is a `ToInstallSkinEvent`.
If a particular skin implements a #installSinEvent: method, then, it is runned when the skin is installed.
To set the skin of an element, use the `#defaultRawSkin:` method (theme dependent)
"
Class {
	#name : #ToDemoSkin1,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #'event handling' }
ToDemoSkin1 >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e background: Color blue.
		e size: 50 @ 50 ]
]
