Class {
	#name : #ToMenuWindowSkin,
	#superclass : #ToBasicWindowElementSkin,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'event handling' }
ToMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'menu-window-padding-H')
					 vertical: (e valueOfTokenNamed: #'menu-window-padding-V')).
			e menuItem isSubmenu ifFalse: [
				e effect: (e valueOfTokenNamed: #'effect-window') ] ]
]

{ #category : #'event handling' }
ToMenuWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e valueOfTokenNamed: #'window-opening-animation') value: e ]
]
