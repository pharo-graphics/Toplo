Class {
	#name : #ToTreeNodeSubAndMethSkin,
	#superclass : #ToTreeNodeSkin,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #'event handling' }
ToTreeNodeSubAndMethSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e startElement addChild: (self newIconForNode: e) ]
]

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> newIconForNode: aNode [

	| icon item |
	item := aNode holder treeDataItem.
	icon := ToImage new.

	icon innerImage: (Smalltalk ui iconNamed: (item isClass
			 ifTrue: [ #class ]
			 ifFalse: [ #page ])).
	icon constraintsDo: [ :c |
		c linear horizontal alignLeft.
		c linear vertical alignCenter ].

	^ icon
]
