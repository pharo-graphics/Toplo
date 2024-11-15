Class {
	#name : #ToSegmentedBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #initialization }
ToSegmentedBarElement >> defaultEventHandler [

	^ ToSegmentedBarEventHandler new
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #initialization }
ToSegmentedBarElement >> initialize [

	super initialize.
	self primarySelectionMode makeDisabledUnselectable: true.
	self primarySelectionMode selectionOption grouped: false.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ]
]

{ #category : #skin }
ToSegmentedBarElement >> newRawSkin [ 

	^ ToSegmentedBarElementSkin new
]

{ #category : #'t - checkable group owner' }
ToSegmentedBarElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group owner' }
ToSegmentedBarElement >> rawGroup: aGroup [

	self shouldNotImplement 
]
