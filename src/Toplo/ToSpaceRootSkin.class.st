Class {
	#name : 'ToSpaceRootSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'event handling' }
ToSpaceRootSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e tokenValueNamed: #'background-color') ]
]
