Class {
	#name : #ToTreeNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| w arrow |
		w := (e nodeDepth + 1) * 20.
		arrow := self newStartElementForNode: e.
		arrow 
			id: #arrow;
			margin: (BlInsets left: w right: 20).
		e isLeaf ifFalse: [
			arrow addEventHandlerOn: BlClickEvent do: [ :evt |
				evt consume.
				e toggle ] ].
		e addChild: arrow at: 1 ]
]

{ #category : #icons }
ToTreeNodeSkin >> newStartElementForNode: aNode [

	| arrowIcon aWrapper |
	aWrapper := aNode holder dataItem.
	arrowIcon := ToImage new.
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
	anEvent elementDo: [ :e |
		| arrow |
		arrow := e childWithId: #arrow ifNone: [  ].
		arrow removeFromParent ]
]
