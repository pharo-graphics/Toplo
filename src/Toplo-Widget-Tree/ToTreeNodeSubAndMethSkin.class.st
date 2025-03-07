Class {
	#name : #ToTreeNodeSubAndMethSkin,
	#superclass : #ToTreeNodeSkin,
	#category : #'Toplo-Widget-Tree'
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
ToTreeNodeSubAndMethSkin >> newStartElementForNode: aNode [

	| arrowIcon aWrapper |
	aWrapper := aNode holder dataWrapper.
	arrowIcon := ToImage new.
	arrowIcon innerImage: (aWrapper isLeaf
			 ifFalse: [
				 aNode holder listElement valueOfTokenNamed: (aWrapper isExpanded
						  ifFalse: [ self nodeCollapsedIcon ]
						  ifTrue: [ self nodeExpandedIcon ]) ]
			 ifTrue: [
				 Smalltalk ui iconNamed: (aWrapper dataItem isClass
						  ifTrue: [ self classIcon ]
						  ifFalse: [ self methodIcon ]) ]).

	^ arrowIcon
]
