Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Skin'
}

{ #category : #icons }
ToTreeNodeSkin >> iconAndIndentForNode: aNode [

	| align arrowIcon iconContainer arrowButton aWrapper |
	aWrapper := aNode holder dataWrapper.
	align := aWrapper nodeDepth * 20.
	arrowIcon := ToImage new.
	aWrapper isLeaf ifFalse: [
		| arrowTk |
		arrowTk := aWrapper isExpanded
			           ifFalse: [ self nodeCollapsedIcon ]
			           ifTrue: [ self nodeExpandedIcon ].
		arrowIcon innerImage:
			(aNode holder listElement valueOfTokenNamed: arrowTk) value ].
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
		arrowButton whenClickedDo: [ :evt | aWrapper toggle ]].
	

	^ iconContainer
]

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [

	| elt |
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		elt := self iconAndIndentForNode: e.
		e firstChild startElement: elt ]
]

{ #category : #icons }
ToTreeNodeSkin >> nodeCollapsedIcon [

	^ #'submenu-arrow-right'
]

{ #category : #icons }
ToTreeNodeSkin >> nodeExpandedIcon [

	^ #'submenu-arrow-down'
]
