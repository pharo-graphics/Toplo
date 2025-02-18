"
I'm list whose contents is a segmented element (i.e. a list of toggle elements)
"
Class {
	#name : #ToCheckableBarElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - list node holder' }
ToCheckableBarElement >> configureLayoutIn: aBarOwner [

	self matchParent.
	self horizontal: aBarOwner isHorizontal.
	aBarOwner isHMatchParent ifFalse: [ self hFitContent ].
	aBarOwner isVMatchParent ifFalse: [ self vFitContent ].
	self configureLayout
]

{ #category : #initialization }
ToCheckableBarElement >> defaultEventHandler [

	^ ToCheckableBarElementEventHandler new
]

{ #category : #'t - item list - accessing' }
ToCheckableBarElement >> defaultNodeManagerClass [ 

	^ ToCheckableBarNodeManager 
]

{ #category : #initialization }
ToCheckableBarElement >> initialize [

	super initialize.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.

	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.

	self primarySelectionMode makeDisabledUnselectable: true
]
