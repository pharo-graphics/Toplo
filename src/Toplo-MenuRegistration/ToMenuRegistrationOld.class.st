"
I represent the action of registering a menu item.
The interpretation of my instances will generate a menu.
"
Class {
	#name : #ToMenuRegistrationOld,
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
	#category : #'Toplo-MenuRegistration-Old'
}

{ #category : #visiting }
ToMenuRegistrationOld >> accept: aVisitor [

	^ aVisitor visitMenuRegistration: self
]

{ #category : #accessing }
ToMenuRegistrationOld >> action [

	^ action
]

{ #category : #accessing }
ToMenuRegistrationOld >> action: aBlock [

	action := aBlock
]

{ #category : #adding }
ToMenuRegistrationOld >> addChild: aMenuRegistration [

	childrenItems add: aMenuRegistration
]

{ #category : #accessing }
ToMenuRegistrationOld >> arguments [
	^ arguments
]

{ #category : #accessing }
ToMenuRegistrationOld >> arguments: anArray [

	arguments := anArray.
	self updateAction
]

{ #category : #accessing }
ToMenuRegistrationOld >> builder [
	^ builder
]

{ #category : #accessing }
ToMenuRegistrationOld >> builder: aBuilder [

	builder := aBuilder
]

{ #category : #testing }
ToMenuRegistrationOld >> childrenFromGroup: aGroupName [

	^ childrenItems select: [ :item | 
			item groupName = aGroupName 
				and: [ item isGroup = false ]]
]

{ #category : #accessing }
ToMenuRegistrationOld >> childrenItems [

	^ childrenItems
]

{ #category : #accessing }
ToMenuRegistrationOld >> childrenItems: anOrderedCollectionOfMenuRegistration [

	childrenItems := anOrderedCollectionOfMenuRegistration
]

{ #category : #accessing }
ToMenuRegistrationOld >> curatedLabel [
	"form now to see the cause"
	^ (self label = ''
		ifTrue: [ self  name asString ]
		ifFalse: [ self label ]).
]

{ #category : #accessing }
ToMenuRegistrationOld >> enabled: aBlock [ 
	enableBlock := aBlock
]

{ #category : #testing }
ToMenuRegistrationOld >> findChildrenItems: aSymbol [
	childrenItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ nil
]

{ #category : #accessing }
ToMenuRegistrationOld >> groupName [

	^ groupName
]

{ #category : #accessing }
ToMenuRegistrationOld >> groupName: aSymbol [

	groupName := aSymbol
]

{ #category : #testing }
ToMenuRegistrationOld >> hasChildren [

	^ childrenItems isNotEmpty
]

{ #category : #testing }
ToMenuRegistrationOld >> hasIcon [
	^ icon isNotNil
]

{ #category : #testing }
ToMenuRegistrationOld >> hasKeyText [

	^ shortcut isNotNil
]

{ #category : #testing }
ToMenuRegistrationOld >> hasNoChildren [

	^ childrenItems isEmpty
]

{ #category : #accessing }
ToMenuRegistrationOld >> help [

	^ help
]

{ #category : #accessing }
ToMenuRegistrationOld >> help: aString [

	help := aString
]

{ #category : #testing }
ToMenuRegistrationOld >> icon [

	^ icon
]

{ #category : #testing }
ToMenuRegistrationOld >> icon: aForm [
	"set the icon that is shown in the menu"
	icon := aForm
]

{ #category : #testing }
ToMenuRegistrationOld >> iconName: aSymbol [
	"instead of forcing clients to refer to an icon builder such Smalltalk ui icons
	this message encapsulates it inside the builder itself. When removing uses of Smalltalk ui icons it avoid to force to subclass class with menu to inherit from Model."

	self icon: (Smalltalk ui icons iconNamed: aSymbol)
]

{ #category : #initialization }
ToMenuRegistrationOld >> initialize [

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
ToMenuRegistrationOld >> isChild: aSymbol [

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
ToMenuRegistrationOld >> isGroup [

	^ isGroup
]

{ #category : #accessing }
ToMenuRegistrationOld >> isGroup: aBoolean [

	isGroup := aBoolean
]

{ #category : #accessing }
ToMenuRegistrationOld >> keyText: aString [

	shortcut := aString
]

{ #category : #accessing }
ToMenuRegistrationOld >> label [

	^ label
]

{ #category : #accessing }
ToMenuRegistrationOld >> label: aString [

	label := aString 
]

{ #category : #accessing }
ToMenuRegistrationOld >> name [

	^ name
]

{ #category : #accessing }
ToMenuRegistrationOld >> name: aSymbol [

	name := aSymbol
]

{ #category : #accessing }
ToMenuRegistrationOld >> order [

	^ order
]

{ #category : #accessing }
ToMenuRegistrationOld >> order: anInteger [

	order := anInteger
]

{ #category : #accessing }
ToMenuRegistrationOld >> parent [
	^ parent
]

{ #category : #accessing }
ToMenuRegistrationOld >> parent: aSymbol [

	parent := aSymbol
]

{ #category : #accessing }
ToMenuRegistrationOld >> parentMenuItem [

	^ parentMenuItem
]

{ #category : #accessing }
ToMenuRegistrationOld >> parentMenuItem: aMenuRegistration [

	parentMenuItem := aMenuRegistration
]

{ #category : #accessing }
ToMenuRegistrationOld >> precondition [
	^ precondition
]

{ #category : #accessing }
ToMenuRegistrationOld >> precondition: aValuableBlock [

	precondition := aValuableBlock
]

{ #category : #printing }
ToMenuRegistrationOld >> printOn: aStream [

	super printOn: aStream.
	aStream << '('.
	aStream << name asString.
	aStream << ' - '.
	aStream << label asString.
	aStream << ')'.
	
]

{ #category : #accessing }
ToMenuRegistrationOld >> selector [
	^ selector
]

{ #category : #accessing }
ToMenuRegistrationOld >> selector: aSelector [

	selector := aSelector.
	self updateAction.
]

{ #category : #separator }
ToMenuRegistrationOld >> separator [

	^ separator
]

{ #category : #separator }
ToMenuRegistrationOld >> separator: aBoolean [

	separator := aBoolean
]

{ #category : #accessing }
ToMenuRegistrationOld >> shortcut [
	^ shortcut
]

{ #category : #accessing }
ToMenuRegistrationOld >> shortcut: aString [

	shortcut := aString
]

{ #category : #sorting }
ToMenuRegistrationOld >> sortChildren [

	childrenItems := childrenItems sorted: [ :c1 :c2 | c1 order <= c2 order ].
]

{ #category : #accessing }
ToMenuRegistrationOld >> target [
	^ target
]

{ #category : #accessing }
ToMenuRegistrationOld >> target: aSymbol [

	target := aSymbol.
	self updateAction.
]

{ #category : #sorting }
ToMenuRegistrationOld >> updateAction [

	self action: [
	          MessageSend
		          receiver: target
		          selector: selector
		          arguments: arguments ]
]

{ #category : #'instance creation' }
ToMenuRegistrationOld >> with: aBlock [

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
ToMenuRegistrationOld >> withSeparatorAfter [

	separator := true
]
