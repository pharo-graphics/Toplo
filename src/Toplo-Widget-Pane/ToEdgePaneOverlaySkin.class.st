Class {
	#name : #ToEdgePaneOverlaySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'event handling' }
ToEdgePaneOverlaySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (Color veryLightGray alpha: 0.6) ]
]
