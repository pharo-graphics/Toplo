Class {
	#name : #ToTabGroupElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemBarContainer',
	#classTraits : 'TToItemBarContainer classTrait',
	#instVars : [
		'invisibleNodes',
		'visibleNodes',
		'invisibleNodesMenu',
		'endExtraContainer',
		'menusContainer',
		'invisibleNodeMenuItemBuilder',
		'addTabItemButton',
		'tabItemFactory',
		'showAddTabItemButton',
		'itemBuilder',
		'hidePartlyVisibleNodes'
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
		  | middlePos |
		  middlePos := self visibleNodes
			               ifEmpty: [ 0 ]
			               ifNotEmpty: [ :vn | vn first holder position - 1 ].
		  self invisibleNodes do: [ :node |
				  node isEnabled ifTrue: [
						  | mitem |
						  mitem := ToTabInvisibleNodeMenuItem new
							           tabNode: node;
							           yourself.
						  invisibleNodeMenuItemBuilder cull: mitem cull: request.
						  menu addItem: mitem ] ].
		  menu addSeparatorBeforeIndex: (middlePos max: 1) ]
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
	self resetInvisibleNodes.
	self initializeAsItemBarContainer.
	self initializeParts.
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
	self startElement: self newLinearContainer.
	self middleElement: self itemBar.
	self endElement: self newLinearContainer.
	endExtraContainer := self newLinearContainer.
	endExtraContainer id: #'end-extra-container'.
	menusContainer := self newLinearContainer.
	menusContainer id: #'menus-container'.
	invisibleNodeMenuItemBuilder := self defaultInvisibleNodeMenuItemBuilder.
	menusContainer addChild: addTabItemButton.
	addTabItemButton id: #'add-tab-button'.
	menusContainer addChild: invisibleNodesMenu.
	invisibleNodesMenu id: #'invisible-nodes-menu'.
	self endElement addChild: menusContainer.
	self endElement addChild: endExtraContainer.
	
	self startElement id: #'start-extra-container'.
	self middleElement id: #'tab-bar'.
	self endElement id: #'end-container'.
]

{ #category : #accessing }
ToTabGroupElement >> invisibleNodeMenuItemBuilder: aValuable [
	"a valuable takes the menu item, the invisible node and the menu request as arguments "

	invisibleNodeMenuItemBuilder := aValuable
]

{ #category : #accessing }
ToTabGroupElement >> invisibleNodes [ 

	^ invisibleNodes 
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

{ #category : #'t - item bar container - initializing' }
ToTabGroupElement >> newItemBar [

	^ self barElementClass new
]

{ #category : #skin }
ToTabGroupElement >> newRawSkin [ 

	^ ToTabGroupElementSkin new
]

{ #category : #configuration }
ToTabGroupElement >> newToConfiguration [ 

	^ ToTabGroupElementConfiguration new
]

{ #category : #'t - bar element' }
ToTabGroupElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	| startIdx endIdx |
	invisibleNodes := theInvisibleNodes copy.
	visibleNodes := theVisibleNodes copy.

	startIdx := visibleNodes
		            ifEmpty: [ 0 ]
		            ifNotEmpty: [ visibleNodes first holder position ].
	endIdx := visibleNodes
		          ifEmpty: [ 0 ]
		          ifNotEmpty: [ visibleNodes last holder position ].

	hidePartlyVisibleNodes ifTrue: [
			invisibleNodes do: [ :n |
					n holder position > endIdx
						ifTrue: [
						n isVisible ifTrue: [ n visibility: BlVisibility hidden ] ]
						ifFalse: [
						n isVisible ifFalse: [ n visibility: BlVisibility visible ] ] ].
			visibleNodes do: [ :n |
				n isVisible ifFalse: [ n visibility: BlVisibility visible ] ] ].

	(self canShowInvisibleNodesMenu and: [ invisibleNodes notEmpty ])
		ifTrue: [ self showInvisibleNodesMenu: true ]
		ifFalse: [ self showInvisibleNodesMenu: false ].
	hidePartlyVisibleNodes ifTrue: [
			self itemBar selectionElementsDo: [ :se |
				se visibility: se node visibility ] ]
]

{ #category : #initialization }
ToTabGroupElement >> resetInvisibleNodes [

	invisibleNodes := #().
	visibleNodes := #()

	
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

	aValuable value: self startElement
]

{ #category : #accessing }
ToTabGroupElement >> trackElement [

	^ self middleElement trackElement
]

{ #category : #accessing }
ToTabGroupElement >> visibleNodes [

	^ visibleNodes 
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
