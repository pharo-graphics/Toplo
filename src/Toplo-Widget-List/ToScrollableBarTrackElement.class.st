Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> addHolder: anHolder at: aPosition [

	| container |
	container := anHolder nodeContainer.
	self addChild: container at: aPosition
]

{ #category : #configuration }
ToScrollableBarTrackElement >> applyConfiguration [

	super applyConfiguration.
	self configureLayout.
	self configureResizer.
	self configureChildrenDistribution.
	self childrenDo: [ :child | child applyConfiguration ]
]

{ #category : #testing }
ToScrollableBarTrackElement >> autoDistribute [

	^ listElement autoDistribute
]

{ #category : #configuration }
ToScrollableBarTrackElement >> configureChildrenDistribution [

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
ToScrollableBarTrackElement >> configureLayout [

	(self layout class = self newLayoutStrategyClass and: [
		 self layout orientation isHorizontal = self isHorizontal ])
		ifTrue: [ ^ self ].
	self layout: self newLayoutStrategy
]

{ #category : #configuration }
ToScrollableBarTrackElement >> configureResizer [

	listElement isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

	listElement isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ]
]

{ #category : #layout }
ToScrollableBarTrackElement >> flowLayoutClass [

	^ ToBarFlowLayout
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
ToScrollableBarTrackElement >> newLayoutStrategyClass [

	^ self isFlowable
		  ifTrue: [ self flowLayoutClass ]
		  ifFalse: [ self linearLayoutClass ]
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

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainers [

	^ self children
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersDetect: aBlock [

	self nodeContainersDo: [ :container | (aBlock value: container) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersDo: aBlock [

	self childrenDo: [ :container | aBlock value: container ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersReject: aBlock [

	^ self nodeContainersSelect: [ :container | (aBlock value: container) not ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodeContainersWithIndexDo: aBlock [

	| idx |
	idx := 1.
	self nodeContainersDo: [ :container |
			aBlock value: container value: idx.
			idx := idx + 1 ]
]

{ #category : #initialization }
ToScrollableBarTrackElement >> onListElement: aListElement [

	listElement := aListElement 
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: [ :container |
		container isPartlyVisibleInListElement ifTrue: [ aBlock value: container ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeAllNodeContainers: anArray [

	anArray reverseDo: [ :container | self removeNodeContainer: container ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> removeNodeContainer: container [

	container removeFromParent
]
