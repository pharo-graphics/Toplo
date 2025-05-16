"
I'm a spec for an item menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #ToPluggableMenuItemSpec,
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
	#category : #'Toplo-MenuRegistration'
}

{ #category : #accessing }
ToPluggableMenuItemSpec >> action [
	"Answer the action associated with the receiver"
	^action
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> action: aMessageSend [
	"Answer the action associated with the receiver"
	action := aMessageSend
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> checked [
	"Answer whether the receiver is checked"
	^checked
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> checked: aBool [
	"Indicate whether the receiver is checked"
	checked := aBool
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> enabled [
	"Answer whether the receiver is enabled"
	^ enabledBlock
		ifNil:[enabled ifNil: [ true ]]
		ifNotNil: [ enabledBlock value ]
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> enabled: aBool [
	"Indicate whether the receiver is enabled"
	enabled := aBool
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> enabledBlock [

	^ enabledBlock
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> enabledBlock: aBlock [

	enabledBlock := aBlock
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> hasCheckBox [

	^ checked isNotNil
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> help [
	"Answer the message to get the help texts of this element."
	^ help
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> help: aSymbol [
	"Indicate the message to retrieve the help texts of this element."
	help := aSymbol
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> icon [
	^ self iconFormSet ifNotNil: [ :formSet | formSet asForm ]
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> icon: aForm [
	self iconFormSet: (aForm ifNotNil: [ FormSet form: aForm ])
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> iconFormSet [
	^ iconFormSet
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> iconFormSet: aFormSet [
	iconFormSet := aFormSet
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> keyText [
	^keyText
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> keyText: aString [
	keyText := aString
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> label [
	"Answer the receiver's label"
	^label
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> label: aString [
	"Set the receiver's label"
	label := aString
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> name [
	^ name
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> separator [
	"Answer whether the receiver should be followed by a separator"
	^separator ifNil:[false]
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> separator: aBool [
	"Indicate whether the receiver should be followed by a separator"
	separator := aBool
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> subMenu [
	"Answer the receiver's subMenu"
	^subMenu
]

{ #category : #accessing }
ToPluggableMenuItemSpec >> subMenu: aMenuSpec [
	"Answer the receiver's subMenu"
	subMenu := aMenuSpec
]
