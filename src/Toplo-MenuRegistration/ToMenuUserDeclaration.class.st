"
I represent the action of registering a menu item.
The interpretation of my instances will generate a menu.
"
Class {
	#name : #ToMenuUserDeclaration,
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
		'icon',
		'enableBlock'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
ToMenuUserDeclaration >> accept: aVisitor [

	^ aVisitor visitMenuRegistration: self
]

{ #category : #accessing }
ToMenuUserDeclaration >> action [

	^ action
]

{ #category : #accessing }
ToMenuUserDeclaration >> action: aBlock [

	action := aBlock
]

{ #category : #adding }
ToMenuUserDeclaration >> addChild: aMenuRegistration [

	childrenItems add: aMenuRegistration
]

{ #category : #accessing }
ToMenuUserDeclaration >> arguments [
	^ arguments
]

{ #category : #accessing }
ToMenuUserDeclaration >> arguments: anArray [

	arguments := anArray.
	self updateAction
]

{ #category : #accessing }
ToMenuUserDeclaration >> builder [
	^ builder
]

{ #category : #accessing }
ToMenuUserDeclaration >> builder: aBuilder [

	builder := aBuilder
]

{ #category : #testing }
ToMenuUserDeclaration >> childrenFromGroup: aGroupName [

	^ childrenItems select: [ :item | 
			item groupName = aGroupName 
				and: [ item isGroup = false ]]
]

{ #category : #accessing }
ToMenuUserDeclaration >> childrenItems [

	^ childrenItems
]

{ #category : #accessing }
ToMenuUserDeclaration >> childrenItems: anOrderedCollectionOfMenuRegistration [

	childrenItems := anOrderedCollectionOfMenuRegistration
]

{ #category : #accessing }
ToMenuUserDeclaration >> curatedLabel [
	"form now to see the cause"
	^ (self label = ''
		ifTrue: [ self  name asString ]
		ifFalse: [ self label ]).
]

{ #category : #accessing }
ToMenuUserDeclaration >> enabled: aBlock [ 
	enableBlock := aBlock
]

{ #category : #testing }
ToMenuUserDeclaration >> findChildrenItems: aSymbol [
	childrenItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ nil
]

{ #category : #accessing }
ToMenuUserDeclaration >> groupName [

	^ groupName
]

{ #category : #accessing }
ToMenuUserDeclaration >> groupName: aSymbol [

	groupName := aSymbol
]

{ #category : #testing }
ToMenuUserDeclaration >> hasChildren [

	^ childrenItems isNotEmpty
]

{ #category : #testing }
ToMenuUserDeclaration >> hasIcon [
	^ icon isNotNil
]

{ #category : #testing }
ToMenuUserDeclaration >> hasKeyText [

	^ shortcut isNotNil
]

{ #category : #testing }
ToMenuUserDeclaration >> hasNoChildren [

	^ childrenItems isEmpty
]

{ #category : #accessing }
ToMenuUserDeclaration >> help [

	^ help
]

{ #category : #accessing }
ToMenuUserDeclaration >> help: aString [

	help := aString
]

{ #category : #testing }
ToMenuUserDeclaration >> icon [

	^ icon
]

{ #category : #testing }
ToMenuUserDeclaration >> icon: aForm [
	"set the icon that is shown in the menu"
	icon := aForm
]

{ #category : #testing }
ToMenuUserDeclaration >> iconName: aSymbol [
	"instead of forcing clients to refer to an icon builder such Smalltalk ui icons
	this message encapsulates it inside the builder itself. When removing uses of Smalltalk ui icons it avoid to force to subclass class with menu to inherit from Model."

	self icon: (Smalltalk ui icons iconNamed: aSymbol)
]

{ #category : #initialization }
ToMenuUserDeclaration >> initialize [

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
ToMenuUserDeclaration >> isChild: aSymbol [

	aSymbol ifNil: [ ^ false ].
	aSymbol = name
		ifTrue: [ ^ true ]
		ifFalse: [
			| nextItem |
			nextItem := builder itemNamed: aSymbol.
			nextItem ifNotNil: [ nextItem := nextItem parent ].
			^ self isChild: nextItem ]
]

{ #category : #accessing }
ToMenuUserDeclaration >> isGroup [

	^ isGroup
]

{ #category : #accessing }
ToMenuUserDeclaration >> isGroup: aBoolean [

	isGroup := aBoolean
]

{ #category : #accessing }
ToMenuUserDeclaration >> keyText: aString [

	shortcut := aString
]

{ #category : #accessing }
ToMenuUserDeclaration >> label [

	^ label
]

{ #category : #accessing }
ToMenuUserDeclaration >> label: aString [

	label := aString 
]

{ #category : #accessing }
ToMenuUserDeclaration >> name [

	^ name
]

{ #category : #accessing }
ToMenuUserDeclaration >> name: aSymbol [

	name := aSymbol
]

{ #category : #accessing }
ToMenuUserDeclaration >> order [

	^ order
]

{ #category : #accessing }
ToMenuUserDeclaration >> order: anInteger [

	order := anInteger
]

{ #category : #accessing }
ToMenuUserDeclaration >> parent [
	^ parent
]

{ #category : #accessing }
ToMenuUserDeclaration >> parent: aSymbol [

	parent := aSymbol
]

{ #category : #accessing }
ToMenuUserDeclaration >> parentMenuItem [

	^ parentMenuItem
]

{ #category : #accessing }
ToMenuUserDeclaration >> parentMenuItem: aMenuRegistration [

	parentMenuItem := aMenuRegistration
]

{ #category : #accessing }
ToMenuUserDeclaration >> precondition [
	^ precondition
]

{ #category : #accessing }
ToMenuUserDeclaration >> precondition: aValuableBlock [

	precondition := aValuableBlock
]

{ #category : #printing }
ToMenuUserDeclaration >> printOn: aStream [

	super printOn: aStream.
	aStream << '('.
	aStream << name asString.
	aStream << ' - '.
	aStream << label asString.
	aStream << ')'.
	
]

{ #category : #accessing }
ToMenuUserDeclaration >> selector [
	^ selector
]

{ #category : #accessing }
ToMenuUserDeclaration >> selector: aSelector [

	selector := aSelector.
	self updateAction.
]

{ #category : #separator }
ToMenuUserDeclaration >> separator [

	^ separator
]

{ #category : #separator }
ToMenuUserDeclaration >> separator: aBoolean [

	separator := aBoolean
]

{ #category : #accessing }
ToMenuUserDeclaration >> shortcut [
	^ shortcut
]

{ #category : #accessing }
ToMenuUserDeclaration >> shortcut: aString [

	shortcut := aString
]

{ #category : #sorting }
ToMenuUserDeclaration >> sortChildren [

	childrenItems := childrenItems sorted: [ :c1 :c2 | c1 order <= c2 order ].
]

{ #category : #accessing }
ToMenuUserDeclaration >> target [
	^ target
]

{ #category : #accessing }
ToMenuUserDeclaration >> target: aSymbol [

	target := aSymbol.
	self updateAction.
]

{ #category : #sorting }
ToMenuUserDeclaration >> updateAction [

	self action: [
	          MessageSend
		          receiver: target
		          selector: selector
		          arguments: arguments ]
]

{ #category : #'instance creation' }
ToMenuUserDeclaration >> with: aBlock [

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
ToMenuUserDeclaration >> withSeparatorAfter [

	separator := true
]
