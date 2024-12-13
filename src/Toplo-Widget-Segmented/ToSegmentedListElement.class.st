Class {
	#name : #ToSegmentedListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #initialization }
ToSegmentedListElement >> defaultEventHandler [

	^ ToSegmentedListElementEventHandler new
]

{ #category : #initialization }
ToSegmentedListElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #initialization }
ToSegmentedListElement >> initialize [

	super initialize.

	self fitContent.
	
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.

	self primarySelectionMode makeDisabledUnselectable: true.

	self nodeWrapping: true.
	self vertical: false.
	self uniformNodeWidth: true
]

{ #category : #'t - checkable group owner' }
ToSegmentedListElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group owner' }
ToSegmentedListElement >> rawGroup: aGroup [

	self shouldNotImplement 
]
