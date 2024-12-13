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

{ #category : #initialization }
ToSegmentedElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize.
	self addChild: self itemList.
	
	self addEventHandler: (BlEventHandler
			 on: ToLayoutOrientationChangedEvent
			 do: [ self configureLayout ]).
	self addEventHandler: (BlEventHandler
			 on: BlLayoutResizerChangedEvent
			 do: [ self configureLayout ]).
	self addEventHandler: (BlEventHandler
			 on: ToLayoutDirectionChangedEvent
			 do: [ self configureLayout ]).	
			

	self configureLayout
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

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [ 

	^ self itemList dataAccessor
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
