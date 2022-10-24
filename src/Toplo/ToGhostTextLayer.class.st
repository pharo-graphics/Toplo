Class {
	#name : #ToGhostTextLayer,
	#superclass : #ToWidgetLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToGhostTextLayer >> attachTo: anEditorElement from: anAlbumClient [

	super attachTo: anEditorElement from: anAlbumClient.
	self checkText: anEditorElement text.
	" add/remove according to unaccepted text size"
	anAlbumClient announcerWhen: ToAlbumTextEdited do: [ :announce | self checkText: announce text ].
	anAlbumClient announcerWhen: ToAlbumTextReplaced do: [ :announce | self checkText: announce text ]
]

{ #category : #'api - attaching / detaching' }
ToGhostTextLayer >> checkText: aText [

	aText
		ifEmpty: [ label visibility: BlVisibility visible ]
		ifNotEmpty: [ label visibility: BlVisibility hidden ]
]

{ #category : #initialization }
ToGhostTextLayer >> initialize [

	super initialize.
	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	label := ToLabel new
		         fitContent;
		         constraintsDo: [ :c | 
			         c frame vertical alignCenter.
			         c frame horizontal alignCenter ];
		         beMultiLine;
		         alignCenter;
		         yourself.
	self addChild: label
]

{ #category : #accessing }
ToGhostTextLayer >> text: aBlText [

	label text: aBlText
]
