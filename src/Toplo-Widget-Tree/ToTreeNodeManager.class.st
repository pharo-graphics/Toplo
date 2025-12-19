Class {
	#name : #ToTreeNodeManager,
	#superclass : #ToWrappedListNodeManager,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #initialization }
ToTreeNodeManager >> buildNodeContainer: aTreeNodeContainer [

	| filler |
	super buildNodeContainer: aTreeNodeContainer.
	aTreeNodeContainer ensureStartContainer.
	filler := aTreeNodeContainer newFiller
		          id: #indentFiller;
		          yourself.
	aTreeNodeContainer startContainer addChild: filler.
	aTreeNodeContainer startContainer addChild:
		(self newArrowIconInNodeContainer: aTreeNodeContainer)
]

{ #category : #'children accessing' }
ToTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ #(  )
]

{ #category : #initialization }
ToTreeNodeManager >> defaultNodeContainerFactory [

	^ [ ToTreeNodeContainer new ]
]

{ #category : #initialization }
ToTreeNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToTreeNode new ]
]

{ #category : #initialization }
ToTreeNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToTreeNodeHolder new ]
]

{ #category : #'instance creation' }
ToTreeNodeManager >> newArrowIconInNodeContainer: aNodeContainer [

	| arrowIcon aWrapper |
	aWrapper := aNodeContainer holder dataWrapper.
	arrowIcon := ToIconicArrowButton none.
	aWrapper hasLeafDataItem ifFalse: [
			arrowIcon := aWrapper isExpanded
				             ifFalse: [ ToIconicArrowButton right ]
				             ifTrue: [ ToIconicArrowButton down ].
			arrowIcon clickAction: [
				aNodeContainer dispatchEvent: ToArrowButtonClickedEvent new ] ].

	arrowIcon id: #arrowIcon.
	arrowIcon constraintsDo: [ :c |
			c linear horizontal alignLeft.
			c linear vertical alignCenter ].
	^ arrowIcon
]
