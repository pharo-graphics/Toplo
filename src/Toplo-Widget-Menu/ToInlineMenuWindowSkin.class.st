Class {
	#name : #ToInlineMenuWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Inline'
}

{ #category : #'event handling' }
ToInlineMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (Color veryLightGray alpha: 0.08) ]
]

{ #category : #'event handling' }
ToInlineMenuWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e valueOfTokenNamed: #'animation-window-opening') value: e ]
]
