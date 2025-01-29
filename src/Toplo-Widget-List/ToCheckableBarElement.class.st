"
I'm list whose contents is a segmented element (i.e. a list of toggle elements)
"
Class {
	#name : #ToCheckableBarElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'as yet unclassified' }
ToCheckableBarElement >> configureLayoutIn: aBarOwner [

	self matchParent.
	self horizontal: aBarOwner isHorizontal.
	aBarOwner isHMatchParent ifFalse: [ self hFitContent ].
	aBarOwner isVMatchParent ifFalse: [ self vFitContent ].
	self configureLayout
]

{ #category : #'as yet unclassified' }
ToCheckableBarElement >> defaultEventHandler [

	^ ToCheckableBarElementEventHandler new
]

{ #category : #initialization }
ToCheckableBarElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #'as yet unclassified' }
ToCheckableBarElement >> initialize [

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

{ #category : #'as yet unclassified' }
ToCheckableBarElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'as yet unclassified' }
ToCheckableBarElement >> rawGroup: aGroup [

	self shouldNotImplement 
]
