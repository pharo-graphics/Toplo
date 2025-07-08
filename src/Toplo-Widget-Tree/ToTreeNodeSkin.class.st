Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| w arrow startElement interspace indent |
		interspace := e valueOfTokenNamed: #'node-interspace'.
		indent := e valueOfTokenNamed: #'node-indent'.
		startElement := ToElement new.
		startElement layout: BlLinearLayout horizontal.
		w := e nodeDepth * indent.
		startElement padding: (BlInsets left: w).
		arrow := self newStartElementForNode: e.
		startElement addChild: arrow at: 1.
		e startInterspace: interspace.
		e startElement: startElement ]
]

{ #category : #icons }
ToTreeNodeSkin >> newStartElementForNode: aNode [

	| arrowIcon aWrapper |
	aWrapper := aNode holder dataItem.
	arrowIcon := ToImage new.
	aWrapper hasLeafDataItem ifFalse: [
		arrowIcon := aWrapper isExpanded
			             ifFalse: [ ToIconicArrowButton right ]
			             ifTrue: [ ToIconicArrowButton down ].
		arrowIcon clickAction: [
			aNode dispatchEvent: ToArrowButtonClickedEvent new ] ].
	arrowIcon constraintsDo: [ :c |
		c linear horizontal alignLeft.
		c linear vertical alignCenter ].
	arrowIcon extent:
		(aNode holder listElement valueOfTokenNamed: #'iconic-arrow-breadth')
			asPoint.
	^ arrowIcon
]

{ #category : #'event handling' }
ToTreeNodeSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
