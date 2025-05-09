Class {
	#name : #ToTabNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Tab'
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
				(anItemElement valueOfTokenNamed: #'color-text-disabled') ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e | self configureSelectionTokensIn: e ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeButtonDo: [ :rb |
			rb visibility: BlVisibility visible.
			(e valueOfTokenNamed: #'animation-window-opening') value: rb ].
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| listElement leftPad rightPad topPad bottomPad |
		listElement := e holder listElement.
		leftPad := rightPad := e valueOfTokenNamed: #'padding-content-HS'.
		topPad := bottomPad := e valueOfTokenNamed: #'padding-content-VS'.
		e removeButtonDo: [ :rb |
			rb visibility: BlVisibility hidden.
			rb constraintsDo: [ :c |
				leftPad := leftPad + 15.
				(listElement isVertical and: [ listElement atStartSide not ])
					ifTrue: [
						c ignored horizontal alignRight.
						rightPad := rightPad + 15 ]
					ifFalse: [
						c ignored horizontal alignLeft.
						"leftPad := leftPad + 15" ].
				c ignored vertical alignCenter ] ].

		e padding: (BlInsets
				 top: topPad
				 left: leftPad
				 bottom: bottomPad
				 right: rightPad) ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeButtonDo: [ :rb | rb visibility: BlVisibility hidden ].
		e mouseCursor: Cursor normal ]
]
