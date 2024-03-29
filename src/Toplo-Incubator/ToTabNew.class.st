Class {
	#name : #ToTabNew,
	#superclass : #Object,
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'data',
		'preserveOnSelect',
		'closable',
		'pageBuilder',
		'buttonBuilder'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #accessing }
ToTabNew >> buttonBuilder [

	^ buttonBuilder
]

{ #category : #accessing }
ToTabNew >> buttonBuilder: aValuable2Args [

	buttonBuilder := aValuable2Args
]

{ #category : #accessing }
ToTabNew >> closable: aBoolean [

	closable := aBoolean.
	aBoolean
		ifTrue: [
			| but |
			but := ToButton new.
			but defaultRawSkin: ToTabInnerCloseButtonSkin new.
			but icon: (ToImage inner: (Smalltalk ui icons iconNamed: #windowClose)).
			but constraintsDo: [ :c | c linear vertical alignCenter ].
			but when: BlClickEvent do: [ :event | event currentTarget removeFromParent ].
			but id: #innerCloseButton. ]
		ifFalse: [
			self removeChildNamed: #innerCloseButton ]
]

{ #category : #accessing }
ToTabNew >> data [

	^ data
]

{ #category : #accessing }
ToTabNew >> data: anObject [

	data := anObject
]

{ #category : #initialization }
ToTabNew >> defaultButtonBuilder [

	^ [ :node :holder |
	  | but |
	  but := ToLabeledIcon new labelText: self data asString.
	  node addChild: but.
	  node fitContent ]
]

{ #category : #initialization }
ToTabNew >> initialize [

	super initialize.
	closable := false.
	pageBuilder := [ :arg1 :arg2 |  ].
	buttonBuilder := self defaultButtonBuilder
]

{ #category : #testing }
ToTabNew >> isClosable [

	^ closable
]

{ #category : #accessing }
ToTabNew >> pageBuilder [

	^ pageBuilder
]

{ #category : #accessing }
ToTabNew >> pageBuilder: aValuable2Args [
	"Establish what is my body. When a tab is selected in a notebook, it will send `#value:value:` to this factory, 
	with the page pane and the notebook as arguments"

	pageBuilder := aValuable2Args
]

{ #category : #accessing }
ToTabNew >> preserveOnSelect [

	^ preserveOnSelect
]

{ #category : #accessing }
ToTabNew >> preserveOnSelect: aBoolean [

	preserveOnSelect := aBoolean
]
