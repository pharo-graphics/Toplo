Class {
	#name : #ToSegmentedElement,
	#superclass : #ToElement,
	#traits : 'TToCheckableHolder + TToOrientable',
	#classTraits : 'TToCheckableHolder classTrait + TToOrientable classTrait',
	#instVars : [
		'barElement'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #accessing }
ToSegmentedElement >> barElement [ 

	^ barElement
]

{ #category : #initialization }
ToSegmentedElement >> defaultEventHandler [

	^ ToSegmentedElementEventHandler new
]

{ #category : #accessing }
ToSegmentedElement >> flowLineUniformWidth: aBoolean [

	barElement flowLineUniformWidth: aBoolean
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

	^ barElement segmentAccessor 
]

{ #category : #accessing }
ToSegmentedElement >> selectionMode [

	^ barElement primarySelectionMode
]

{ #category : #accessing }
ToSegmentedElement >> selectionModel [ 

	^ barElement selectionModel
]
