"
A PragmaMenuAndShortcutRegistrationItem is an item of a menu or keymap
"
Class {
	#name : #ToPragmaMenuAndShortcutRegistrationItem,
	#superclass : #Object,
	#instVars : [
		'item',
		'action',
		'parent',
		'order',
		'enabledBlock',
		'label',
		'help',
		'iconFormSet',
		'selector',
		'arguments',
		'withSeparatorAfter',
		'target',
		'enabled',
		'group',
		'with',
		'precondition',
		'shortcut',
		'platform',
		'default',
		'category',
		'shortcutName',
		'keyText'
	],
	#category : #'Toplo-MenuRegistration'
}

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> action [

	^ action
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> action: aBlock [

	action := aBlock
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> arguments [

	^ arguments
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> arguments: anArray [

	arguments := anArray
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> category [

	^ category
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> category: aByteSymbol [

	category := aByteSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> default [

	^ default
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> default: aKMModifiedShortcut [

	default := aKMModifiedShortcut
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> enabled [

	^ enabled
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> enabled: aBoolean [

	enabled := aBoolean
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> enabledBlock [

	^ enabledBlock
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> enabledBlock: aBlock [

	enabledBlock := aBlock
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> group [

	^ group
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> group: aSymbol [

	group := aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> help [

	^ help
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> help: aString [

	help := aString
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> icon [

	^ self iconFormSet ifNotNil: [ :formSet | formSet asForm ]
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> icon: aForm [

	self iconFormSet: (aForm ifNotNil: [ FormSet form: aForm ])
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> iconFormSet [

	^ iconFormSet
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> iconFormSet: aFormSet [

	iconFormSet := aFormSet
]

{ #category : #initialization }
ToPragmaMenuAndShortcutRegistrationItem >> initialize [

	super initialize.

	withSeparatorAfter := false
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> isWithSeparatorAfter [

	^ withSeparatorAfter
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> item [

	^ item
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> item: aSymbol [

	item := aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> keyText [
	^keyText
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> keyText: aString [
	keyText := aString
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> label [

	^ label
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> label: aString [

	label := aString
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> order [

	^ order
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> order: anInteger [

	order := anInteger
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> parent [

	^ parent
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> parent: aSymbol [

	parent := aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> platform [

	^ platform
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> platform: aSymbol [

	platform := aSymbol
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> precondition: aBlock [

	precondition := aBlock
]

{ #category : #printing }
ToPragmaMenuAndShortcutRegistrationItem >> printOn: aStream [

	super printOn: aStream. 
	item ifNotNil: [ aStream nextPutAll: '(', item ,')' ]
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> selector [

	^ selector
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> selector: aSymbol [

	selector := aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> shortcut [

	^ shortcut
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> shortcut: aSymbol [

	shortcut := aSymbol
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> shortcutName [

	^shortcutName
]

{ #category : #protocol }
ToPragmaMenuAndShortcutRegistrationItem >> shortcutName: aSymbol [

	shortcutName := aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> target [

	^ target
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> target: aSymbol [

	target := aSymbol
]

{ #category : #accessing }
ToPragmaMenuAndShortcutRegistrationItem >> with [

	^ with
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> with: aBlock [

	with := aBlock
]

{ #category : #'menu protocol' }
ToPragmaMenuAndShortcutRegistrationItem >> withSeparatorAfter [

	withSeparatorAfter := true
]
