Class {
	#name : #ToExTreeNodeSubAndMethSkin,
	#superclass : #ToTreeNodeSkin,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #'event handling' }
ToExTreeNodeSubAndMethSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e startElement
				childWithId: #itemIcon
				ifNone: [ e startElement addChild: (self newIconForNode: e) ] ]
]

{ #category : #icons }
ToExTreeNodeSubAndMethSkin >> newIconForNode: aNode [

	| icon item interspace |
	item := aNode holder treeDataItem.
	icon := ToImage new
		        id: #itemIcon;
		        yourself.
	icon innerImage: (Smalltalk ui iconNamed: (item isClass
				  ifTrue: [ #class ]
				  ifFalse: [ #page ])).
	icon constraintsDo: [ :c |
			c linear horizontal alignLeft.
			c linear vertical alignCenter ].
	interspace := aNode valueOfTokenNamed: #'node-interspace'.
	icon margin: (BlInsets left: interspace).
	^ icon
]
