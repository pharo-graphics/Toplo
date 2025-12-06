"
I'm a spec for an item menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #SMenuItemSpec,
	#superclass : #SAbstractMenuSpec,
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

{ #category : #accessing }
SMenuItemSpec >> action [
	"Answer the action associated with the receiver"
	^action
]

{ #category : #accessing }
SMenuItemSpec >> action: aMessageSend [
	"Answer the action associated with the receiver"
	action := aMessageSend
]

{ #category : #accessing }
SMenuItemSpec >> checked [
	"Answer whether the receiver is checked"
	^checked
]

{ #category : #accessing }
SMenuItemSpec >> checked: aBool [
	"Indicate whether the receiver is checked"
	checked := aBool
]

{ #category : #accessing }
SMenuItemSpec >> enabled [
	"Answer whether the receiver is enabled"
	^ enabledBlock
		ifNil:[enabled ifNil: [ true ]]
		ifNotNil: [ enabledBlock value ]
]

{ #category : #accessing }
SMenuItemSpec >> enabled: aBool [
	"Indicate whether the receiver is enabled"
	enabled := aBool
]

{ #category : #accessing }
SMenuItemSpec >> enabledBlock [

	^ enabledBlock
]

{ #category : #accessing }
SMenuItemSpec >> enabledBlock: aBlock [

	enabledBlock := aBlock
]

{ #category : #accessing }
SMenuItemSpec >> hasCheckBox [

	^ checked isNotNil
]

{ #category : #accessing }
SMenuItemSpec >> help [
	"Answer the message to get the help texts of this element."
	^ help
]

{ #category : #accessing }
SMenuItemSpec >> help: aSymbol [
	"Indicate the message to retrieve the help texts of this element."
	help := aSymbol
]

{ #category : #accessing }
SMenuItemSpec >> icon [
	^ self iconFormSet ifNotNil: [ :formSet | formSet asForm ]
]

{ #category : #accessing }
SMenuItemSpec >> icon: aForm [
	self iconFormSet: (aForm ifNotNil: [ FormSet form: aForm ])
]

{ #category : #accessing }
SMenuItemSpec >> iconFormSet [
	^ iconFormSet
]

{ #category : #accessing }
SMenuItemSpec >> iconFormSet: aFormSet [
	iconFormSet := aFormSet
]

{ #category : #accessing }
SMenuItemSpec >> keyText [
	^keyText
]

{ #category : #accessing }
SMenuItemSpec >> keyText: aString [
	keyText := aString
]

{ #category : #accessing }
SMenuItemSpec >> label [
	"Answer the receiver's label"
	^label
]

{ #category : #accessing }
SMenuItemSpec >> label: aString [
	"Set the receiver's label"
	label := aString
]

{ #category : #accessing }
SMenuItemSpec >> name [
	^ name
]

{ #category : #accessing }
SMenuItemSpec >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SMenuItemSpec >> separator [
	"Answer whether the receiver should be followed by a separator"
	^separator ifNil:[false]
]

{ #category : #accessing }
SMenuItemSpec >> separator: aBool [
	"Indicate whether the receiver should be followed by a separator"
	separator := aBool
]

{ #category : #accessing }
SMenuItemSpec >> subMenu [
	"Answer the receiver's subMenu"
	^subMenu
]

{ #category : #accessing }
SMenuItemSpec >> subMenu: aMenuSpec [
	"Answer the receiver's subMenu"
	subMenu := aMenuSpec
]
