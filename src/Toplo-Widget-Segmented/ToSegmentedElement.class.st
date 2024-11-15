Class {
	#name : #ToSegmentedElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToCheckableGroupOwner + TToBarElement',
	#classTraits : 'TToCheckableGroupOwner classTrait + TToBarElement classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #accessing }
ToSegmentedElement >> addLabel: aLabel [

	self segmentAccessor add: (ToSegmentedButton new
			 label: aLabel;
			 yourself)
]

{ #category : #accessing }
ToSegmentedElement >> addLabelText: aText [

	self segmentAccessor add: (ToSegmentedButton new
			 label: (ToLabel text: aText);
			 yourself)
]

{ #category : #accessing }
ToSegmentedElement >> addLabelText: aText withIcon: anIcon [

	self addLabelText: aText.
	self segmentAccessor last icon: anIcon
]

{ #category : #accessing }
ToSegmentedElement >> addLabelText: aText withIconImage: anImage [

	self addLabelText: aText withIcon: (ToImage inner: anImage)
]

{ #category : #initialization }
ToSegmentedElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToSegmentedElement >> defaultEventHandler [

	^ ToSegmentedElementEventHandler new
]

{ #category : #initialization }
ToSegmentedElement >> defaultNodeManagerClass [ 

	^ ToSegmentedNodeManager 
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.
	self matchParent.
	self configureLayout.
	self primarySelectionMode makeDisabledUnselectable: true.
	self primarySelectionMode selectionOption grouped: false.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ]
]

{ #category : #initialization }
ToSegmentedElement >> initializeInnerElement [

	super initializeInnerElement.
	self installFakeNode
]

{ #category : #skin }
ToSegmentedElement >> newRawSkin [ 

	^ ToSegmentedElementSkin new
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> rawGroup: aGroup [

	self shouldNotImplement 
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [ 

	^ self dataAccessor
]
