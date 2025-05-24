Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| w arrow startContent interspace |
		interspace := e valueOfTokenNamed: #'node-interspace'.
		startContent := ToElement new.
		startContent layout: BlLinearLayout horizontal.
		w := (e nodeDepth + 1) * interspace.
		startContent padding: (BlInsets left: w).
		arrow := self newStartElementForNode: e.
		arrow margin: (BlInsets right: interspace).
		arrow 
			id: #arrow.
		e isLeaf ifFalse: [
			arrow newClickAction: [ :evt |
				evt consume.
				e toggle ] ].
		startContent addChild: arrow at: 1.
		e content startInterspace: interspace.
		e content startElement: startContent]
]

{ #category : #icons }
ToTreeNodeSkin >> newStartElementForNode: aNode [

	| arrowIcon aWrapper |
	aWrapper := aNode holder dataItem.
	arrowIcon := ToImage new.
	arrowIcon constraintsDo: [ :c |
		c linear horizontal alignLeft.
		c linear vertical alignCenter ].
	arrowIcon size:
		(aNode holder listElement valueOfTokenNamed:
			 #'submenu-arrow-breadth') asPoint.
	aWrapper isLeaf ifFalse: [
		| arrowTk |
		arrowTk := aWrapper isExpanded
			           ifFalse: [ #'submenu-arrow-right' ]
			           ifTrue: [ #'submenu-arrow-down' ].
		arrowIcon innerImage:
			(aNode holder listElement valueOfTokenNamed: arrowTk) ].

	^ arrowIcon
]

{ #category : #'event handling' }
ToTreeNodeSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
