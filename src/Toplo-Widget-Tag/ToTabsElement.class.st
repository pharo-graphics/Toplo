Class {
	#name : #ToTabsElement,
	#superclass : #ToTripletElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#instVars : [
		'invisibleNodes',
		'visibleNodes'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - triplet element - configuration' }
ToTabsElement >> applyToploConfiguration [

	super applyToploConfiguration.

]

{ #category : #accessing }
ToTabsElement >> atStartSide [

	^ self toploConfiguration atStartSide
]

{ #category : #accessing }
ToTabsElement >> atStartSide: aBoolean [

	self atStartSide = aBoolean ifTrue: [ ^ self ].
	self toploConfiguration atStartSide: aBoolean.
	self requestNewConfigurationPass
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

	aValuable value: self toploConfiguration endExtraContainer 
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

	self addEventHandler: self defaultEventHandler.
	"self initializeExtras "
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
ToTabsElement >> newToploConfiguration [ 

	^ ToTabsElementConfiguration new
]

{ #category : #accessing }
ToTabsElement >> nodeMenu [ 

	^ self toploConfiguration nodeMenu
]

{ #category : #'t - bar element' }
ToTabsElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	(theInvisibleNodes = self invisibleNodes and: [
		 theVisibleNodes = self visibleNodes ]) ifTrue: [ ^ self ].
	
	invisibleNodes := theInvisibleNodes asArray.
	visibleNodes := theVisibleNodes asArray.
	self dispatchEvent: ToVisibleTabsChanged new.

]

{ #category : #'event handling' }
ToTabsElement >> showNodeMenu: aBoolean [

	self nodeMenu parentDo: [ :p |
		aBoolean
			ifTrue: [ self nodeMenu visibility: BlVisibility visible ]
			ifFalse: [ self nodeMenu visibility: BlVisibility gone ] ]
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
