Class {
	#name : #ToMenuRegistration,
	#superclass : #Object,
	#instVars : [
		'builder',
		'childrenItems',
		'name',
		'label',
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
		'separator'
	],
	#category : #'Toplo-MenuRegistration-NewCreate'
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
	action := aBlock.
]

{ #category : #adding }
ToMenuRegistration >> addChild: aMenuRegistration [
	childrenItems add: aMenuRegistration.
]

{ #category : #accessing }
ToMenuRegistration >> arguments [
	^ arguments
]

{ #category : #accessing }
ToMenuRegistration >> arguments: anArray [

	arguments := anArray.
	self updateAction.
]

{ #category : #accessing }
ToMenuRegistration >> builder [
	^ builder
]

{ #category : #accessing }
ToMenuRegistration >> builder: aBuilder [
	builder := aBuilder.
]

{ #category : #accessing }
ToMenuRegistration >> childrenItems [
	^ childrenItems
]

{ #category : #accessing }
ToMenuRegistration >> childrenItems: anOrderedCollectionOfMenuRegistration [
	childrenItems := anOrderedCollectionOfMenuRegistration.
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

{ #category : #initialization }
ToMenuRegistration >> initialize [

	super initialize.
	childrenItems := OrderedCollection new.
	order := 0.
	label := ''.
	precondition := true.
	separator := false.
	target := self.
	selector := #cull:.
	arguments := nil.
	self updateAction.
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

{ #category : #'spec accessing' }
ToMenuRegistration >> separator [
	^ separator
]

{ #category : #'spec accessing' }
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

{ #category : #'as yet unclassified' }
ToMenuRegistration >> updateAction [

	self action: [
	          MessageSend
		          receiver: target
		          selector: selector
		          arguments: arguments ]
]

{ #category : #'instance creation' }
ToMenuRegistration >> with: aBlock [

	| menu |
	menu := aBlock value.
	aBlock value builder changeParent: self for: menu name
]

{ #category : #'spec accessing' }
ToMenuRegistration >> withSeparatorAfter [
	separator := true.
]
