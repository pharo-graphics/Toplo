Class {
	#name : #ToTabNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabNodeSkin >> configureSelectionTokensIn: anItemElement [

	anItemElement holder listElement isWrapping
		ifTrue: [
			anItemElement removeTokenNamed: #'selected-focused-foreground'.
			anItemElement removeTokenNamed: #'selected-unfocused-foreground' ]
		ifFalse: [
			anItemElement
				addTokenNamed: #'selected-focused-foreground'
				withValue:
				(anItemElement valueOfTokenNamed:
					 #'color-primary-selection-focused').
			anItemElement
				addTokenNamed: #'selected-unfocused-foreground'
				withValue:
				(anItemElement valueOfTokenNamed:
					 #'color-primary-selection-focused') ]
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
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToTabNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| listElement leftPad rightPad topPad bottomPad |
		leftPad := rightPad := e valueOfTokenNamed: #'padding-content-H'.
		topPad := bottomPad := e valueOfTokenNamed: #'padding-content-V'.
		listElement := e holder listElement.

		listElement isVertical
			ifTrue: [
				listElement atStartSide
					ifTrue: [ rightPad := rightPad + 15 ]
					ifFalse: [ leftPad := leftPad + 15 ] ]
			ifFalse: [
				listElement atStartSide
					ifTrue: [ bottomPad := bottomPad + 5 ]
					ifFalse: [ topPad := topPad + 5 ] ].

		e removeButtonDo: [ :rb |
			rb constraintsDo: [ :c |
				(listElement isVertical and: [ listElement atStartSide not ])
					ifTrue: [
						rightPad := rightPad + 15.
						c ignored horizontal alignRight ]
					ifFalse: [
						leftPad := leftPad + 15.
						c ignored horizontal alignLeft ].
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
		e mouseCursor: Cursor normal ]
]
