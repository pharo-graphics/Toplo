Class {
	#name : #ToFiniteListTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> addHolder: anHolder at: aPosition [

	| container |
	container := anHolder nodeContainer.
	self addChild: container at: aPosition
]

{ #category : #configuration }
ToFiniteListTrackElement >> applyConfiguration [

	super applyConfiguration.
	self configureLayout.
	self configureResizer.
	self childrenDo: [ :child | child applyConfiguration ]
]

{ #category : #configuration }
ToFiniteListTrackElement >> autoDistribute [

	^ listElement innerConfiguration autoDistribute
]

{ #category : #configuration }
ToFiniteListTrackElement >> configureLayout [

	(self layout class = self newLayoutStrategyClass and: [
		 self layout orientation isHorizontal = self isHorizontal ])
		ifFalse: [ self layout: self newLayoutStrategy ].
	self layout uniformNodeWidth: self uniformNodeWidth.
	self layout uniformNodeHeight: self uniformNodeHeight.
]

{ #category : #configuration }
ToFiniteListTrackElement >> configureResizer [

	(self isFlowable not and: [
		 self isScrollable and: [ self autoDistribute not ] ])
		ifTrue: [
				self isHorizontal
					ifTrue: [ self hFitContent ]
					ifFalse: [ self vFitContent ] ]
		ifFalse: [
				listElement isHFitContent
					ifTrue: [ self hFitContent ]
					ifFalse: [ self hMatchParent ].
				listElement isVFitContent
					ifTrue: [ self vFitContent ]
					ifFalse: [ self vMatchParent ] ]
]

{ #category : #layout }
ToFiniteListTrackElement >> flowLayoutClass [

	^ ToFiniteListFlowLayout
]

{ #category : #initialization }
ToFiniteListTrackElement >> initialize [

	super initialize.
	self focusability: BlFocusability ignore
]

{ #category : #configuration }
ToFiniteListTrackElement >> isFlowable [

	^ listElement innerConfiguration isFlowable
]

{ #category : #configuration }
ToFiniteListTrackElement >> isHorizontal [

	^ listElement isHorizontal
]

{ #category : #configuration }
ToFiniteListTrackElement >> isScrollable [

	^ listElement innerConfiguration isScrollable
]

{ #category : #layout }
ToFiniteListTrackElement >> linearLayoutClass [

	^ ToFiniteListLinearLayout
]

{ #category : #accessing }
ToFiniteListTrackElement >> listElement [ 

	^ listElement 
]

{ #category : #layout }
ToFiniteListTrackElement >> newFlowLayout [

	^ self isHorizontal
		  ifTrue: [ self flowLayoutClass horizontal ]
		  ifFalse: [ self flowLayoutClass vertical ]
]

{ #category : #layout }
ToFiniteListTrackElement >> newLayoutStrategy [

	^ self isFlowable
		  ifTrue: [ self newFlowLayout ]
		  ifFalse: [ self newLinearLayout ]
]

{ #category : #layout }
ToFiniteListTrackElement >> newLayoutStrategyClass [

	^ self isFlowable
		  ifTrue: [ self flowLayoutClass ]
		  ifFalse: [ self linearLayoutClass ]
]

{ #category : #layout }
ToFiniteListTrackElement >> newLinearLayout [

	^ self isHorizontal
		  ifTrue: [ self linearLayoutClass horizontal ]
		  ifFalse: [ self linearLayoutClass vertical ]
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> nodeContainers [

	^ self children
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> nodeContainersDetect: aBlock [

	self nodeContainersDo: [ :container | (aBlock value: container) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> nodeContainersDo: aBlock [

	self childrenDo: [ :container | aBlock value: container ]
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> nodeContainersReject: aBlock [

	^ self nodeContainersSelect: [ :container | (aBlock value: container) not ]
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> nodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> nodeContainersWithIndexDo: aBlock [

	| idx |
	idx := 1.
	self nodeContainersDo: [ :container |
			aBlock value: container value: idx.
			idx := idx + 1 ]
]

{ #category : #initialization }
ToFiniteListTrackElement >> onListElement: aListElement [

	listElement := aListElement 
]

{ #category : #layout }
ToFiniteListTrackElement >> onMeasure: anExtentMeasurementSpec [

	self layout minNodeWidth: listElement minNodeWidth.
	super onMeasure: anExtentMeasurementSpec
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: [ :container |
		container isPartlyVisibleInListElement ifTrue: [ aBlock value: container ] ]
]

{ #category : #'accessing - children' }
ToFiniteListTrackElement >> removeNodeContainer: container [

	container removeFromParent
]

{ #category : #configuration }
ToFiniteListTrackElement >> uniformNodeHeight [

	^ listElement innerConfiguration uniformNodeHeight
]

{ #category : #configuration }
ToFiniteListTrackElement >> uniformNodeWidth [

	^ listElement innerConfiguration uniformNodeWidth
]
