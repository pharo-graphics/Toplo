Class {
	#name : #ToTabGroupElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemBarContainer + TToItemBarOwner',
	#classTraits : 'TToItemBarContainer classTrait + TToItemBarOwner classTrait',
	#instVars : [
		'invisibleNodes',
		'visibleNodes',
		'invisibleNodesMenu',
		'endExtraContainer',
		'menusContainer',
		'invisibleNodeMenuItemBuilder',
		'addTabItemButton',
		'newTabItemBuilder',
		'showAddTabItemButton'
	],
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #adding }
ToTabGroupElement >> addNewTabItem [

	| newItem |
	newItem := self newTabItem.
	newTabItemBuilder cull: newItem cull: self.
	self itemBar
		addEventHandlerOn: ToListNodeAddedEvent
		doOnce: [ :event |
			self selecter scrollTowardEndToDataSourcePosition:
				event node holder position.
			event node item checked: true ].
	self addItem: newItem
]

{ #category : #accessing }
ToTabGroupElement >> atStartSide [

	^ self widgetConfiguration atStartSide
]

{ #category : #accessing }
ToTabGroupElement >> atStartSide: aBoolean [

	self atStartSide = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration atStartSide: aBoolean.
	self requestNewConfiguration
]

{ #category : #initialization }
ToTabGroupElement >> barElementClass [

	^ ToTabBarElement 
]

{ #category : #configuration }
ToTabGroupElement >> canShowInvisibleNodesMenu [

	^ self isFlowable not and: [
		  self autoDistribute not and: [ invisibleNodes notEmpty ] ]
]

{ #category : #configuration }
ToTabGroupElement >> checkAddNewTabItemButton [

	showAddTabItemButton 
		ifTrue: [ addTabItemButton visibility: BlVisibility visible ]
		ifFalse: [ addTabItemButton visibility: BlVisibility gone ]
]

{ #category : #configuration }
ToTabGroupElement >> checkInvisibleNodes [

	self canShowInvisibleNodesMenu
		ifTrue: [ self showInvisibleNodesMenu: true ]
		ifFalse: [ self showInvisibleNodesMenu: false ]
]

{ #category : #initialization }
ToTabGroupElement >> defaultEventHandler [

	^ ToTabGroupElementEventHandler new
]

{ #category : #initialization }
ToTabGroupElement >> defaultInvisibleNodeMenuItemBuilder [

	^ [ :aMenuItem :aNode :aRequest |
	  aMenuItem
		  labelText: aNode item asToLabelText;
		  clickAction: [ self showInvisibleTabItem: aNode item ].
	  aNode item isChecked ifTrue: [
		  aMenuItem icon: (ToImage inner: (self valueOfTokenNamed: #check)).
		  aMenuItem icon size:
			  (self valueOfTokenNamed: #'checkable-icon-size') ] ]
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
			  mitem := ToMenuItem new.
			  invisibleNodeMenuItemBuilder cull: mitem cull: node cull: request.
			  menu addItem: mitem ] ].
	  menu addSeparatorBeforeIndex: (middlePos max: 1) ]
]

{ #category : #initialization }
ToTabGroupElement >> defaultNewTabItemBuilder [

	^ [ :aTabItem :tabGroupElement |
	  | wasFocused |
	  wasFocused := tabGroupElement isFocused.
	  aTabItem labelText: 'New Tab'.
	  aTabItem label beEditable.
	  aTabItem removable: true.
	  aTabItem label whenEditorOpenedDo: [ :editorEvent |
		  editorEvent editorElement whenSaveRequestedDo: [ :request |
			  request accepted: true ].
		  editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
			  editorEvent target text: acceptedEvent target text.
			  tabGroupElement selecter scrollTowardEndToDataSourcePosition:
				  aTabItem holder position.
			  wasFocused ifTrue: [ tabGroupElement requestFocus ] ] ] ]
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

{ #category : #initialization }
ToTabGroupElement >> initialize [

	super initialize.
	self resetInvisibleNodes.
	self initializeAsItemBarOwner.
	self initializeParts.

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self fireEvent: event copy ].

	self addEventHandler: self defaultEventHandler.
	newTabItemBuilder := self defaultNewTabItemBuilder.
	showAddTabItemButton := false
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

	| container |
	self initializeInvisibleNodesMenu.
	self initializeAddTabItemButton.
	self startElement: self newLinearContainer.
	self middleElement: self itemBar.
	container := self newLinearContainer.
	endExtraContainer := self newLinearContainer.
	menusContainer := self newLinearContainer.
	invisibleNodeMenuItemBuilder := self defaultInvisibleNodeMenuItemBuilder.
	menusContainer addChild: invisibleNodesMenu.
	container addChild: addTabItemButton.
	container addChild: menusContainer.
	container addChild: endExtraContainer.
	self endElement: container.
	self endContainer layout: BlLinearLayout new
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

{ #category : #'t - item bar container - accessing' }
ToTabGroupElement >> newItemBar [

	^ self barElementClass new
		  parentTabGroupElement: self;
		  yourself
]

{ #category : #skin }
ToTabGroupElement >> newRawSkin [ 

	^ ToTabGroupElementSkin new
]

{ #category : #adding }
ToTabGroupElement >> newTabItem [

	^ ToTabItemElement new
]

{ #category : #accessing }
ToTabGroupElement >> newTabItemBuilder: aValuable [
	" aValuable takes the new TabItemElement and the TabGroupElement as arguments "

	newTabItemBuilder := aValuable
]

{ #category : #configuration }
ToTabGroupElement >> newWidgetConfiguration [ 

	^ ToTabGroupElementConfiguration new
]

{ #category : #'t - bar element' }
ToTabGroupElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	| startIdx endIdx |
	
	invisibleNodes := theInvisibleNodes asArray.
	visibleNodes := theVisibleNodes asArray.
	
	startIdx := visibleNodes
		            ifEmpty: [ 0 ]
		            ifNotEmpty: [ visibleNodes first holder position ].
	endIdx := visibleNodes
		          ifEmpty: [ 0 ]
		          ifNotEmpty: [ visibleNodes last holder position ].
		
	invisibleNodes do: [ :n |
		n holder position > endIdx ifTrue: [
			n visibility: BlVisibility hidden ] ].
	visibleNodes do: [ :n | n visibility: BlVisibility visible ].

	self dispatchEvent: ToVisibleTabsChanged new
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
	self requestNewConfiguration 
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

	self selecter scrollTowardStartToDataSourcePosition:
		aTabItemElement holder position.
	self requestFocus.
	aTabItemElement checked: true
]

{ #category : #accessing }
ToTabGroupElement >> startExtraBuilder: aValuable [

	aValuable value: self startElement
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
