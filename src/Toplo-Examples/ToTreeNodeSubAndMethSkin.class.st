Class {
	#name : #ToTreeNodeSubAndMethSkin,
	#superclass : #ToTreeNodeSkin,
	#category : #'Toplo-Examples-TopLevel-Tree'
}

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> classIcon [
	"this icon comes from smalltalk ui icons"

	^ #class
]

{ #category : #'event handling' }
ToTreeNodeSubAndMethSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e addChild: (self newIconForNode: e) at: 2 ]
]

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> methodIcon [
	"this icon comes from smalltalk ui icons"

	^ #page
]

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> newIconForNode: aNode [

	| icon item |
	item := aNode holder treeDataItem.
	icon := ToImage new.

	icon innerImage: (Smalltalk ui iconNamed: (item isClass
			 ifTrue: [ self classIcon ]
			 ifFalse: [ self methodIcon ])).

	^ icon
]
