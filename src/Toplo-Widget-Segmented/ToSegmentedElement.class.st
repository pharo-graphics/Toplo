Class {
	#name : #ToSegmentedElement,
	#superclass : #ToElement,
	#traits : 'TToItemListHolder + TToOrientable',
	#classTraits : 'TToItemListHolder classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #accessing }
ToSegmentedElement >> addLabel: aLabel [

	self addItem: (ToSegmentedButton new
			 label: aLabel;
			 yourself)
]

{ #category : #accessing }
ToSegmentedElement >> addLabelText: aText [

	self addItem: (ToSegmentedButton new
			 label: (ToLabel text: aText);
			 yourself)
]

{ #category : #accessing }
ToSegmentedElement >> addLabelText: aText withIcon: anIcon [

	self addItem: (ToSegmentedButton new
			 label: (ToLabel text: aText);
			 icon: anIcon;
			 yourself)
]

{ #category : #accessing }
ToSegmentedElement >> addLabelText: aText withIconImage: anImage [

	self addItem: (ToSegmentedButton new
			 label: (ToLabel text: aText);
			 icon: (ToImage inner: anImage))
]

{ #category : #'t - item list holder - initializing' }
ToSegmentedElement >> configureLayout [

	self itemList configureLayoutIn: self
]

{ #category : #initialization }
ToSegmentedElement >> defaultEventHandler [

	^ ToSegmentedElementEventHandler new
]

{ #category : #initialization }
ToSegmentedElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #'focus requesting' }
ToSegmentedElement >> focusHolder [ 

	^ self itemList
]

{ #category : #accessing }
ToSegmentedElement >> group [

	^ self itemList group
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	self addChild: self itemList.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemList
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self addEventHandler: self defaultEventHandler
]

{ #category : #'t - orientable - accessing' }
ToSegmentedElement >> layoutStrategy [

	^ self layout 

	
]

{ #category : #'t - item list holder - accessing' }
ToSegmentedElement >> newItemList [

	^ ToSegmentedListElement new
]

{ #category : #skin }
ToSegmentedElement >> newRawSkin [ 

	^ ToSegmentedElementSkin new
]

{ #category : #'t - item list holder - double dispatch' }
ToSegmentedElement >> onAddedSegmentedButton: aButton [

]

{ #category : #'t - item list holder - double dispatch' }
ToSegmentedElement >> onRemovedSegmentedButton: aButton [
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> withStrictCheckingStrategy [

	self itemList withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> withWeakCheckingStrategy [

	self itemList withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> withoutCheckingStrategy [

	self itemList withoutCheckingStrategy
]
