Class {
	#name : #ToMenuContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'event handling' }
ToMenuContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'menu-window-padding-H')
				 vertical: (e valueOfTokenNamed: #'menu-window-padding-V')).
		e effect: (e valueOfTokenNamed: #'effect-window') ]
]

{ #category : #'event handling' }
ToMenuContainerSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e valueOfTokenNamed: #'window-opening-animation') value: e ]
]
