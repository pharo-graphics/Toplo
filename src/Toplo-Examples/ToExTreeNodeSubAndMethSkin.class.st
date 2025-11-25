Class {
	#name : #ToExTreeNodeSubAndMethSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #'event handling' }
ToExTreeNodeSubAndMethSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e childWithId: #itemIcon
				ifNone: [ e addChild: (self newIconForNode: e) at: 1] ]
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
	icon margin: (BlInsets right: interspace).
	^ icon
]

{ #category : #'event handling' }
ToExTreeNodeSubAndMethSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeChild: (e childWithId: #itemIcon e) ]
]
