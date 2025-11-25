Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> addFakeNodeContainer: aNodeContainer [

	self fakeNodeContainer ifNotNil: [ Error signal: 'Fake node container already added' ].
	self addChild: aNodeContainer at: 1
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> addHolder: anHolder at: aPosition [

	| container |
	container := anHolder nodeContainer.
	self addChild: container at: aPosition + 1
]

{ #category : #configuration }
ToScrollableBarTrackElement >> applyConfiguration [

	super applyConfiguration.
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

	self childrenDo: [ :container | container applyConfiguration ]
]

{ #category : #testing }
ToScrollableBarTrackElement >> autoDistribute [

	^ listElement autoDistribute
]

{ #category : #accessing }
ToScrollableBarTrackElement >> fakeNodeContainer [

	^ self hasChildren
		  ifTrue: [ self firstChild ]
		  ifFalse: [ ]
]

{ #category : #accessing }
ToScrollableBarTrackElement >> fakeNodeContainerDo: aBlock [ 

	self fakeNodeContainer ifNotNil: [ :container | aBlock value: container ]
]

{ #category : #layout }
ToScrollableBarTrackElement >> flowLayoutClass [

	^ ToBarFlowLayout
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodeContainers [

	^ Array streamContents: [ :stream |
		  self fullyVisibleNodeContainersDo: [ :container | stream nextPut: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodeContainersDo: aBlock [

	self nodeContainersDo: [ :container |
		container isFullyVisibleInInnerElement ifTrue: [ aBlock value: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  container isFullyVisibleInInnerElement ifTrue: [
				  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ] ]
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
ToScrollableBarTrackElement >> listElement [ 

	^ listElement 
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
ToScrollableBarTrackElement >> nodeContainers [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container | stream nextPut: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersDetect: aBlock [

	self nodeContainersDo: [ :container | (aBlock value: container) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersDo: aBlock [

	self childrenDo: [ :container |
		container isFake ifFalse: [ aBlock value: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersWithIndexDo: aBlock [

	self nodeContainersDo: [ :container |
		aBlock value: container value: container holder position]
]

{ #category : #initialization }
ToScrollableBarTrackElement >> onListElement: aListElement [

	listElement := aListElement 
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: [ :container |
		container isPartlyVisible ifTrue: [ aBlock value: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeAllNodeContainers: anArray [

	anArray reverseDo: [ :container | self removeNodeContainer: container ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeFakeNodeContainer [

	self fakeNodeContainer ifNil: [ Error signal: 'Fake node container not present' ].
	self fakeNodeContainer removeFromParent.

]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeNodeContainer: container [

	container removeFromParent
]
