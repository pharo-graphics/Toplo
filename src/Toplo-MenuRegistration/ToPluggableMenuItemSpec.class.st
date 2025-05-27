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
	#category : #'Toplo-MenuRegistration-Spec'
}

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> action [
	"Answer the action associated with the receiver"
	^action
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> action: aMessageSend [
	"Answer the action associated with the receiver"
	action := aMessageSend
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> checked [
	"Answer whether the receiver is checked"
	^checked
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> checked: aBool [
	"Indicate whether the receiver is checked"
	checked := aBool
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> enabled [
	"Answer whether the receiver is enabled"
	^ enabledBlock
		ifNil:[enabled ifNil: [ true ]]
		ifNotNil: [ enabledBlock value ]
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> enabled: aBool [
	"Indicate whether the receiver is enabled"
	enabled := aBool
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> enabledBlock [

	^ enabledBlock
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> enabledBlock: aBlock [

	enabledBlock := aBlock
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> hasCheckBox [

	^ checked isNotNil
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> help [
	"Answer the message to get the help texts of this element."
	^ help
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> help: aSymbol [
	"Indicate the message to retrieve the help texts of this element."
	help := aSymbol
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> icon [
	^ self iconFormSet ifNotNil: [ :formSet | formSet asForm ]
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> icon: aForm [
	self iconFormSet: (aForm ifNotNil: [ FormSet form: aForm ])
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> iconFormSet [
	^ iconFormSet
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> iconFormSet: aFormSet [
	iconFormSet := aFormSet
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> keyText [
	^keyText
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> keyText: aString [
	keyText := aString
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> label [
	"Answer the receiver's label"
	^label
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> label: aString [
	"Set the receiver's label"
	label := aString
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> name [
	^ name
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> separator [
	"Answer whether the receiver should be followed by a separator"
	^separator ifNil:[false]
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> separator: aBool [
	"Indicate whether the receiver should be followed by a separator"
	separator := aBool
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> subMenu [
	"Answer the receiver's subMenu"
	^subMenu
]

{ #category : #'as yet unclassified' }
ToPluggableMenuItemSpec >> subMenu: aMenuSpec [
	"Answer the receiver's subMenu"
	subMenu := aMenuSpec
]
