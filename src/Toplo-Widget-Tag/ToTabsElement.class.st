Class {
	#name : #ToTabsElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#instVars : [
		'invisibleNodes',
		'visibleNodes',
		'invisibleNodesMenu',
		'endExtraContainer'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #accessing }
ToTabsElement >> atStartSide [

	^ self widgetConfiguration atStartSide
]

{ #category : #accessing }
ToTabsElement >> atStartSide: aBoolean [

	self atStartSide = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration atStartSide: aBoolean.
	self requestNewConfigurationPass
]

{ #category : #configuration }
ToTabsElement >> canShowInvisibleNodesMenu [

	^ self isWrapping not and: [
		  invisibleNodes notNil and: [ invisibleNodes notEmpty ] ]
]

{ #category : #configuration }
ToTabsElement >> checkInvisibleNodesMenu [

	self canShowInvisibleNodesMenu
		ifTrue: [ self showInvisibleNodesMenu: true ]
		ifFalse: [ self showInvisibleNodesMenu: false ]
]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
]

{ #category : #initialization }
ToTabsElement >> defaultInvisibleNodesMenuBuilder [

	^ [ :menu :request |
	  | middlePos |
	  middlePos := self visibleNodes
		               ifEmpty: [ 0 ]
		               ifNotEmpty: [ :vn | vn first holder position - 1 ].
	  self invisibleNodes do: [ :node |
		  node isEnabled ifTrue: [
			  | mitem |
			  mitem := ToMenuItem new
				           labelText: node item label text asString;
				           newClickAction: [ 
					           self selecter
						           scrollTowardStartToDataSourcePosition:
							           node holder position.
					           self requestFocus.
					           node item checked: true ];
				           yourself.
			  node item isChecked ifTrue: [
				  mitem icon:
					  (ToImage inner: (self valueOfTokenNamed: #check)).
				  mitem icon size:
					  (self valueOfTokenNamed: #'checkable-icon-size') ].
			  menu addItem: mitem ] ].
	  menu addSeparatorBeforeIndex: (middlePos max: 1) ]
]

{ #category : #accessing }
ToTabsElement >> endExtraBuilder: aValuable [

	aValuable value: endExtraContainer 
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

	| container |
	super initialize.
	self initializeAsItemBarOwner.
	self initializeInvisibleNodesMenu.

	self startElement: self newBaseContainer.
	self middleElement: self itemBar.
	container := self newBaseContainer.
	container layout: BlLinearLayout new.
	endExtraContainer := self newBaseContainer.
	container addChild: invisibleNodesMenu.
	container addChild: endExtraContainer.
	self endElement: container.
	self endContainer layout: BlLinearLayout new.
	endExtraContainer constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: self defaultEventHandler
]

{ #category : #initialization }
ToTabsElement >> initializeInvisibleNodesMenu [

	invisibleNodesMenu := ToTabsInvisibleItemsMenu new tabsElement: self.
	invisibleNodesMenu builder: self defaultInvisibleNodesMenuBuilder.
	invisibleNodesMenu visibility: BlVisibility gone.
	invisibleNodesMenu constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].

]

{ #category : #accessing }
ToTabsElement >> invisibleNodes [ 

	^ invisibleNodes 
]

{ #category : #accessing }
ToTabsElement >> invisibleNodesMenu [ 

	^ invisibleNodesMenu
]

{ #category : #testing }
ToTabsElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabsElement >> isAtStartSide [

	^ self atStartSide
]

{ #category : #'t - item list owner - accessing' }
ToTabsElement >> newItemBar [

	^ ToTabBarElement new
		  parentTabsElement: self;
		  yourself
]

{ #category : #skin }
ToTabsElement >> newRawSkin [ 

	^ ToTabsElementSkin new
]

{ #category : #configuration }
ToTabsElement >> newWidgetConfiguration [ 

	^ ToTabsElementConfiguration new
]

{ #category : #'t - bar element' }
ToTabsElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	(theInvisibleNodes = self invisibleNodes and: [
		 theVisibleNodes = self visibleNodes ]) ifTrue: [ ^ self ].
	
	invisibleNodes := theInvisibleNodes asArray.
	visibleNodes := theVisibleNodes asArray.
	self dispatchEvent: ToVisibleTabsChanged new.

]

{ #category : #configuration }
ToTabsElement >> onWidgetConfigurationApplied [ 

	super onWidgetConfigurationApplied.
	invisibleNodesMenu requestNewSkin
]

{ #category : #configuration }
ToTabsElement >> showInvisibleNodesMenu: aBoolean [

	self invisibleNodesMenu parentDo: [ :p |
		aBoolean
			ifTrue: [ self invisibleNodesMenu visibility: BlVisibility visible ]
			ifFalse: [ self invisibleNodesMenu visibility: BlVisibility gone ] ]
]

{ #category : #accessing }
ToTabsElement >> startExtraBuilder: aValuable [

	aValuable value: self startElement
]

{ #category : #accessing }
ToTabsElement >> visibleNodes [

	^ visibleNodes 
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
