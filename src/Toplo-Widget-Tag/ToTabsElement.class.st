Class {
	#name : #ToTabsElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#instVars : [
		'invisibleNodes',
		'visibleNodes',
		'nodeMenu',
		'atStartSide',
		'endExtraContainer'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - triplet element - configuration' }
ToTabsElement >> applyInnerConfiguration [

	super applyInnerConfiguration.
	self itemBar horizontal: self isHorizontal.
	self itemBar atStartSide: atStartSide.
	self itemBar matchParent.
	self isHFitContent
		ifTrue: [
			self middleContainer constraintsDo: [ :c | c horizontal fitContent ].
			self itemBar hFitContent ]
		ifFalse: [
			self middleContainer constraintsDo: [ :c |
				c horizontal matchParent ].
			self itemBar hMatchParent ].
	self isVFitContent
		ifTrue: [
			self middleContainer constraintsDo: [ :c | c vertical fitContent ].
			self itemBar vFitContent ]
		ifFalse: [
			self middleContainer constraintsDo: [ :c | c vertical matchParent ].
			self itemBar vMatchParent ].

	self isHorizontal
		ifTrue: [ self endElement layout beHorizontal ]
		ifFalse: [ self endElement layout beVertical ].

	self checkNodeMenu
]

{ #category : #accessing }
ToTabsElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabsElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestNewConfiguration
]

{ #category : #'event handling' }
ToTabsElement >> canShowMenu [

	^ self isWrapping not and: [
		  invisibleNodes notNil and: [ invisibleNodes notEmpty ] ]
]

{ #category : #'event handling' }
ToTabsElement >> checkNodeMenu [

	self canShowMenu
		ifTrue: [ self showNodeMenu: true ]
		ifFalse: [ self showNodeMenu: false ]
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

	super initialize.
	self initializeAsItemBarOwner.

	atStartSide := true.
	self middleElement: self itemBar.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: self defaultEventHandler.
	self initializeExtras 
]

{ #category : #initialization }
ToTabsElement >> initializeExtras [

	| menuImage container |
	menuImage := ToMaterialDesignIconProvider innerImageNamed:
		             'outlined_menu'.
	nodeMenu := ToMenu new iconImage: menuImage.
	nodeMenu icon size: 20 asPoint.
	nodeMenu builder: self defaultNodeMenuBuilder.
	nodeMenu visibility: BlVisibility gone.

	self startElement: self newBaseContainer.

	container := self newBaseContainer.
	container layout: BlLinearLayout new.
	endExtraContainer := self newBaseContainer.
	container addChild: nodeMenu.
	container addChild: endExtraContainer.
	self endElement: container.
	self endContainer layout: BlLinearLayout new.
	nodeMenu constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].
	endExtraContainer constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ]
]

{ #category : #accessing }
ToTabsElement >> invisibleNodes [ 

	^ invisibleNodes 
]

{ #category : #testing }
ToTabsElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabsElement >> isAtStartSide [

	^ atStartSide
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

{ #category : #configuration }
ToTabsElement >> requestNewConfiguration [ 

	super requestNewConfiguration.
	self itemBar requestNewConfiguration
]

{ #category : #'event handling' }
ToTabsElement >> showNodeMenu: aBoolean [

	nodeMenu parentDo: [ :p |
		aBoolean
			ifTrue: [ nodeMenu visibility: BlVisibility visible ]
			ifFalse: [ nodeMenu visibility: BlVisibility gone ] ]
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
