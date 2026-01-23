Class {
	#name : #ToTabGroupElement,
	#superclass : #ToTripletContainer,
	#traits : 'TToItemListUser',
	#classTraits : 'TToItemListUser classTrait',
	#instVars : [
		'invisibleNodesMenu',
		'endExtraContainer',
		'menusContainer',
		'invisibleNodeMenuItemBuilder',
		'tabItemFactory',
		'showAddTabItemButton',
		'itemBuilder',
		'hidePartlyVisibleNodes',
		'invisibleNodeContainers',
		'visibleNodeContainers',
		'addTabButton',
		'addTabItemDataFactory'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #adding }
ToTabGroupElement >> addNewTabItem [

	" i'm a callback for the addTabButton "
	self addTabItemData: self addTabItemDataFactory value checked: true
]

{ #category : #adding }
ToTabGroupElement >> addTabItemData: aData [

	self addTabItemData: aData checked: false
]

{ #category : #adding }
ToTabGroupElement >> addTabItemData: aData checked: aBoolean [

	| newTabItem |
	newTabItem := tabItemFactory value.
	" add the new item before building it to allow the builder to use the item holder "
	self itemList
		addEventHandlerOn: ToListNodeAddedEvent
		doUntil: [ :event |
				self
					haveBuiltNewTabItem: newTabItem
					withData: aData
					checked: aBoolean
					onAddedEvent: event ].
	self addItem: newTabItem
]

{ #category : #adding }
ToTabGroupElement >> addTabItemDataFactory [

	^ addTabItemDataFactory ifNil: [ addTabItemDataFactory := self defaultAddTabItemDataFactory ]
]

{ #category : #adding }
ToTabGroupElement >> addTabItemDataFactory: aValuable [

	addTabItemDataFactory := aValuable
]

{ #category : #configuration }
ToTabGroupElement >> applyConfiguration [ 

	super applyConfiguration.
	self itemList applyConfiguration
]

{ #category : #accessing }
ToTabGroupElement >> atStartSide [

	^ self toConfiguration atStartSide
]

{ #category : #accessing }
ToTabGroupElement >> atStartSide: aBoolean [

	self atStartSide = aBoolean ifTrue: [ ^ self ].
	self toConfiguration atStartSide: aBoolean.
	self requestConfiguration
]

{ #category : #'private - adding' }
ToTabGroupElement >> buildNewTabItem: aTabItem withData: aData checked: aBoolean [ 

	itemBuilder cull: aTabItem cull: aData cull: aTabItem holder.
	aTabItem checked: aBoolean.
	aTabItem holder node requestConfiguration
]

{ #category : #configuration }
ToTabGroupElement >> canShowInvisibleNodesMenu [

	^ self isFlowable not and: [ self autoDistribute not ]
]

{ #category : #configuration }
ToTabGroupElement >> checkAddTabButton [

	showAddTabItemButton 
		ifTrue: [ addTabButton visibility: BlVisibility visible ]
		ifFalse: [ addTabButton visibility: BlVisibility gone ]
]

{ #category : #adding }
ToTabGroupElement >> defaultAddTabItemDataFactory [

	^ [ 'New tab' ]
]

{ #category : #initialization }
ToTabGroupElement >> defaultEventHandler [

	^ ToTabGroupElementEventHandler new
]

{ #category : #initialization }
ToTabGroupElement >> defaultInvisibleNodeMenuItemBuilder [

	^ [ :aMenuItem :aRequest |
		  aMenuItem
			  labelText: aMenuItem tabNode item asToLabelText;
			  clickAction: [ self showInvisibleTabItem: aMenuItem tabNode item ] ]
]

{ #category : #initialization }
ToTabGroupElement >> defaultInvisibleNodesMenuBuilder [

	^ [ :menu :request |
		  self invisibleNodeContainers do: [ :container |
				  container node isEnabled ifTrue: [
						  | mitem |
						  mitem := ToTabInvisibleNodeMenuItem new
							           tabNode: container node;
							           yourself.
						  invisibleNodeMenuItemBuilder cull: mitem cull: request.
						  menu addItem: mitem ] ] ]
]

{ #category : #initialization }
ToTabGroupElement >> defaultItemBuilder [

	^ [ :aTabItem :aData :tabGroupElement |
		  aTabItem labelText: aData asString ]
]

{ #category : #initialization }
ToTabGroupElement >> defaultTabItemFactory [

	^ [ ToTabItemElement new  ]
]

{ #category : #accessing }
ToTabGroupElement >> endExtraBuilder: aValuable [

	aValuable value: endExtraContainer 
]

{ #category : #'focus requesting' }
ToTabGroupElement >> focusHolder [

	^ self itemList
]

{ #category : #accessing }
ToTabGroupElement >> group [

	^ self itemList group
]

{ #category : #'private - adding' }
ToTabGroupElement >> haveBuiltNewTabItem: aTabItem withData: aData checked: aBoolean onAddedEvent: anItemAddedEvent [

	anItemAddedEvent node item = aTabItem ifFalse: [ ^ false ].
	self buildNewTabItem: aTabItem withData: aData checked: aBoolean.
	^ true
]

{ #category : #accessing }
ToTabGroupElement >> hidePartlyVisibleNodes: aBoolean [

	hidePartlyVisibleNodes := aBoolean
]

{ #category : #initialization }
ToTabGroupElement >> initialize [

	super initialize.
	self resetInvisibleNodeContainers.
	self createMiddleContainer.
	self initializeParts.
	self setItemList: self middleContainer.
	self itemList addEventHandler:
		(ToTabListGroupElementEventHandler new
			 tabGroup: self;
			 yourself).
	self addEventHandler: self defaultEventHandler.
	tabItemFactory := self defaultTabItemFactory.
	itemBuilder := self defaultItemBuilder.
	showAddTabItemButton := false.
	hidePartlyVisibleNodes := false.
]

{ #category : #initialization }
ToTabGroupElement >> initializeAddTabButton [

	addTabButton := ToAddTabButton new.
	addTabButton clickAction: [
		addTabButton fireEvent: ToAddButtonClickedEvent new ].
	addTabButton visibility: BlVisibility gone.
	addTabButton constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ]
]

{ #category : #initialization }
ToTabGroupElement >> initializeInvisibleNodesMenu [

	invisibleNodesMenu := ToTabInvisibleNodesMenu new tabGroupElement: self.
	invisibleNodesMenu builder: self defaultInvisibleNodesMenuBuilder.
	invisibleNodesMenu visibility: BlVisibility gone.
	invisibleNodesMenu constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].

]

{ #category : #initialization }
ToTabGroupElement >> initializeParts [

	self initializeInvisibleNodesMenu.
	self initializeAddTabButton.
	self createStartContainer.
	self createEndContainer.
	endExtraContainer := self newLinearContainer.
	endExtraContainer id: #'end-extra-container'.
	menusContainer := self newLinearContainer.
	menusContainer id: #'menus-container'.
	invisibleNodeMenuItemBuilder := self defaultInvisibleNodeMenuItemBuilder.
	menusContainer addChild: addTabButton.
	addTabButton id: #'add-tab-button'.
	menusContainer addChild: invisibleNodesMenu.
	invisibleNodesMenu id: #'invisible-nodes-menu'.
	self endContainer addChild: menusContainer.
	self endContainer addChild: endExtraContainer
]

{ #category : #accessing }
ToTabGroupElement >> invisibleNodeContainers [ 

	^ invisibleNodeContainers 
]

{ #category : #accessing }
ToTabGroupElement >> invisibleNodeMenuItemBuilder: aValuable [
	"a valuable takes the menu item, the invisible node and the menu request as arguments "

	invisibleNodeMenuItemBuilder := aValuable
]

{ #category : #accessing }
ToTabGroupElement >> invisibleNodes [ 

	self deprecated: 'Use #invisibleNodeContainers' transformWith: '`@r invisibleNodes' -> '`@r invisibleNodeContainers'.

	^ self invisibleNodeContainers 
]

{ #category : #accessing }
ToTabGroupElement >> invisibleNodesMenu [ 

	^ invisibleNodesMenu
]

{ #category : #initialization }
ToTabGroupElement >> invisibleNodesMenuBuilder: aValuable [
	" a valuable is a menu builder, it takes the menu and the request as arguments "

	invisibleNodesMenu builder: aValuable
]

{ #category : #testing }
ToTabGroupElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabGroupElement >> isAtStartSide [

	^ self atStartSide
]

{ #category : #accessing }
ToTabGroupElement >> itemBuilder: aValuable [
	" aValuable takes the new TabItemElement, the data and its holder as arguments "

	itemBuilder := aValuable
]

{ #category : #initialization }
ToTabGroupElement >> listElementClass [

	^ ToTabListElement 
]

{ #category : #accessing }
ToTabGroupElement >> menusContainer [

	^ menusContainer 
]

{ #category : #'t - triplet container - instance creation' }
ToTabGroupElement >> newEndContainer [ 

	^ self newLinearContainer
]

{ #category : #'t - item list user - initializing' }
ToTabGroupElement >> newItemList [

	^ self listElementClass new
]

{ #category : #'t - triplet container - instance creation' }
ToTabGroupElement >> newMiddleContainer [ 

	^ self newItemList
]

{ #category : #skin }
ToTabGroupElement >> newRawSkin [ 

	^ ToTabGroupElementSkin new
]

{ #category : #'t - triplet container - instance creation' }
ToTabGroupElement >> newStartContainer [ 

	^ self newLinearContainer
]

{ #category : #configuration }
ToTabGroupElement >> newToConfiguration [ 

	^ ToTabGroupElementConfiguration new
]

{ #category : #'hooks - layout' }
ToTabGroupElement >> onInvisibleNodeContainers: theInvisibleContainers visibleNodeContainers: theVisibleContainers [

	| startIdx endIdx |
	invisibleNodeContainers := theInvisibleContainers copy.
	visibleNodeContainers := theVisibleContainers copy.

	startIdx := visibleNodeContainers
		            ifEmpty: [ 0 ]
		            ifNotEmpty: [
		            visibleNodeContainers first holder position ].
	endIdx := visibleNodeContainers
		          ifEmpty: [ 0 ]
		          ifNotEmpty: [ visibleNodeContainers last holder position ].

	hidePartlyVisibleNodes ifTrue: [
			invisibleNodeContainers do: [ :n |
					n holder position > endIdx
						ifTrue: [
						n isVisible ifTrue: [ n visibility: BlVisibility hidden ] ]
						ifFalse: [
						n isVisible ifFalse: [ n visibility: BlVisibility visible ] ] ].
			visibleNodeContainers do: [ :n |
				n isVisible ifFalse: [ n visibility: BlVisibility visible ] ] ].

	(self canShowInvisibleNodesMenu and: [
		 invisibleNodeContainers notEmpty ])
		ifTrue: [ self showInvisibleNodesMenu: true ]
		ifFalse: [ self showInvisibleNodesMenu: false ].
	hidePartlyVisibleNodes ifTrue: [
			self itemList selectionElementsDo: [ :se |
				se visibility: se nodeContainer visibility ] ]
]

{ #category : #initialization }
ToTabGroupElement >> resetInvisibleNodeContainers [

	invisibleNodeContainers := #().
	visibleNodeContainers := #()

	
]

{ #category : #accessing }
ToTabGroupElement >> showAddTabItemButton [

	^ showAddTabItemButton
]

{ #category : #accessing }
ToTabGroupElement >> showAddTabItemButton: aBoolean [

	showAddTabItemButton = aBoolean ifTrue: [ ^ self ].
	showAddTabItemButton := aBoolean.
	self requestConfiguration 
]

{ #category : #configuration }
ToTabGroupElement >> showInvisibleNodesMenu: aBoolean [

	self invisibleNodesMenu parentDo: [ :p |
		aBoolean
			ifTrue: [ self invisibleNodesMenu visibility: BlVisibility visible ]
			ifFalse: [ self invisibleNodesMenu visibility: BlVisibility gone ] ]
]

{ #category : #accessing }
ToTabGroupElement >> showInvisibleTabItem: aTabItemElement [

	self requestFocus.
	aTabItemElement checked: true
]

{ #category : #accessing }
ToTabGroupElement >> startExtraBuilder: aValuable [

	aValuable value: self startContainer
]

{ #category : #accessing }
ToTabGroupElement >> trackElement [

	^ self itemList innerElement trackElement
]

{ #category : #accessing }
ToTabGroupElement >> visibleNodeContainers [

	^ visibleNodeContainers 
]

{ #category : #accessing }
ToTabGroupElement >> visibleNodes [

	self deprecated: 'Use #visibleNodeContainers' transformWith: '`@r visibleNodes' -> '`@r visibleNodeContainers'.
	^ self visibleNodeContainers
]

{ #category : #'t - checkable group owner' }
ToTabGroupElement >> withNoneCheckingStrategy [

	self itemList withNoneCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabGroupElement >> withStrictCheckingStrategy [

	self itemList withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabGroupElement >> withWeakCheckingStrategy [

	self itemList withWeakCheckingStrategy
]
