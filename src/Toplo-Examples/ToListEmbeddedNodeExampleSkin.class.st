Class {
	#name : #ToListEmbeddedNodeExampleSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToListEmbeddedNodeExampleSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: Color transparent.
			e removeTokenNamed: #'selected-focused-foreground'.
			e removeTokenNamed: #'selected-unfocused-foreground' ]
]

{ #category : #'event handling' }
ToListEmbeddedNodeExampleSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e addTokenNamed: #'selected-focused-foreground'  withValue: Color green muchDarker.
		e addTokenNamed: #'selected-unfocused-foreground'  withValue: Color green muchDarker.
		e background: Color lightGreen ]
]
