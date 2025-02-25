Class {
	#name : #ToTabsElement,
	#superclass : #ToElement,
	#traits : 'TToTripletElement + TToItemListOwner + TToWithOrientableLayout',
	#classTraits : 'TToTripletElement classTrait + TToItemListOwner classTrait + TToWithOrientableLayout classTrait',
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabsElement >> configureLayout [

	super configureLayout.

	self isHFitContent
		ifTrue: [
			self itemBar hFitContent.
			self middleContainer hFitContent ]
		ifFalse: [
			self itemBar hMatchParent.
			self middleContainer hMatchParent ].

	self isVFitContent
		ifTrue: [
			self itemBar vFitContent.
			self middleContainer vFitContent ]
		ifFalse: [
			self itemBar vMatchParent.
			self middleContainer vMatchParent ].
		
	self itemBar horizontal: self isHorizontal.
	self itemBar configureLayout.

	self requestNewSkin
]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
]

{ #category : #initialization }
ToTabsElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #'focus requesting' }
ToTabsElement >> focusHolder [

	^ self itemBar
]

{ #category : #accessing }
ToTabsElement >> group [

	^ self itemBar group
]

{ #category : #initialization }
ToTabsElement >> initialize [

	super initialize.
	self initializeAsItemBarOwner.
	self initializeAsTripletElementOn: self.
	self middleContainer clipChildren: false.

	self middleElement: self itemBar.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy].

	self horizontal: true.
	self addEventHandler: self defaultEventHandler
]

{ #category : #'t - item list owner - accessing' }
ToTabsElement >> newItemBar [

	^ ToTabBarElement new
]

{ #category : #'instance creation' }
ToTabsElement >> newRawSkin [ 

	^ ToTabsElementSkin new
]

{ #category : #'t - checkable group owner' }
ToTabsElement >> withStrictCheckingStrategy [

	self itemBar withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabsElement >> withWeakCheckingStrategy [

	self itemBar withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabsElement >> withoutCheckingStrategy [

	self itemBar withoutCheckingStrategy
]
