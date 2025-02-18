Class {
	#name : #ToSegmentedElement,
	#superclass : #ToElement,
	#traits : 'TToItemListOwner + TToOrientable',
	#classTraits : 'TToItemListOwner classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'t - item bar owner - initializing' }
ToSegmentedElement >> configureLayout [

	self itemBar configureLayoutIn: self
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

	^ self itemBar
]

{ #category : #accessing }
ToSegmentedElement >> group [

	^ self itemBar group
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	self initializeAsItemBarOwner.

	self addChild: self itemBar.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy].

	self addEventHandler: self defaultEventHandler
]

{ #category : #'t - orientable - accessing' }
ToSegmentedElement >> layoutStrategy [

	^ self layout 

	
]

{ #category : #'t - item list owner - accessing' }
ToSegmentedElement >> newItemBar [

	^ ToSegmentedBarElement new
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

	self itemBar withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> withWeakCheckingStrategy [

	self itemBar withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToSegmentedElement >> withoutCheckingStrategy [

	self itemBar withoutCheckingStrategy
]
