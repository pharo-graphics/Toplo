Class {
	#name : #ToCheckableListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToCheckableListElement >> defaultNodeManagerClass [ 

	^ ToCheckableNodeManager
]

{ #category : #initialization }
ToCheckableListElement >> initialize [ 

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
