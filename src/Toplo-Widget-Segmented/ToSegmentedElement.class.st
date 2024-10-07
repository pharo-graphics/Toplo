Class {
	#name : #ToSegmentedElement,
	#superclass : #ToElement,
	#traits : 'TToCheckableGroupHolder + TToOrientable',
	#classTraits : 'TToCheckableGroupHolder classTrait + TToOrientable classTrait',
	#instVars : [
		'barElement'
	],
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #accessing }
ToSegmentedElement >> barElement [ 

	^ barElement
]

{ #category : #accessing }
ToSegmentedElement >> dataAccessor [

	self
		deprecated: 'Use #segmentAccessor'
		transformWith: '`@rcvr dataAccessor' -> '`@rcvr segmentAccessor'.
	^ self segmentAccessor
]

{ #category : #initialization }
ToSegmentedElement >> defaultEventHandler [

	^ ToSegmentedElementEventHandler new
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	self layout: BlLinearLayout new.
	barElement := ToSegmentedBarElement new.
	barElement matchParent.
	self addChild: barElement.
	self addEventHandler: self defaultEventHandler.

]

{ #category : #'t - orientable - accessing' }
ToSegmentedElement >> layoutStrategy [

	^ self layout

	
]

{ #category : #'instance creation' }
ToSegmentedElement >> newRawSkin [ 

	^ ToSegmentedSkin new
]

{ #category : #accessing }
ToSegmentedElement >> nodeAutoDistribution: aBoolean [

	barElement nodeAutoDistribution: aBoolean
]

{ #category : #accessing }
ToSegmentedElement >> nodeScrolling: aBoolean [

	barElement nodeScrolling: aBoolean
]

{ #category : #accessing }
ToSegmentedElement >> nodeWrapping: aBoolean [

	barElement nodeWrapping: aBoolean
]

{ #category : #accessing }
ToSegmentedElement >> primarySelectionMode [

	^ barElement primarySelectionMode
]

{ #category : #'t - checkable holder' }
ToSegmentedElement >> rawGroup [ 

	^ barElement rawGroup 
]

{ #category : #'t - checkable holder' }
ToSegmentedElement >> rawGroup: aGroup [

	self shouldNotImplement
]

{ #category : #accessing }
ToSegmentedElement >> secondarySelectionMode [

	^ barElement secondarySelectionMode
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [ 

	^ barElement dataAccessor 
]

{ #category : #accessing }
ToSegmentedElement >> selectionModel [ 

	^ barElement selectionModel
]

{ #category : #accessing }
ToSegmentedElement >> uniformNodeWidth: aBoolean [

	barElement uniformNodeWidth: aBoolean
]
