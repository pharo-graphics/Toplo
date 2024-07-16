Class {
	#name : #ToSegmentedBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToCheckableHolder',
	#classTraits : 'TToCheckableHolder classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #visiting }
ToSegmentedBarElement >> accept: aVisitor [

	aVisitor visitSegmentedBarElement: self
]

{ #category : #accessing }
ToSegmentedBarElement >> checkableElementAccessor [
	"according to the specific vocabulary - the data items are checkables of the checkable bar element "

	^ self dataAccessor
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultEventHandler [

	^ ToSegmentedEventHandler new
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultPrimarySelectionModeClass [

	^ ToSegmentedSelectionMode
]

{ #category : #initialization }
ToSegmentedBarElement >> initialize [

	super initialize.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ]
]

{ #category : #layout }
ToSegmentedBarElement >> layoutConfigurator [ 

	^ ToSegmentedConfigurator new
]

{ #category : #skin }
ToSegmentedBarElement >> newRawSkin [ 

	^ ToSegmentedBarElementSkin new
]

{ #category : #'t - checkable holder' }
ToSegmentedBarElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable holder' }
ToSegmentedBarElement >> rawGroup: aGroup [

	self shouldNotImplement 
]

{ #category : #accessing }
ToSegmentedBarElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are checkables of the checkable bar element "

	^ self dataAccessor
]

{ #category : #testing }
ToSegmentedBarElement >> wantsHMatchParent [

	^ self isVertical and: [ nodeWrapping not ]
]
