Class {
	#name : 'ToTab',
	#superclass : 'Object',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'data',
		'preserveOnSelect',
		'closable',
		'pageBuilder',
		'buttonBuilder'
	],
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'accessing' }
ToTab >> buttonBuilder [

	^ buttonBuilder
]

{ #category : 'accessing' }
ToTab >> buttonBuilder: aValuable2Args [

	buttonBuilder := aValuable2Args
]

{ #category : 'accessing' }
ToTab >> closable: aBoolean [

	closable := aBoolean.
	aBoolean
		ifTrue: [
			| but |
			but := ToButton new.
			but defaultSkin: ToTabInnerCloseButtonSkin new.
			but icon: (ToImage inner: (Smalltalk ui icons iconNamed: #windowClose)).
			but constraintsDo: [ :c | c linear vertical alignCenter ].
			but when: BlClickEvent do: [ :event | event currentTarget removeFromParent ].
			but id: #innerCloseButton. ]
		ifFalse: [
			self removeChildNamed: #innerCloseButton ]
]

{ #category : 'accessing' }
ToTab >> data [

	^ data
]

{ #category : 'accessing' }
ToTab >> data: anObject [

	data := anObject
]

{ #category : 'initialization' }
ToTab >> defaultButtonBuilder [

	^ [ :node :holder |
	  | but |
	  but := ToLabeledIcon new labelText: self data asString.
	  node addChild: but.
	  node fitContent ]
]

{ #category : 'initialization' }
ToTab >> initialize [

	super initialize.
	closable := false.
	pageBuilder := [ :arg1 :arg2 |  ].
	buttonBuilder := self defaultButtonBuilder
]

{ #category : 'testing' }
ToTab >> isClosable [

	^ closable
]

{ #category : 'accessing' }
ToTab >> pageBuilder [

	^ pageBuilder
]

{ #category : 'accessing' }
ToTab >> pageBuilder: aValuable2Args [
	"Establish what is my body. When a tab is selected in a notebook, it will send `#value:value:` to this factory, 
	with the page pane and the notebook as arguments"

	pageBuilder := aValuable2Args
]

{ #category : 'accessing' }
ToTab >> preserveOnSelect [

	^ preserveOnSelect
]

{ #category : 'accessing' }
ToTab >> preserveOnSelect: aBoolean [

	preserveOnSelect := aBoolean
]
