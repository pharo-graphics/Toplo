"
I'm list whose contents is a segmented element (i.e. a list of toggle elements)
"
Class {
	#name : #ToSegmentedBarElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #layout }
ToSegmentedBarElement >> configureLayoutIn: aSegmentedElement [

	self matchParent.
	self horizontal: aSegmentedElement isHorizontal.
	aSegmentedElement isHMatchParent ifFalse: [ self hFitContent ].
	aSegmentedElement isVMatchParent ifFalse: [ self vFitContent ].
	self configureLayout
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultEventHandler [

	^ ToSegmentedListElementEventHandler new
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #initialization }
ToSegmentedBarElement >> initialize [

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
ToSegmentedBarElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group owner' }
ToSegmentedBarElement >> rawGroup: aGroup [

	self shouldNotImplement 
]
