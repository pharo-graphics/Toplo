Class {
	#name : #ToBarNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToBarNode >> applyWidgetConfiguration [

	| bar |
	super applyWidgetConfiguration.
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
		event consume.
		event currentTarget removeFromBar ]
	
]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
