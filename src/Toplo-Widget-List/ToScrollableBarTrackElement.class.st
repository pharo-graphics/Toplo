Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> addFakeNode: aNode [

	| sizeHandler |
	fakeNode ifNotNil: [ self removeFakeNode ].
	fakeNode := aNode.
	aNode visibility: BlVisibility hidden.
	" The purpose of the size handler is to make a fake node remains invisible. 
	this is ensured by forcing the height to zero 
	(if the bar is vertical) or the width to zero 
	(if ther bar is horizontal).  "
	fakeNode whenLayoutedDoOnce: [
			fakeNode userData at: #fakeNodeOriginalSize put: fakeNode extent.
			self applyFakeNodeConfiguration ].

	sizeHandler := fakeNode
		               addEventHandlerOn: BlElementExtentChangedEvent
		               do: [ self applyFakeNodeConfiguration ].
	fakeNode userData at: #fakeNodeSizeHandler put: sizeHandler.
	self addChild: aNode at: 1
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> addHolder: anHolder at: aPosition [

	| node |
	node := anHolder node.
	self addChild: node at: aPosition + 1
]

{ #category : #configuration }
ToScrollableBarTrackElement >> applyFakeNodeConfiguration [

	fakeNode applyWidgetConfiguration.

	"in case my orientation changes the original size must be stored.
	The original size has to be stored before setting the height or the width to zero.
	see also addFakeNode:"

	self isHorizontal
		ifTrue: [
				fakeNode userData at: #fakeNodeOriginalSize ifPresent: [ :s |
						fakeNode height: s y.
						fakeNode width: 0 ] ]
		ifFalse: [
				fakeNode userData at: #fakeNodeOriginalSize ifPresent: [ :s |
						fakeNode width: s x.
						fakeNode height: 0 ] ].
	listElement updateAllSelections 
]

{ #category : #configuration }
ToScrollableBarTrackElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self layout: self newLayoutStrategy.

	listElement isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

	listElement isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ].

	self autoDistribute
		ifTrue: [
				self isHorizontal
					ifTrue: [
					listElement isHFitContent ifFalse: [ self hMatchParent ] ]
					ifFalse: [
					listElement isVFitContent ifFalse: [ self vMatchParent ] ] ]
		ifFalse: [
				(self isFlowable not and: [ self isScrollable ]) ifTrue: [
						self isHorizontal
							ifTrue: [ self hFitContent ]
							ifFalse: [ self vFitContent ] ] ].

	self applyFakeNodeConfiguration.
	self nodesDo: [ :n | n applyWidgetConfiguration ]
]

{ #category : #testing }
ToScrollableBarTrackElement >> autoDistribute [

	^ listElement autoDistribute
]

{ #category : #accessing }
ToScrollableBarTrackElement >> fakeNode [ 

	^ fakeNode
]

{ #category : #layout }
ToScrollableBarTrackElement >> flowLayoutClass [

	^ ToBarFlowLayout
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodes [

	^ Array streamContents: [ :stream |
		  self fullyVisibleNodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isFullyVisibleInInnerElement ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  node isFullyVisibleInInnerElement ifTrue: [
				  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ] ]
]

{ #category : #initialization }
ToScrollableBarTrackElement >> initialize [

	super initialize.
	self focusability: BlFocusability ignore
]

{ #category : #testing }
ToScrollableBarTrackElement >> isFlowable [

	^ listElement isFlowable
]

{ #category : #testing }
ToScrollableBarTrackElement >> isHorizontal [

	^ listElement isHorizontal
]

{ #category : #testing }
ToScrollableBarTrackElement >> isScrollable [

	^ listElement isScrollable
]

{ #category : #layout }
ToScrollableBarTrackElement >> linearLayoutClass [

	^ ToBarLinearLayout
]

{ #category : #accessing }
ToScrollableBarTrackElement >> maxMeasuredNodeSize [

	^ self layout maxMeasuredNodeSize
]

{ #category : #layout }
ToScrollableBarTrackElement >> newFlowLayout [

	^ (self isHorizontal
		   ifTrue: [ self flowLayoutClass horizontal ]
		   ifFalse: [ self flowLayoutClass vertical ])
		  uniformNodeWidth: listElement uniformNodeWidth;
		  uniformNodeHeight: listElement uniformNodeHeight;
		  yourself
]

{ #category : #layout }
ToScrollableBarTrackElement >> newLayoutStrategy [

	^ self isFlowable
		  ifTrue: [ self newFlowLayout ]
		  ifFalse: [ self newLinearLayout ]
]

{ #category : #layout }
ToScrollableBarTrackElement >> newLinearLayout [

	^ (self isHorizontal
		   ifTrue: [ self linearLayoutClass horizontal ]
		   ifFalse: [ self linearLayoutClass vertical ])
		  uniformNodeWidth: listElement uniformNodeWidth;
		  uniformNodeHeight: listElement uniformNodeHeight;
		  yourself
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodes [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesDetect: aBlock [

	self nodesDo: [ :node | (aBlock value: node) ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesDo: aBlock [

	self childrenDo: [ :node |
		node = fakeNode ifFalse: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesWithIndexDo: aBlock [

	self nodesDo: [ :node |
		aBlock value: node value: node holder position]
]

{ #category : #initialization }
ToScrollableBarTrackElement >> onListElement: aListElement [

	listElement := aListElement 
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isPartlyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeAllNodes: anArray [

	anArray reverseDo: [ :node | self removeNode: node ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeFakeNode [

	fakeNode ifNotNil: [
			| sizeHandler |
			" see #addFakeNode: and #applyFakeNodeConfiguration comments on sizeHandler and on fakeNodeOriginalSize "
			sizeHandler := fakeNode userData at: #fakeNodeSizeHandler.
			fakeNode removeEventHandler: sizeHandler.
			fakeNode userData removeKey: #fakeNodeSizeHandler.
			fakeNode userData removeKey: #fakeNodeOriginalSize ifAbsent: [].
			fakeNode removeFromParent.
			fakeNode visibility: BlVisibility visible. ].
	fakeNode := nil
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeNode: aNode [

	aNode removeFromParent
]
