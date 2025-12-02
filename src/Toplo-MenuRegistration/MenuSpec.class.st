"
I'm a spec for a menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #MenuSpec,
	#superclass : #Object,
	#instVars : [
		'label',
		'model',
		'items',
		'parentMenu'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
MenuSpec class >> withModel: aModel [
	^ self new model: aModel
]

{ #category : #construction }
MenuSpec >> add: aString [
	^ self add: aString action: nil
]

{ #category : #construction }
MenuSpec >> add: aString action: aMessageSend [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	^item
]

{ #category : #construction }
MenuSpec >> add: aString selector: aMessageSend [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	^item
]

{ #category : #private }
MenuSpec >> add: aString selector: aSelector argumentList: anArray [
	^ self add: aString action: (MessageSend receiver: model selector: aSelector arguments: anArray)
]

{ #category : #private }
MenuSpec >> add: aString target: anObject selector: aSelector argumentList: anArray [
	^ self add: aString translated action: (MessageSend receiver: anObject selector: aSelector arguments: anArray)
]

{ #category : #construction }
MenuSpec >> addList: aList [
	"Add the given items to this menu, where each item is a pair (<string> <actionSelector>).  If an element of the list is simply the symobl $-, add a line to the receiver. The optional third element of each entry, if present, provides balloon help."

	aList
		do: [ :tuple |
			tuple == #-
				ifTrue: [ self addSeparator ]
				ifFalse: [
					| item |
					item := self
								add: tuple first
								target: model
								selector: tuple second
								argumentList: #().
					(tuple size > 2 and: [ tuple third isNotNil ])
						ifTrue: [ item help: tuple third ].
					(tuple size > 3 and: [ tuple fourth isNotNil ])
						ifTrue: [ item icon: (self theme iconNamed: tuple fourth) ] ] ]
]

{ #category : #construction }
MenuSpec >> addMenuItem [
	| item |
	item := self newMenuItem.
	self items add: item.
	^item
]

{ #category : #construction }
MenuSpec >> addSeparator [
	self items isEmpty
		ifTrue: [ ^ nil ].
	self items last separator: true
]

{ #category : #accessing }
MenuSpec >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
MenuSpec >> label [
	^ label
]

{ #category : #accessing }
MenuSpec >> label: aString [
	label := aString
]

{ #category : #accessing }
MenuSpec >> model [
	^ model
]

{ #category : #accessing }
MenuSpec >> model: anObject [
	model := anObject
]

{ #category : #construction }
MenuSpec >> newMenuItem [
	^ MenuItemSpec new
]
