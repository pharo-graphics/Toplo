"
I am the skin of ToListTypeAheadOverlay: I style its label as a small rounded badge.
"
Class {
	#name : #ToListTypeAheadOverlaySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-TypeAhead'
}

{ #category : #'event handling' }
ToListTypeAheadOverlaySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e label
				geometry: (BlRoundedRectangleGeometry cornerRadius: (e valueOfTokenNamed: #'border-radius-SM'));
				border: (e valueOfTokenNamed: #'color-border');
				background: (e valueOfTokenNamed: #'color-bg-container');
				padding:
					(BlInsets horizontal: (e valueOfTokenNamed: #'padding-content-H') vertical: (e valueOfTokenNamed: #'padding-content-V'));
				effect: (e valueOfTokenNamed: #'effect-window') ]
]
