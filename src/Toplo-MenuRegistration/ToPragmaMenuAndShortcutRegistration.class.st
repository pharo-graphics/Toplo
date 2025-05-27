"
A PragmaMenuAndShortcutRegistration is the list items holder
"
Class {
	#name : #ToPragmaMenuAndShortcutRegistration,
	#superclass : #Object,
	#instVars : [
		'items',
		'currentRoot',
		'platform',
		'model'
	],
	#category : #'Toplo-MenuRegistration-Old'
}

{ #category : #'instance creation' }
ToPragmaMenuAndShortcutRegistration class >> model: aModel [

	^ self new
		model: aModel;
		yourself
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> action: aBlock [

	self currentItem action: aBlock
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> arguments: anArray [

	self currentItem arguments: anArray
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> category: aByteSymbol [

	self currentItem
		category: aByteSymbol
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> category: aByteSymbol default: aKMModifiedShortcut do: aBlockClosure [

	self currentItem
		category: aByteSymbol;
		default: aKMModifiedShortcut;
		action: aBlockClosure
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> category: aByteSymbol default: aKMModifiedShortcut do: aBlockClosure description: aByteString [

	self currentItem
		category: aByteSymbol;
		default: aKMModifiedShortcut;
		action: aBlockClosure;
		help: aByteString
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> category: aByteSymbol shortcut: aKMModifiedShortcut do: aBlockClosure [

	self currentItem
		category: aByteSymbol;
		default: aKMModifiedShortcut;
		action: aBlockClosure
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> category: aByteSymbol shortcut: aKMModifiedShortcut do: aBlockClosure description: aByteString [

	self currentItem
		category: aByteSymbol;
		default: aKMModifiedShortcut;
		action: aBlockClosure;
		help: aByteString
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> createNewItem [

	items add: self itemClass new.

	self currentItem
		platform: platform;
		parent: currentRoot
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> currentItem [

	^ items last
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> currentRoot [

	^ currentRoot
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> currentRoot: aMenuRegistration [

	currentRoot := aMenuRegistration
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> default: aKMModifiedShortcut [

	self currentItem
		default: aKMModifiedShortcut
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> description: aByteString [

	self currentItem
		help: aByteString
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> do: aBlockClosure [

	self currentItem
		action: aBlockClosure
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> enabled: aBoolean [

	self currentItem enabled: aBoolean
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> enabledBlock: aBlock [

	self currentItem enabledBlock: aBlock
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> group: aSymbol [

	self createNewItem.
	self currentItem group: aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> handOutItems [
	"we don't want to hold a reference to the items after they are hand out to the registration"

	| itemsCopy |
	itemsCopy := items copy.
	items removeAll.
	^ itemsCopy
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> help: aString [

	self currentItem help: aString
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> icon: anIcon [

	self currentItem icon: anIcon
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> iconFormSet: aFormSet [

	self currentItem iconFormSet: aFormSet
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> iconName: aSymbol [
	"instead of forcing clients to refer to an icon builder such Smalltalk ui icons
	this message encapsulates it inside the builder itself. When removing uses of Smalltalk ui icons it avoid to force to subclass class with menu to inherit from Model."

	self iconFormSet: (Smalltalk ui icons iconFormSetNamed: aSymbol)
]

{ #category : #initialization }
ToPragmaMenuAndShortcutRegistration >> initialize [

	super initialize.
	items := OrderedCollection new
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> item: aSymbol [

	self createNewItem.
	self currentItem item: aSymbol
]

{ #category : #private }
ToPragmaMenuAndShortcutRegistration >> itemClass [

	^ ToPragmaMenuAndShortcutRegistrationItem
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> items [

	^ items
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> keyText: aString [
	self currentItem keyText: aString
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> keyText: aString if: aBoolean [
	aBoolean ifFalse: [ ^ self ].
	self keyText: aString
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> label: aString [

	self currentItem label: aString
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> model [

	^ model
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistration >> model: aModel [

	model := aModel
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> order: anInteger [

	self currentItem order: anInteger
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> parent: aSymbol [

	self currentItem parent: aSymbol
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> platform: anArray [

	anArray isEmpty
		ifTrue: [ platform := #all ]
		ifFalse: [ platform := anArray first ]
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> precondition: aBlock [

	self currentItem precondition: aBlock
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> selector: aSelector [

	self currentItem selector: aSelector
]

{ #category : #'keymapping protocol' }
ToPragmaMenuAndShortcutRegistration >> shortcut: aSymbol [

	self createNewItem.
	self currentItem shortcut: aSymbol
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> target: aSymbol [

	self currentItem target: aSymbol
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> with: aBlock [

	| old itemOrGroup |
	old := self currentRoot.
	itemOrGroup := self currentItem item ifNil: [ self currentItem group ].
	self currentRoot: itemOrGroup.
	[ aBlock value ] ensure: [ self currentRoot: old ]
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistration >> withSeparatorAfter [

	self currentItem withSeparatorAfter
]
