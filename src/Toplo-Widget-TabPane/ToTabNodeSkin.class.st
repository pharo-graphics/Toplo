Class {
	#name : #ToTabNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #'event handling' }
ToTabNodeSkin >> configureSelectionTokensIn: anItemElement [

	anItemElement holder listElement isFlowable
		ifTrue: [
			anItemElement removeTokenNamed: #'selected-focused-foreground'.
			anItemElement removeTokenNamed: #'selected-unfocused-foreground' ]
		ifFalse: [
			anItemElement
				addTokenNamed: #'selected-focused-foreground'
				withValue:
				(anItemElement valueOfTokenNamed: #'color-primary-checked').
			anItemElement
				addTokenNamed: #'selected-unfocused-foreground'
				withValue:
				(anItemElement valueOfTokenNamed: #'color-primary-checked') ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeButtonDo: [ :rb |
			rb visibility: BlVisibility visible.
			(e valueOfTokenNamed: #'window-opening-animation') value: rb ].
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| listElement leftPad rightPad topPad bottomPad |
		listElement := e holder listElement.
		leftPad := rightPad := e valueOfTokenNamed: #'padding-content-H'.
		topPad := bottomPad := e valueOfTokenNamed: #'padding-content-V'.
		self configureSelectionTokensIn: e.
		e removeButtonDo: [ :rb |
			rb visibility: BlVisibility hidden.
			rb constraintsDo: [ :c |
				(listElement isVertical and: [ listElement atStartSide not ])
					ifTrue: [
						c anchors add: (c anchors rightAnchor on: e rightAnchor - 5).
						rightPad := rightPad + 15 ]
					ifFalse: [ 
						c anchors add: (c anchors leftAnchor on: e leftAnchor + 5).
						leftPad := leftPad + 15 ].
				c ignored vertical alignCenter ] ].
		e item constraintsDo: [ :c | c linear vertical alignCenter ]. 
		e padding: (BlInsets
				 top: topPad
				 left: leftPad
				 bottom: bottomPad
				 right: rightPad) ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeButtonDo: [ :rb | rb visibility: BlVisibility hidden ].
		e mouseCursor: Cursor normal ]
]
