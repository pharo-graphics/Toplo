Class {
	#name : #MenuDescription,
	#superclass : #Object,
	#instVars : [
		'parentName',
		'itemList',
		'order',
		'spec',
		'owner',
		'isGroup',
		'precondition'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
MenuDescription class >> owner: aMenuRegistration [
	^ self new owner: aMenuRegistration
]

{ #category : #'public API spec' }
MenuDescription >> action: aMessageSendOrABlock [
	"set the action of the menu"

	aMessageSendOrABlock isBlock
		ifTrue: [
			self target: aMessageSendOrABlock.
			self selector: #cull:.
			self arguments: {self model}]
		ifFalse: [
			self selector: aMessageSendOrABlock]
]

{ #category : #accessing }
MenuDescription >> addItem: anItem [
	"Add a MenuRegistration"
	self ensureItemList add: anItem
]

{ #category : #'public API spec' }
MenuDescription >> arguments: anArray [
	"set the arguments for an item with an action"
	self spec action
		ifNil: [self spec action: (MessageSend receiver: self itemReceiver selector: nil arguments: anArray)]
		ifNotNil: [self spec action arguments: anArray]
]

{ #category : #accessing }
MenuDescription >> assignOrderWithBlock: aBlock [
	"Compute recursively MenuRegistration order"
	self itemList
		ifNotNil: [self itemList: (aBlock value: self itemList).
				self itemList do: [:rded | rded assignOrderWithBlock: aBlock]]
]

{ #category : #accessing }
MenuDescription >> buildMenuSpec: aMenu [
	"recursiveley build the menu spec aMenu passed as argument"
	self itemList
		ifNotNil: [:l |
			| m |
			m := isGroup
				ifFalse: [PluggableMenuSpec withModel: nil]
				ifTrue: [aMenu].
			(l reject: [:i | i precondition value not]) do: [:i | i buildMenuSpec: m].
			isGroup ifFalse: [self spec subMenu: m]].
	isGroup
		ifTrue: [self spec separator ifTrue: [self itemList ifNotNil: [self itemList last spec separator: true]]]
		ifFalse: [aMenu items add: self spec]
]

{ #category : #accessing }
MenuDescription >> builder [
	^ owner builder
]

{ #category : #accessing }
MenuDescription >> collectMisplacedItemsIn: aCollection [
	"Select recursively all MenuRegistration with a parentName
	different from its owner name. 	This is possible since a parent name
	can be given in order to force a menu item placement.
	If my parentName is not the same as my owner name then it means
	that I'm not in the right place and that my placement has to be resolved"

	self parentName
		ifNotNil: [owner
				ifNil: [aCollection add: self]
				ifNotNil: [owner name = self parentName
						ifFalse: [aCollection add: self]]].
	self itemList ifNotNil: [:l |
		l do: [:item | item collectMisplacedItemsIn: aCollection]]
]

{ #category : #'public API spec' }
MenuDescription >> enabled: aBooleanOrABlock [

	aBooleanOrABlock == true
		ifTrue: [
			self spec enabled: true.
			^ self ].
	aBooleanOrABlock == false
		ifTrue: [
			self spec enabled: false.
			^ self ].
	self spec enabled: (aBooleanOrABlock cull: self model)
]

{ #category : #'public API spec' }
MenuDescription >> enabledBlock [
	^ self spec enabledBlock
]

{ #category : #'public API spec' }
MenuDescription >> enabledBlock: aBlock [

	self spec enabledBlock: aBlock
]

{ #category : #initialization }
MenuDescription >> ensureItemList [
	"Return the list of MenuRegistration instances"
	^ itemList ifNil: [itemList := OrderedCollection new]
]

{ #category : #'sub item creating' }
MenuDescription >> group: aSymbol [
	^ (self item: aSymbol) isGroup: true
]

{ #category : #'public API spec' }
MenuDescription >> help: anHelpText [
	"set the help text"
	self spec help: anHelpText
]

{ #category : #'public API spec' }
MenuDescription >> icon: aForm [
	"set the icon that is shown in the menu"
	self spec icon: aForm
]

{ #category : #'public API spec' }
MenuDescription >> iconFormSet: aFormSet [
	"set the icon that is shown in the menu"
	self spec iconFormSet: aFormSet
]

{ #category : #'public API spec' }
MenuDescription >> iconName: aSymbol [
	"instead of forcing clients to refer to an icon builder such Smalltalk ui icons
	this message encapsulates it inside the builder itself. When removing uses of Smalltalk ui icons it avoid to force to subclass class with menu to inherit from Model."

	self icon: (Smalltalk ui icons iconNamed: aSymbol)
]

{ #category : #initialization }
MenuDescription >> initialize [
	super initialize.
	isGroup := false
]

{ #category : #accessing }
MenuDescription >> isGroup: aBoolean [
	isGroup := aBoolean
]

{ #category : #'sub item creating' }
MenuDescription >> item: aSymbol [
	"set my name and my label with aSymbol (the label and the name as the same by default) and register myself as a child of my owner"
	
	^ (self builder newSubItem) name: aSymbol; label: aSymbol asString
]

{ #category : #accessing }
MenuDescription >> itemList [
	"Return my children"
	^ itemList
]

{ #category : #accessing }
MenuDescription >> itemList: aCollection [
	"Set the list of MenuRegistration"
	 itemList := aCollection
]

{ #category : #accessing }
MenuDescription >> itemNamed: aName [
	"Return the MenuRegistration named aName or nil if none is found"

	| result |
	self name = aName ifTrue: [ ^ self ].
	result := self itemList
		ifNotNil: [ :l |
			l
				detect: [ :item | (item itemNamed: aName) isNotNil ]
				ifNone: [  ] ].
	^ result ifNotNil: [ result itemNamed: aName ]
]

{ #category : #accessing }
MenuDescription >> itemReceiver [
	^ self target ifNil: [owner itemReceiver]
]

{ #category : #'public API spec' }
MenuDescription >> keyText: aString [
	self spec keyText: aString
]

{ #category : #'public API spec' }
MenuDescription >> label [
	"return my label"
	^ self spec label
]

{ #category : #'public API spec' }
MenuDescription >> label: aLabel [
	"set the label that is shown in the menu"
	self spec label: aLabel
]

{ #category : #accessing }
MenuDescription >> model [
	^ self builder model
]

{ #category : #'public API spec' }
MenuDescription >> name [
	"returns my name which is used as a key (should unique over all the menu items"
	^ self spec name
]

{ #category : #'public API spec' }
MenuDescription >> name: aSymbol [
	"set my name (should be unique over all menu items"
	self spec name: aSymbol
]

{ #category : #'sub item creating' }
MenuDescription >> newSubItem [
	| reg |
	reg := self class owner: self.
	self addItem: reg.
	^ reg
]

{ #category : #accessing }
MenuDescription >> order [
	^ order
]

{ #category : #accessing }
MenuDescription >> order: aNumber [
	"Set the value of order"

	order := aNumber
]

{ #category : #accessing }
MenuDescription >> owner [
	^ owner
]

{ #category : #accessing }
MenuDescription >> owner: anItem [
	owner := anItem
]

{ #category : #accessing }
MenuDescription >> parent: aSymbol [
	self parentName: aSymbol
]

{ #category : #accessing }
MenuDescription >> parentName [
	^ parentName
]

{ #category : #accessing }
MenuDescription >> parentName: aSymbol [
	parentName := aSymbol
]

{ #category : #accessing }
MenuDescription >> precondition [
	^ precondition ifNil: [[true]]
]

{ #category : #accessing }
MenuDescription >> precondition: aValuable [
	precondition := aValuable
]

{ #category : #printing }
MenuDescription >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< ' ( ';
		print: self name;
		<< ' ) '
]

{ #category : #initialization }
MenuDescription >> release [
	itemList := nil.
	self releaseActionMap
]

{ #category : #accessing }
MenuDescription >> removeItem: anItem [
	"Remove a MenuRegistration"
	self itemList remove: anItem
]

{ #category : #initialization }
MenuDescription >> reset [
	itemList
		ifNotNil: [
			itemList do: [:i | i reset].
			itemList := nil].
	spec := nil
]

{ #category : #'public API spec' }
MenuDescription >> selector: aSymbol [
	"set the selector for item with an action"
	self spec action
		ifNil: [self spec action: (MessageSend receiver: self itemReceiver selector: aSymbol)]
		ifNotNil: [self spec action selector: aSymbol]
]

{ #category : #accessing }
MenuDescription >> sort: aSortBlock [
	"Sort the tree recursively"
	self itemList
		ifNotNil: [
		self itemList: (self itemList asSortedCollection: aSortBlock).
		self itemList do: [:rded | rded sort: aSortBlock] ]
]

{ #category : #'sub item creating' }
MenuDescription >> spec [
	"return my PluggableMenuItemSpec"

	^ spec ifNil: [ spec := SMenuItemSpec new ]
]

{ #category : #'public API spec' }
MenuDescription >> target [
	^ self spec action ifNotNil: [:action | action receiver]
]

{ #category : #'public API spec' }
MenuDescription >> target: anObject [
	"set the target for the action"
	self spec action
		ifNil: [self spec action: (MessageSend receiver: (anObject ifNil: [owner itemReceiver]) selector: nil)]
		ifNotNil: [self spec action receiver: anObject]
]

{ #category : #'sub item creating' }
MenuDescription >> with: aBlock [
	self builder currentRoot: self while: aBlock
]

{ #category : #'public API spec' }
MenuDescription >> withSeparatorAfter [
	"add a separator line after me"
	self spec separator: true
]
