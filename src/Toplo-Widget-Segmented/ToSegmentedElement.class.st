Class {
	#name : #ToSegmentedElement,
	#superclass : #ToBarElement,
	#traits : 'TToCheckableHolder',
	#classTraits : 'TToCheckableHolder classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #visiting }
ToSegmentedElement >> accept: aVisitor [

	aVisitor visitSegmentedElement: self
]

{ #category : #accessing }
ToSegmentedElement >> checkableElementAccessor [
	"according to the specific vocabulary - the data items are checkables of the checkable bar element "

	^ self dataAccessor
]

{ #category : #initialization }
ToSegmentedElement >> defaultEventHandler [

	^ ToSegmentedEventHandler new
]

{ #category : #initialization }
ToSegmentedElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #initialization }
ToSegmentedElement >> defaultSelectionModeClass [

	^ ToSegmentedSelectionMode
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].
	self selectionMode beNoneBeneathSelection
]

{ #category : #layout }
ToSegmentedElement >> layoutConfigurator [ 

	^ ToSegmentedConfigurator new
]

{ #category : #'t - checkable holder' }
ToSegmentedElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable holder' }
ToSegmentedElement >> rawGroup: aGroup [

	self shouldNotImplement 
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are checkables of the checkable bar element "

	^ self dataAccessor
]

{ #category : #testing }
ToSegmentedElement >> wantsHMatchParent [

	^ self isVertical and: [ nodeWrapping not ]
]
