Class {
	#name : #ToTabsElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - triplet element - configuration' }
ToTabsElement >> applyInnerConfiguration [ 

	super applyInnerConfiguration.
	self itemBar horizontal: self isHorizontal.
	self itemBar matchParent.
	self isHFitContent
		ifTrue: [
			self middleContainer hFitContent.
			self itemBar hFitContent ]
		ifFalse: [
			self middleContainer hMatchParent.
			self itemBar hMatchParent ].
	self isVFitContent
		ifTrue: [
			self middleContainer vFitContent.
			self itemBar vFitContent ]
		ifFalse: [
			self middleContainer vMatchParent.
			self itemBar vMatchParent ].
	self requestNewSkin.
	self itemBar requestInnerConfiguration 

]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
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
	
	self middleElement: self itemBar.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: self defaultEventHandler
]

{ #category : #accessing }
ToTabsElement >> invisibleNodes [ 

	^ self itemBar invisibleNodes
]

{ #category : #'t - item list owner - accessing' }
ToTabsElement >> newItemBar [

	^ ToTabBarElement new
]

{ #category : #skin }
ToTabsElement >> newRawSkin [ 

	^ ToTabsElementSkin new
]

{ #category : #accessing }
ToTabsElement >> visibleNodes [

	^ self itemBar visibleNodes
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
