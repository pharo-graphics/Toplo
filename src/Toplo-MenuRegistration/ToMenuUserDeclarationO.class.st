"
I represent the action of registering a menu item.
The interpretation of my instances will generate a menu.
"
Class {
	#name : #ToMenuUserDeclarationO,
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
	#category : #'Toplo-MenuRegistration-O'
}

{ #category : #visiting }
ToMenuUserDeclarationO >> accept: aVisitor [

	^ aVisitor visitMenuRegistration: self
]

{ #category : #accessing }
ToMenuUserDeclarationO >> action [

	^ action
]

{ #category : #accessing }
ToMenuUserDeclarationO >> action: aBlock [

	action := aBlock
]

{ #category : #adding }
ToMenuUserDeclarationO >> addChild: aMenuRegistration [

	childrenItems add: aMenuRegistration
]

{ #category : #accessing }
ToMenuUserDeclarationO >> arguments [
	^ arguments
]

{ #category : #accessing }
ToMenuUserDeclarationO >> arguments: anArray [

	arguments := anArray.
	self updateAction
]

{ #category : #accessing }
ToMenuUserDeclarationO >> builder [
	^ builder
]

{ #category : #accessing }
ToMenuUserDeclarationO >> builder: aBuilder [

	builder := aBuilder
]

{ #category : #testing }
ToMenuUserDeclarationO >> childrenFromGroup: aGroupName [

	^ childrenItems select: [ :item | 
			item groupName = aGroupName 
				and: [ item isGroup = false ]]
]

{ #category : #accessing }
ToMenuUserDeclarationO >> childrenItems [

	^ childrenItems
]

{ #category : #accessing }
ToMenuUserDeclarationO >> childrenItems: anOrderedCollectionOfMenuRegistration [

	childrenItems := anOrderedCollectionOfMenuRegistration
]

{ #category : #accessing }
ToMenuUserDeclarationO >> curatedLabel [
	"form now to see the cause"
	^ (self label = ''
		ifTrue: [ self  name asString ]
		ifFalse: [ self label ]).
]

{ #category : #accessing }
ToMenuUserDeclarationO >> enabled: aBlock [ 
	enableBlock := aBlock
]

{ #category : #testing }
ToMenuUserDeclarationO >> findChildrenItems: aSymbol [
	childrenItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ nil
]

{ #category : #accessing }
ToMenuUserDeclarationO >> groupName [

	^ groupName
]

{ #category : #accessing }
ToMenuUserDeclarationO >> groupName: aSymbol [

	groupName := aSymbol
]

{ #category : #testing }
ToMenuUserDeclarationO >> hasChildren [

	^ childrenItems isNotEmpty
]

{ #category : #testing }
ToMenuUserDeclarationO >> hasIcon [
	^ icon isNotNil
]

{ #category : #testing }
ToMenuUserDeclarationO >> hasKeyText [

	^ shortcut isNotNil
]

{ #category : #testing }
ToMenuUserDeclarationO >> hasNoChildren [

	^ childrenItems isEmpty
]

{ #category : #accessing }
ToMenuUserDeclarationO >> help [

	^ help
]

{ #category : #accessing }
ToMenuUserDeclarationO >> help: aString [

	help := aString
]

{ #category : #testing }
ToMenuUserDeclarationO >> icon [

	^ icon
]

{ #category : #testing }
ToMenuUserDeclarationO >> icon: aForm [
	"set the icon that is shown in the menu"
	icon := aForm
]

{ #category : #testing }
ToMenuUserDeclarationO >> iconName: aSymbol [
	"instead of forcing clients to refer to an icon builder such Smalltalk ui icons
	this message encapsulates it inside the builder itself. When removing uses of Smalltalk ui icons it avoid to force to subclass class with menu to inherit from Model."

	self icon: (Smalltalk ui icons iconNamed: aSymbol)
]

{ #category : #initialization }
ToMenuUserDeclarationO >> initialize [

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
ToMenuUserDeclarationO >> isChild: aSymbol [

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
ToMenuUserDeclarationO >> isGroup [

	^ isGroup
]

{ #category : #accessing }
ToMenuUserDeclarationO >> isGroup: aBoolean [

	isGroup := aBoolean
]

{ #category : #accessing }
ToMenuUserDeclarationO >> keyText: aString [

	shortcut := aString
]

{ #category : #accessing }
ToMenuUserDeclarationO >> label [

	^ label
]

{ #category : #accessing }
ToMenuUserDeclarationO >> label: aString [

	label := aString 
]

{ #category : #accessing }
ToMenuUserDeclarationO >> name [

	^ name
]

{ #category : #accessing }
ToMenuUserDeclarationO >> name: aSymbol [

	name := aSymbol
]

{ #category : #accessing }
ToMenuUserDeclarationO >> order [

	^ order
]

{ #category : #accessing }
ToMenuUserDeclarationO >> order: anInteger [

	order := anInteger
]

{ #category : #accessing }
ToMenuUserDeclarationO >> parent [
	^ parent
]

{ #category : #accessing }
ToMenuUserDeclarationO >> parent: aSymbol [

	parent := aSymbol
]

{ #category : #accessing }
ToMenuUserDeclarationO >> parentMenuItem [

	^ parentMenuItem
]

{ #category : #accessing }
ToMenuUserDeclarationO >> parentMenuItem: aMenuRegistration [

	parentMenuItem := aMenuRegistration
]

{ #category : #accessing }
ToMenuUserDeclarationO >> precondition [
	^ precondition
]

{ #category : #accessing }
ToMenuUserDeclarationO >> precondition: aValuableBlock [

	precondition := aValuableBlock
]

{ #category : #printing }
ToMenuUserDeclarationO >> printOn: aStream [

	super printOn: aStream.
	aStream << '('.
	aStream << name asString.
	aStream << ' - '.
	aStream << label asString.
	aStream << ')'.
	
]

{ #category : #accessing }
ToMenuUserDeclarationO >> selector [
	^ selector
]

{ #category : #accessing }
ToMenuUserDeclarationO >> selector: aSelector [

	selector := aSelector.
	self updateAction.
]

{ #category : #separator }
ToMenuUserDeclarationO >> separator [

	^ separator
]

{ #category : #separator }
ToMenuUserDeclarationO >> separator: aBoolean [

	separator := aBoolean
]

{ #category : #accessing }
ToMenuUserDeclarationO >> shortcut [
	^ shortcut
]

{ #category : #accessing }
ToMenuUserDeclarationO >> shortcut: aString [

	shortcut := aString
]

{ #category : #sorting }
ToMenuUserDeclarationO >> sortChildren [

	childrenItems := childrenItems sorted: [ :c1 :c2 | c1 order <= c2 order ].
]

{ #category : #accessing }
ToMenuUserDeclarationO >> target [
	^ target
]

{ #category : #accessing }
ToMenuUserDeclarationO >> target: aSymbol [

	target := aSymbol.
	self updateAction.
]

{ #category : #sorting }
ToMenuUserDeclarationO >> updateAction [

	self action: [
	          MessageSend
		          receiver: target
		          selector: selector
		          arguments: arguments ]
]

{ #category : #'instance creation' }
ToMenuUserDeclarationO >> with: aBlock [

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
ToMenuUserDeclarationO >> withSeparatorAfter [

	separator := true
]
