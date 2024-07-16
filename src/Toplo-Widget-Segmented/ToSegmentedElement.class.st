Class {
	#name : #ToSegmentedElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToCheckableHolder',
	#classTraits : 'TToOrientable classTrait + TToCheckableHolder classTrait',
	#instVars : [
		'barElement'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #accessing }
ToSegmentedElement >> flowLineUniformWidth: aBoolean [

	barElement flowLineUniformWidth: aBoolean
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	barElement := ToSegmentedBarElement new.
	barElement matchParent.
	self addChild: barElement
]

{ #category : #'t - orientable - accessing' }
ToSegmentedElement >> layoutStrategy [

	^ barElement layoutStrategy

	
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

	^ barElement selectionMode
]

{ #category : #accessing }
ToSegmentedElement >> selectionModel [ 

	^ barElement selectionModel
]
