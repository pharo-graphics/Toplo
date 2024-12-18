Class {
	#name : #ToAlbumEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target',
		'textEmpty'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumEventHandler >> blurEvent: anEvent [

]

{ #category : #'event handling' }
ToAlbumEventHandler >> checkTextIn: anEditorElement [

	(textEmpty isNil or: [ anEditorElement text isEmpty ~= textEmpty ])
		ifTrue: [
		anEditorElement dispatchEvent: ToTextEmptinessChangeEvent new ].
	textEmpty := anEditorElement text isEmpty
]

{ #category : #'mouse handlers' }
ToAlbumEventHandler >> doubleClickEvent: anEvent [

	anEvent target = target ifFalse: [ ^ self ].
	anEvent currentTarget infinite dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToAlbumEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self checkTextIn: target
]

{ #category : #'event handling' }
ToAlbumEventHandler >> enablementChangedEvent: anEvent [

	target isEnabled
		ifTrue: [ target beEditable ]
		ifFalse: [
			target beReadonlyWithSelection ]
]

{ #category : #'api - accessing' }
ToAlbumEventHandler >> eventsToHandle [

	^ {
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlDoubleClickEvent.
		  BlElementAddedToSceneGraphEvent.
		  AlbTextEditedEvent.
		  AlbTextReplacedEvent.
		  ToEnablementChangedEvent.
		  ToTextEmptinessChangeEvent }
]

{ #category : #'event handling' }
ToAlbumEventHandler >> focusEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToAlbumEventHandler >> mouseDownEvent: anEvent [

	" copy the event, else the double click can't works in textfield in case of clicking outside the infinite bounds" 
	target infinite dispatchEvent: anEvent copy.
	anEvent consume
]

{ #category : #'mouse handlers' }
ToAlbumEventHandler >> mouseUpEvent: anEvent [

	anEvent target = target ifFalse: [ ^ self ].
	" copy the event, else the double click can't works in textfield in case of clicking outside the infinite bounds."
	target infinite dispatchEvent: anEvent copy
	"**** Pay attention to not consume anEvent to allow double click **** "
]

{ #category : #accessing }
ToAlbumEventHandler >> target [

	^ target
]

{ #category : #accessing }
ToAlbumEventHandler >> target: anAlbum [

	target := anAlbum
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textEditedEvent: aTextEditedEvent [

	aTextEditedEvent currentTarget edited: true.
	self checkTextIn: aTextEditedEvent currentTarget.
	aTextEditedEvent currentTarget requestTextStyle.
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target text
		ifEmpty: [ target showPlaceholder ]
		ifNotEmpty: [ target hidePlaceholder ]
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textReplacedEvent: aTextReplacedEvent [

	self checkTextIn: aTextReplacedEvent currentTarget.
	aTextReplacedEvent currentTarget requestTextStyle.
]
