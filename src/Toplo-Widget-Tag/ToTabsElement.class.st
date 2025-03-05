Class {
	#name : #ToTabsElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#instVars : [
		'invisibleNodes',
		'visibleNodes',
		'nodeMenu'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - triplet element - configuration' }
ToTabsElement >> applyInnerConfiguration [

	super applyInnerConfiguration.
	self itemBar horizontal: self isHorizontal.
	self isHorizontal
		ifTrue: [ self itemBar tabPosition: ToTabAtTop new ]
		ifFalse: [ self itemBar tabPosition: ToTabAtLeft new ].
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
	self itemBar requestInnerConfiguration
]

{ #category : #'event handling' }
ToTabsElement >> checkNodeMenu [

	| menuImage |
	nodeMenu ifNil: [
		menuImage := ToMaterialDesignIconProvider innerImageNamed:
			             'outlined_menu'.
		nodeMenu := ToMenu new iconImage: menuImage.
		nodeMenu icon size: 20 asPoint.
		nodeMenu builder: self defaultNodeMenuBuilder.
		nodeMenu visibility: BlVisibility gone.
		self endElement: nodeMenu ].

	self invisibleNodes
		ifNotEmpty: [ self showNodeMenu: true ]
		ifEmpty: [ self showNodeMenu: false ]
]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
]

{ #category : #initialization }
ToTabsElement >> defaultNodeMenuBuilder [

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
				           whenClickedDo: [ :event |
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

	^ invisibleNodes 
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

{ #category : #'t - bar element' }
ToTabsElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	(theInvisibleNodes = self invisibleNodes and: [
		 theVisibleNodes = self visibleNodes ]) ifTrue: [ ^ self ].
	
	invisibleNodes := theInvisibleNodes asArray.
	visibleNodes := theVisibleNodes asArray.
	self dispatchEvent: ToVisibleTabsChanged new.

]

{ #category : #accessing }
ToTabsElement >> selecter [

	^ self itemBar selecter
]

{ #category : #'event handling' }
ToTabsElement >> showNodeMenu: aBoolean [

	nodeMenu parentDo: [ :p |
		aBoolean
			ifTrue: [ nodeMenu visibility: BlVisibility visible ]
			ifFalse: [ nodeMenu visibility: BlVisibility gone ] ]
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
