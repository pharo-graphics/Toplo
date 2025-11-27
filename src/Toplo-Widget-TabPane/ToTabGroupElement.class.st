Class {
	#name : #ToTabGroupElement,
	#superclass : #ToTripletContainer,
	#traits : 'TToItemBarContainer',
	#classTraits : 'TToItemBarContainer classTrait',
	#instVars : [
		'invisibleNodesMenu',
		'endExtraContainer',
		'menusContainer',
		'invisibleNodeMenuItemBuilder',
		'addTabItemButton',
		'tabItemFactory',
		'showAddTabItemButton',
		'itemBuilder',
		'hidePartlyVisibleNodes',
		'invisibleNodeContainers',
		'visibleNodeContainers'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #adding }
ToTabGroupElement >> addNewTabItem [

	self itemBar
		addEventHandlerOn: ToListNodeAddedEvent
		doOnce: [ :event |
			self itemBar whenLayoutedDoOnce: [ event node item checked: true ] ].
	self addTabItemData: 'New Tab'
]

{ #category : #adding }
ToTabGroupElement >> addTabItemData: aData [

	| newTabItem |
	newTabItem := tabItemFactory value.
	" add the new item before building it to allow the builder to use the item holder "
	self addItem: newTabItem.
	itemBuilder cull: newTabItem cull: aData cull: self.
	newTabItem holder node requestConfiguration

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

{ #category : #initialization }
ToTabGroupElement >> barElementClass [

	^ ToTabBarElement 
]

{ #category : #configuration }
ToTabGroupElement >> canShowInvisibleNodesMenu [

	^ self isFlowable not and: [ self autoDistribute not ]
]

{ #category : #configuration }
ToTabGroupElement >> checkAddNewTabItemButton [

	showAddTabItemButton 
		ifTrue: [ addTabItemButton visibility: BlVisibility visible ]
		ifFalse: [ addTabItemButton visibility: BlVisibility gone ]
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

	^ self itemBar
]

{ #category : #accessing }
ToTabGroupElement >> group [

	^ self itemBar group
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
	self setItemBar: self middleContainer.
	self itemBar addEventHandler:
		(ToTabBarInGroupElementEventHandler new
			 tabGroup: self;
			 yourself).
	self addEventHandler: self defaultEventHandler.
	tabItemFactory := self defaultTabItemFactory.
	itemBuilder := self defaultItemBuilder.
	showAddTabItemButton := false.
	hidePartlyVisibleNodes := false.
]

{ #category : #initialization }
ToTabGroupElement >> initializeAddTabItemButton [

	addTabItemButton := ToAddTabButton new.
	addTabItemButton clickAction: [
		addTabItemButton fireEvent: ToAddButtonClickedEvent new ].
	addTabItemButton visibility: BlVisibility gone.
	addTabItemButton constraintsDo: [ :c |
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
	self initializeAddTabItemButton.
	self createStartContainer.
	self createEndContainer.
	endExtraContainer := self newLinearContainer.
	endExtraContainer id: #'end-extra-container'.
	menusContainer := self newLinearContainer.
	menusContainer id: #'menus-container'.
	invisibleNodeMenuItemBuilder := self defaultInvisibleNodeMenuItemBuilder.
	menusContainer addChild: addTabItemButton.
	addTabItemButton id: #'add-tab-button'.
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
	" aValuable takes the new TabItemElement, the data and the TabGroupElement as arguments "

	itemBuilder := aValuable
]

{ #category : #accessing }
ToTabGroupElement >> menusContainer [

	^ menusContainer 
]

{ #category : #'t - triplet container - instance creation' }
ToTabGroupElement >> newEndContainer [ 

	^ self newLinearContainer
]

{ #category : #'t - item bar container - initializing' }
ToTabGroupElement >> newItemBar [

	^ self barElementClass new
]

{ #category : #'t - triplet container - instance creation' }
ToTabGroupElement >> newMiddleContainer [ 

	^ self newItemBar
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

{ #category : #'t - bar element' }
ToTabGroupElement >> onInvisibleNodeContainers: theInvisibleNodes visibleNodeContainers: theVisibleNodes [

	| startIdx endIdx |
	invisibleNodeContainers := theInvisibleNodes copy.
	visibleNodeContainers := theVisibleNodes copy.

	startIdx := visibleNodeContainers
		            ifEmpty: [ 0 ]
		            ifNotEmpty: [ visibleNodeContainers first holder position ].
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

	(self canShowInvisibleNodesMenu and: [ invisibleNodeContainers notEmpty ])
		ifTrue: [ self showInvisibleNodesMenu: true ]
		ifFalse: [ self showInvisibleNodesMenu: false ].
	hidePartlyVisibleNodes ifTrue: [
			self itemBar selectionElementsDo: [ :se |
				se visibility: se node visibility ] ]
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

	^ self itemBar trackElement
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
ToTabGroupElement >> withStrictCheckingStrategy [

	self itemBar withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabGroupElement >> withWeakCheckingStrategy [

	self itemBar withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabGroupElement >> withoutCheckingStrategy [

	self itemBar withoutCheckingStrategy
]
