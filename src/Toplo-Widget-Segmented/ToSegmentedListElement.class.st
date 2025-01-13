"
I'm list whose contents is a segmented element (i.e. a list of toggle elements)
"
Class {
	#name : #ToSegmentedListElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #layout }
ToSegmentedListElement >> configureLayoutIn: aSegmentedElement [

	self matchParent.
	self horizontal: aSegmentedElement isHorizontal.
	aSegmentedElement isHMatchParent ifFalse: [ self hFitContent ].
	aSegmentedElement isVMatchParent ifFalse: [ self vFitContent ].
	self configureLayout
]

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

	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - checkable group owner' }
ToSegmentedListElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group owner' }
ToSegmentedListElement >> rawGroup: aGroup [

	self shouldNotImplement 
]
