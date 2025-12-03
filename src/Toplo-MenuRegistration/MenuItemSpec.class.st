"
I'm a spec for an item menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #MenuItemSpec,
	#superclass : #Object,
	#instVars : [
		'label',
		'action',
		'checked',
		'enabled',
		'separator',
		'subMenu',
		'iconFormSet',
		'enabledBlock',
		'keyText',
		'help',
		'name'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
MenuItemSpec >> accept: aVisitor [

	^ aVisitor visitMenuItemSpec: self
]

{ #category : #accessing }
MenuItemSpec >> action [
	"Answer the action associated with the receiver"
	^action
]

{ #category : #accessing }
MenuItemSpec >> action: aMessageSend [
	"Answer the action associated with the receiver"
	action := aMessageSend
]

{ #category : #accessing }
MenuItemSpec >> checked [
	"Answer whether the receiver is checked"
	^checked
]

{ #category : #accessing }
MenuItemSpec >> checked: aBool [
	"Indicate whether the receiver is checked"
	checked := aBool
]

{ #category : #accessing }
MenuItemSpec >> enabled [
	"Answer whether the receiver is enabled"
	^ enabledBlock
		ifNil:[enabled ifNil: [ true ]]
		ifNotNil: [ enabledBlock value ]
]

{ #category : #accessing }
MenuItemSpec >> enabled: aBool [
	"Indicate whether the receiver is enabled"
	enabled := aBool
]

{ #category : #accessing }
MenuItemSpec >> enabledBlock [

	^ enabledBlock
]

{ #category : #accessing }
MenuItemSpec >> enabledBlock: aBlock [

	enabledBlock := aBlock
]

{ #category : #accessing }
MenuItemSpec >> hasCheckBox [

	^ checked isNotNil
]

{ #category : #accessing }
MenuItemSpec >> help [
	"Answer the message to get the help texts of this element."
	^ help
]

{ #category : #accessing }
MenuItemSpec >> help: aSymbol [
	"Indicate the message to retrieve the help texts of this element."
	help := aSymbol
]

{ #category : #accessing }
MenuItemSpec >> icon [
	^ self iconFormSet ifNotNil: [ :formSet | formSet asForm ]
]

{ #category : #accessing }
MenuItemSpec >> icon: aForm [
	self iconFormSet: (aForm ifNotNil: [ FormSet form: aForm ])
]

{ #category : #accessing }
MenuItemSpec >> iconFormSet [
	^ iconFormSet
]

{ #category : #accessing }
MenuItemSpec >> iconFormSet: aFormSet [
	iconFormSet := aFormSet
]

{ #category : #accessing }
MenuItemSpec >> keyText [
	^keyText
]

{ #category : #accessing }
MenuItemSpec >> keyText: aString [
	keyText := aString
]

{ #category : #accessing }
MenuItemSpec >> label [
	"Answer the receiver's label"
	^label
]

{ #category : #accessing }
MenuItemSpec >> label: aString [
	"Set the receiver's label"
	label := aString
]

{ #category : #accessing }
MenuItemSpec >> name [
	^ name
]

{ #category : #accessing }
MenuItemSpec >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MenuItemSpec >> separator [
	"Answer whether the receiver should be followed by a separator"
	^separator ifNil:[false]
]

{ #category : #accessing }
MenuItemSpec >> separator: aBool [
	"Indicate whether the receiver should be followed by a separator"
	separator := aBool
]

{ #category : #accessing }
MenuItemSpec >> subMenu [
	"Answer the receiver's subMenu"
	^subMenu
]

{ #category : #accessing }
MenuItemSpec >> subMenu: aMenuSpec [
	"Answer the receiver's subMenu"
	subMenu := aMenuSpec
]

{ #category : #accessing }
MenuItemSpec >> withSeparatorAfter [

	separator := true
]
