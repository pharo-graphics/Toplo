Class {
	#name : #ToScrollableFiniteListTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> addHolder: anHolder at: aPosition [

	| container |
	container := anHolder nodeContainer.
	self addChild: container at: aPosition
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> applyConfiguration [

	super applyConfiguration.
	self configureLayout.
	self configureResizer.
	self configureChildrenDistribution.
	self childrenDo: [ :child | child applyConfiguration ]
]

{ #category : #testing }
ToScrollableFiniteListTrackElement >> autoDistribute [

	^ listElement autoDistribute
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> configureChildrenDistribution [

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
							ifFalse: [ self vFitContent ] ] ]
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> configureLayout [

	(self layout class = self newLayoutStrategyClass and: [
		 self layout orientation isHorizontal = self isHorizontal ])
		ifFalse: [ self layout: self newLayoutStrategy ].
	self layout uniformNodeWidth: self uniformNodeWidth.
	self layout uniformNodeHeight: self uniformNodeHeight.
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> configureResizer [

	listElement isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

	listElement isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ]
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> flowLayoutClass [

	^ ToFiniteListFlowLayout
]

{ #category : #initialization }
ToScrollableFiniteListTrackElement >> initialize [

	super initialize.
	self focusability: BlFocusability ignore
]

{ #category : #testing }
ToScrollableFiniteListTrackElement >> isFlowable [

	^ listElement isFlowable
]

{ #category : #testing }
ToScrollableFiniteListTrackElement >> isHorizontal [

	^ listElement isHorizontal
]

{ #category : #testing }
ToScrollableFiniteListTrackElement >> isScrollable [

	^ listElement isScrollable
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> linearLayoutClass [

	^ ToFiniteListLinearLayout
]

{ #category : #accessing }
ToScrollableFiniteListTrackElement >> listElement [ 

	^ listElement 
]

{ #category : #accessing }
ToScrollableFiniteListTrackElement >> maxMeasuredNodeSize [

	^ self layout maxMeasuredNodeSize
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> newFlowLayout [

	^ self isHorizontal
		  ifTrue: [ self flowLayoutClass horizontal ]
		  ifFalse: [ self flowLayoutClass vertical ]
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> newLayoutStrategy [

	^ self isFlowable
		  ifTrue: [ self newFlowLayout ]
		  ifFalse: [ self newLinearLayout ]
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> newLayoutStrategyClass [

	^ self isFlowable
		  ifTrue: [ self flowLayoutClass ]
		  ifFalse: [ self linearLayoutClass ]
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> newLinearLayout [

	^ self isHorizontal
		  ifTrue: [ self linearLayoutClass horizontal ]
		  ifFalse: [ self linearLayoutClass vertical ]
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> nodeContainers [

	^ self children
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> nodeContainersDetect: aBlock [

	self nodeContainersDo: [ :container | (aBlock value: container) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> nodeContainersDo: aBlock [

	self childrenDo: [ :container | aBlock value: container ]
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> nodeContainersReject: aBlock [

	^ self nodeContainersSelect: [ :container | (aBlock value: container) not ]
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> nodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> nodeContainersWithIndexDo: aBlock [

	| idx |
	idx := 1.
	self nodeContainersDo: [ :container |
			aBlock value: container value: idx.
			idx := idx + 1 ]
]

{ #category : #initialization }
ToScrollableFiniteListTrackElement >> onListElement: aListElement [

	listElement := aListElement 
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: [ :container |
		container isPartlyVisibleInListElement ifTrue: [ aBlock value: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> removeAllNodeContainers: anArray [

	anArray reverseDo: [ :container | self removeNodeContainer: container ]
]

{ #category : #'accessing - children' }
ToScrollableFiniteListTrackElement >> removeNodeContainer: container [

	container removeFromParent
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> uniformNodeHeight [

	^ listElement uniformNodeHeight
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> uniformNodeWidth [

	^ listElement uniformNodeWidth
]
