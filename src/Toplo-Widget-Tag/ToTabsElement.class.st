Class {
	#name : #ToTabsElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
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
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #adding }
ToTabsElement >> addNewTagItem [

	| newItem |
	newItem := ToTabItemElement new.
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
ToTabsElement >> atStartSide [

	^ self widgetConfiguration atStartSide
]

{ #category : #accessing }
ToTabsElement >> atStartSide: aBoolean [

	self atStartSide = aBoolean ifTrue: [ ^ self ].
	self widgetConfiguration atStartSide: aBoolean.
	self requestNewConfiguration
]

{ #category : #configuration }
ToTabsElement >> canShowInvisibleNodesMenu [

	^ self isWrapping not and: [
		  self autoDistribute not and: [
			  invisibleNodes notNil and: [ invisibleNodes notEmpty ] ] ]
]

{ #category : #configuration }
ToTabsElement >> checkAddNewTabItemButton [

	showAddTabItemButton 
		ifTrue: [ addTabItemButton visibility: BlVisibility visible ]
		ifFalse: [ addTabItemButton visibility: BlVisibility gone ]
]

{ #category : #configuration }
ToTabsElement >> checkInvisibleNodes [

	self canShowInvisibleNodesMenu
		ifTrue: [ self showInvisibleNodesMenu: true ]
		ifFalse: [ self showInvisibleNodesMenu: false ]
]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
]

{ #category : #initialization }
ToTabsElement >> defaultInvisibleNodeMenuItemBuilder [

	^ [ :aMenuItem :aNode :aRequest |
	  aMenuItem
		  labelText: aNode item asString;
		  newClickAction: [
			  self selecter scrollTowardStartToDataSourcePosition:
					  aNode holder position.
			  self requestFocus.
			  aNode item checked: true ].
	  aNode isRemovable ifTrue: [
		  aMenuItem endElement: ToIconicRemoveButton new.
		  aMenuItem endFlexible: true.
		  aMenuItem endInterspace: 10.
		  aMenuItem addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
			  event consume.
			  aNode item removeFromBar.
			  self checkInvisibleNodes ] ].
	  aNode item isChecked ifTrue: [
		  aMenuItem icon: (ToImage inner: (self valueOfTokenNamed: #check)).
		  aMenuItem icon size:
			  (self valueOfTokenNamed: #'checkable-icon-size') ] ]
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
			  mitem := ToMenuItem new.
			  invisibleNodeMenuItemBuilder cull: mitem cull: node cull: request.
			  menu addItem: mitem ] ].
	  menu addSeparatorBeforeIndex: (middlePos max: 1) ]
]

{ #category : #initialization }
ToTabsElement >> defaultNewTabItemBuilder [

	^ [ :aTabItem :tabsElement |
	  | wasFocused |
	  wasFocused := tabsElement isFocused.
	  aTabItem labelText: 'New Tab'.
	  aTabItem label beEditable.
	  aTabItem removable: true.
	  aTabItem label whenEditorOpenedDo: [ :editorEvent |
		  editorEvent editorElement whenSaveRequestedDo: [ :request |
			  request accepted: true ].
		  editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
			  editorEvent target text: acceptedEvent target text.
			  tabsElement selecter scrollTowardEndToDataSourcePosition:
				  aTabItem holder position.
			  wasFocused ifTrue: [ tabsElement requestFocus ] ] ] ]
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

	super initialize.
	self initializeAsItemBarOwner.
	self initializeParts.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: self defaultEventHandler.
	newTabItemBuilder := self defaultNewTabItemBuilder.
	showAddTabItemButton := false
]

{ #category : #initialization }
ToTabsElement >> initializeAddTabItemButton [

	addTabItemButton := ToTabsAddItemButton new.
	addTabItemButton visibility: BlVisibility gone.
	addTabItemButton constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ]
]

{ #category : #initialization }
ToTabsElement >> initializeInvisibleNodesMenu [

	invisibleNodesMenu := ToTabsInvisibleNodesMenu new tabsElement: self.
	invisibleNodesMenu builder: self defaultInvisibleNodesMenuBuilder.
	invisibleNodesMenu visibility: BlVisibility gone.
	invisibleNodesMenu constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].

]

{ #category : #initialization }
ToTabsElement >> initializeParts [

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
ToTabsElement >> invisibleNodeMenuItemBuilder: aValuable [
	"a valuable takes the menu item, the invisible node and the menu request as arguments "

	invisibleNodeMenuItemBuilder := aValuable
]

{ #category : #accessing }
ToTabsElement >> invisibleNodes [ 

	^ invisibleNodes 
]

{ #category : #accessing }
ToTabsElement >> invisibleNodesMenu [ 

	^ invisibleNodesMenu
]

{ #category : #initialization }
ToTabsElement >> invisibleNodesMenuBuilder: aValuable [
	" a valuable is a menu builder, it takes the menu and the request as arguments "

	invisibleNodesMenu builder: aValuable
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

{ #category : #accessing }
ToTabsElement >> newTabItemBuilder: aValuable [
	" aValuable takes the new TabItemElement and the TabsElement as arguments "

	newTabItemBuilder := aValuable
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
	self dispatchEvent: ToVisibleTabsChanged new
]

{ #category : #accessing }
ToTabsElement >> showAddTabItemButton [

	^ showAddTabItemButton
]

{ #category : #accessing }
ToTabsElement >> showAddTabItemButton: aBoolean [

	showAddTabItemButton = aBoolean ifTrue: [ ^ self ].
	showAddTabItemButton := aBoolean.
	self requestNewConfiguration 
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
