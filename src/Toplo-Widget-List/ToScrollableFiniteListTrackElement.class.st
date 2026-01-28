Class {
	#name : #ToScrollableFiniteListTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> applyConfiguration [

	super applyConfiguration.
	self configureLayout.
	self configureResizer.
	self childrenDo: [ :child | child requestConfiguration ]
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> autoDistribute [

	^ listElement toConfiguration autoDistribute
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> configureLayout [

	(self layout class = self newLayoutStrategyClass and: [
		 self layout orientation isHorizontal = self isHorizontal ])
		ifFalse: [ self layout: self newLayoutStrategy ]
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> configureResizer [

	self fitParent: listElement.
	self isFlowable ifTrue: [ ^ self ].
	(self isScrollable and: [ self autoDistribute not ]) ifFalse: [
		^ self ].
	self isHorizontal
		ifTrue: [ self hFitContent ]
		ifFalse: [ self vFitContent ]
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> flowLayoutClass [

	^ BlFlowLayout
]

{ #category : #initialization }
ToScrollableFiniteListTrackElement >> initialize [

	super initialize.
	self focusability: BlFocusability ignore
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> isFlowable [

	^ listElement toConfiguration isFlowable
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> isHorizontal [

	^ listElement isHorizontal
]

{ #category : #configuration }
ToScrollableFiniteListTrackElement >> isScrollable [

	^ listElement toConfiguration isScrollable
]

{ #category : #layout }
ToScrollableFiniteListTrackElement >> linearLayoutClass [

	^ BlLinearLayout
]

{ #category : #accessing }
ToScrollableFiniteListTrackElement >> listElement [ 

	^ listElement 
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
ToScrollableFiniteListTrackElement >> nodeContainersDo: aBlock [

	self childrenDo: [ :container | aBlock value: container ]
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
ToScrollableFiniteListTrackElement >> removeNodeContainer: container [

	container removeFromParent
]
