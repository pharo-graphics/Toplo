Class {
	#name : 'ToSelectSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'event handling' }
ToSelectSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default ]
]

{ #category : 'event handling' }
ToSelectSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon: (ToImage inner: (self iconNamed: #bottom)) ]
]

{ #category : 'event handling' }
ToSelectSkin >> uninstallLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon: nil ]
]
