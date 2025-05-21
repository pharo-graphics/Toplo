"
I'm a spec for a menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #ToPluggableMenuSpec,
	#superclass : #Object,
	#instVars : [
		'label',
		'model',
		'items',
		'parentMenu'
	],
	#category : #'Toplo-MenuRegistration'
}

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec class >> withModel: aModel [
	^ self new model: aModel
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> add: aString [
	^ self add: aString action: nil
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> add: aString action: aMessageSend [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	^item
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> add: aString selector: aMessageSend [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	^item
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> add: aString selector: aSelector argumentList: anArray [
	^ self add: aString action: (MessageSend receiver: model selector: aSelector arguments: anArray)
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> add: aString target: anObject selector: aSelector argumentList: anArray [
	^ self add: aString translated action: (MessageSend receiver: anObject selector: aSelector arguments: anArray)
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> addList: aList [
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

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> addMenuItem [
	| item |
	item := self newMenuItem.
	self items add: item.
	^item
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> addSeparator [
	self items isEmpty
		ifTrue: [ ^ nil ].
	self items last separator: true
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> label [
	^ label
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> label: aString [
	label := aString
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> model [
	^ model
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
ToPluggableMenuSpec >> newMenuItem [
	^ ToPluggableMenuItemSpec new
]
