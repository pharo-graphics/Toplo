"
I represent the action of registering a menu item.
The interpretation of my instances will generate a menu.
"
Class {
	#name : #ToMenuRegistration,
	#superclass : #Object,
	#instVars : [
		'builder',
		'childrenItems',
		'name',
		'label',
		'isGroup',
		'parentMenuItem',
		'parent',
		'precondition',
		'groupName',
		'shortcut',
		'order',
		'action',
		'target',
		'selector',
		'arguments',
		'separator',
		'help',
		'icon'
	],
	#category : #'Toplo-MenuRegistration-Core'
}

{ #category : #visiting }
ToMenuRegistration >> accept: aVisitor [

	^ aVisitor visitMenuRegistration: self
]

{ #category : #accessing }
ToMenuRegistration >> action [

	^ action
]

{ #category : #accessing }
ToMenuRegistration >> action: aBlock [

	action := aBlock
]

{ #category : #adding }
ToMenuRegistration >> addChild: aMenuRegistration [

	childrenItems add: aMenuRegistration
]

{ #category : #accessing }
ToMenuRegistration >> arguments [
	^ arguments
]

{ #category : #accessing }
ToMenuRegistration >> arguments: anArray [

	arguments := anArray.
	self updateAction
]

{ #category : #accessing }
ToMenuRegistration >> builder [
	^ builder
]

{ #category : #accessing }
ToMenuRegistration >> builder: aBuilder [

	builder := aBuilder
]

{ #category : #testing }
ToMenuRegistration >> childrenFromGroup: aGroupName [

	^ childrenItems select: [ :item | 
			item groupName = aGroupName 
				and: [ item isGroup = false ]]
]

{ #category : #accessing }
ToMenuRegistration >> childrenItems [

	^ childrenItems
]

{ #category : #accessing }
ToMenuRegistration >> childrenItems: anOrderedCollectionOfMenuRegistration [

	childrenItems := anOrderedCollectionOfMenuRegistration
]

{ #category : #testing }
ToMenuRegistration >> findChildrenItems: aSymbol [
	childrenItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ nil
]

{ #category : #accessing }
ToMenuRegistration >> groupName [

	^ groupName
]

{ #category : #accessing }
ToMenuRegistration >> groupName: aSymbol [

	groupName := aSymbol
]

{ #category : #testing }
ToMenuRegistration >> hasChildren [

	^ childrenItems isNotEmpty
]

{ #category : #testing }
ToMenuRegistration >> hasNoChildren [

	^ childrenItems isEmpty
]

{ #category : #accessing }
ToMenuRegistration >> help [

	^ help
]

{ #category : #accessing }
ToMenuRegistration >> help: aString [

	help := aString
]

{ #category : #testing }
ToMenuRegistration >> icon [

	^ icon
]

{ #category : #testing }
ToMenuRegistration >> icon: aForm [
	"set the icon that is shown in the menu"
	icon := aForm
]

{ #category : #testing }
ToMenuRegistration >> iconName: aSymbol [
	"instead of forcing clients to refer to an icon builder such Smalltalk ui icons
	this message encapsulates it inside the builder itself. When removing uses of Smalltalk ui icons it avoid to force to subclass class with menu to inherit from Model."

	self icon: (Smalltalk ui icons iconNamed: aSymbol)
]

{ #category : #initialization }
ToMenuRegistration >> initialize [

	super initialize.
	childrenItems := OrderedCollection new.
	order := 0.
	label := ''.
	isGroup := false.
	precondition := true.
	separator := false.
	target := self.
	selector := #cull:.
	self updateAction
]

{ #category : #testing }
ToMenuRegistration >> isChild: aSymbol [

	aSymbol ifNil: [ ^ false ].
	aSymbol = name
		ifTrue: [ ^ true ]
		ifFalse: [
			| nextItem |
			nextItem := builder itemsNamed: aSymbol.
			nextItem ifNotNil: [ nextItem := nextItem parent ].
			^ self isChild: nextItem ]
]

{ #category : #accessing }
ToMenuRegistration >> isGroup [

	^ isGroup
]

{ #category : #accessing }
ToMenuRegistration >> isGroup: aBoolean [

	isGroup := aBoolean
]

{ #category : #accessing }
ToMenuRegistration >> keyText: aString [

	shortcut := aString
]

{ #category : #accessing }
ToMenuRegistration >> label [

	^ label
]

{ #category : #accessing }
ToMenuRegistration >> label: aString [

	label := aString 
]

{ #category : #accessing }
ToMenuRegistration >> name [

	^ name
]

{ #category : #accessing }
ToMenuRegistration >> name: aSymbol [

	name := aSymbol
]

{ #category : #accessing }
ToMenuRegistration >> order [

	^ order
]

{ #category : #accessing }
ToMenuRegistration >> order: anInteger [

	order := anInteger
]

{ #category : #accessing }
ToMenuRegistration >> parent [
	^ parent
]

{ #category : #accessing }
ToMenuRegistration >> parent: aSymbol [

	parent := aSymbol
]

{ #category : #accessing }
ToMenuRegistration >> parentMenuItem [

	^ parentMenuItem
]

{ #category : #accessing }
ToMenuRegistration >> parentMenuItem: aMenuRegistration [

	parentMenuItem := aMenuRegistration
]

{ #category : #accessing }
ToMenuRegistration >> precondition [
	^ precondition
]

{ #category : #accessing }
ToMenuRegistration >> precondition: aValuableBlock [

	precondition := aValuableBlock
]

{ #category : #accessing }
ToMenuRegistration >> selector [
	^ selector
]

{ #category : #accessing }
ToMenuRegistration >> selector: aSelector [

	selector := aSelector.
	self updateAction.
]

{ #category : #separator }
ToMenuRegistration >> separator [

	^ separator
]

{ #category : #separator }
ToMenuRegistration >> separator: aBoolean [

	separator := aBoolean
]

{ #category : #accessing }
ToMenuRegistration >> shortcut [
	^ shortcut
]

{ #category : #accessing }
ToMenuRegistration >> shortcut: aString [

	shortcut := aString
]

{ #category : #sorting }
ToMenuRegistration >> sortChildren [

	childrenItems := childrenItems sorted: [ :c1 :c2 | c1 order <= c2 order ].
]

{ #category : #accessing }
ToMenuRegistration >> target [
	^ target
]

{ #category : #accessing }
ToMenuRegistration >> target: aSymbol [

	target := aSymbol.
	self updateAction.
]

{ #category : #sorting }
ToMenuRegistration >> updateAction [

	self action: [
	          MessageSend
		          receiver: target
		          selector: selector
		          arguments: arguments ]
]

{ #category : #'instance creation' }
ToMenuRegistration >> with: aBlock [

	| currentItem |
	aBlock value.
	(builder indexOfChildNamed: name) 
		to: builder collectedItems size 
		do: [ :index |
			currentItem := builder collectedItems at: index.
			(self isChild: currentItem name) ifFalse: [
				builder changeParent: self for: currentItem name ] ]
]

{ #category : #separator }
ToMenuRegistration >> withSeparatorAfter [

	separator := true
]
