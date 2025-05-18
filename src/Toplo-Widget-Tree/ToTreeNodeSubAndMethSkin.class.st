Class {
	#name : #ToTreeNodeSubAndMethSkin,
	#superclass : #ToTreeNodeSkin,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> classIcon [
	"this icon comes from smalltalk ui icons"

	^ #class
]

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> methodIcon [
	"this icon comes from smalltalk ui icons"

	^ #page
]

{ #category : #icons }
ToTreeNodeSubAndMethSkin >> newIconForNode: aNode [

	| arrowIcon aWrapper |
	aWrapper := aNode holder dataWrapper.
	arrowIcon := ToImage new.

	Smalltalk ui iconNamed: (aWrapper dataItem isClass
			 ifTrue: [ self classIcon ]
			 ifFalse: [ self methodIcon ]).

	^ arrowIcon
]
