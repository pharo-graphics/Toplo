Class {
	#name : #ToTreeNodeSubAndMethSkin,
	#superclass : #ToTreeNodeSkin,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'as yet unclassified' }
ToTreeNodeSubAndMethSkin >> classIcon [
	"this icon comes from smalltalk ui icons"

	^ #class
]

{ #category : #'as yet unclassified' }
ToTreeNodeSubAndMethSkin >> iconAndIndentForNode: aNode [

	| align arrowIcon iconContainer arrowButton aWrapper |
	aWrapper := aNode holder dataWrapper.
	align := aWrapper nodeDepth * 20.
	arrowIcon := ToImage new.
	arrowIcon innerImage:
		(aWrapper isLeaf
			ifFalse: [
				aNode holder listElement valueOfTokenNamed: (aWrapper isExpanded
						 ifFalse: [ self nodeCollapsedIcon ]
						 ifTrue: [ self nodeExpandedIcon ]) value ]
			ifTrue: [
				Smalltalk ui iconNamed: (aWrapper dataItem isClass
						 ifTrue: [ self classIcon ]
						 ifFalse: [ self methodIcon ]) ]).
	arrowIcon
		size: 18 asPoint;
		id: #arrow.
	iconContainer := ToElement new
		                 fitContent;
		                 yourself.
	iconContainer layout: BlLinearLayout horizontal.
	iconContainer addChild: (ToElement new size: align @ 0).
	arrowButton := ToButton new
		               icon: arrowIcon;
		               yourself.
	arrowButton addAllStamps: #( #iconic #borderless ).
	iconContainer addChild: arrowButton.
	aWrapper isLeaf ifFalse: [
		arrowButton whenClickedDo: [ :evt | aWrapper toggle ] ].


	^ iconContainer
]

{ #category : #'event handling' }
ToTreeNodeSubAndMethSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e holder dataItem isClass ifFalse: [
			e middleElement background: Color green ] ]
]

{ #category : #'as yet unclassified' }
ToTreeNodeSubAndMethSkin >> methodIcon [
	"this icon comes from smalltalk ui icons"
	^ #page
]
