Class {
	#name : #ToBarNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToBarNode >> applyConfiguration [

	| bar |
	super applyConfiguration.
	bar := self holder listElement.
	bar isFlowable
		ifTrue: [ self fitContent ]
		ifFalse: [
				bar isVertical
					ifTrue: [
							bar isHMatchParent
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ].
							bar autoDistribute
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ] ]
					ifFalse: [
							bar isVMatchParent
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ].
							bar autoDistribute
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ] ] ].
	self holder initializeNode.
	bar exactNodeWidth ifNotNil: [ :w | self width: w ].
	bar exactNodeHeight ifNotNil: [ :h | self height: h ]
]

{ #category : #'t - list node' }
ToBarNode >> clickEventHandlerClass [

	^  ToListNodeSelectionEventHandler
]

{ #category : #initialization }
ToBarNode >> initialize [

	super initialize.
	self addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
			| target listElement |
			" since the event is fired, on should stop it dispatching here "
			event consume.
			target := event currentTarget.
			listElement := target holder listElement.
			target removeFromBar.
			" Now the mouse move should be replayed because the mouse can be over the same remove button after the removal.
			It is postponed to let the node be re-built and configured before replaying "
			listElement postponeAction: [ :l | l requestMouseMoveReplay ] ]
]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
