Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Skin'
}

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [

	| elt |
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| align wrapper |
		wrapper := e holder dataWrapper.
		elt := self newStartElementForNode: e.
		align := wrapper nodeDepth * 20.
		elt
			size: 20 asPoint;
			id: #arrow;
			margin: (BlInsets left: align).
		wrapper isLeaf ifFalse: [
			elt addEventHandlerOn: BlClickEvent do: [ :evt |
				evt consume.
				wrapper toggle ] ].

		e startInterspace: 15.
		e startElement: elt ]
]

{ #category : #icons }
ToTreeNodeSkin >> newStartElementForNode: aNode [

	| align arrowIcon aWrapper |
	aWrapper := aNode holder dataWrapper.
	align := aWrapper nodeDepth * 20.
	arrowIcon := ToImage new.
	aWrapper isLeaf ifFalse: [
		| arrowTk |
		arrowTk := aWrapper isExpanded
			           ifFalse: [ self nodeCollapsedIcon ]
			           ifTrue: [ self nodeExpandedIcon ].
		arrowIcon innerImage:
			(aNode holder listElement valueOfTokenNamed: arrowTk) ].

	^ arrowIcon
]

{ #category : #icons }
ToTreeNodeSkin >> nodeCollapsedIcon [

	^ #'submenu-arrow-right'
]

{ #category : #icons }
ToTreeNodeSkin >> nodeExpandedIcon [

	^ #'submenu-arrow-down'
]
