Class {
	#name : #ToAlbumGhostTextLayer,
	#superclass : #ToWidgetLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - attaching / detaching' }
ToAlbumGhostTextLayer >> attachTo: anEditorElement from: aWidget [

	super attachTo: anEditorElement from: aWidget.
	label padding: anEditorElement padding copy.

	self checkText: anEditorElement text.
	" add/remove according to unaccepted text size"
	anEditorElement whenTextEditedDo: [ self checkText: anEditorElement text ].
	anEditorElement whenTextReplacedDo: [ self checkText: anEditorElement text ]
]

{ #category : #'api - attaching / detaching' }
ToAlbumGhostTextLayer >> checkText: aText [

	aText
		ifEmpty: [ label visibility: BlVisibility visible ]
		ifNotEmpty: [ label visibility: BlVisibility hidden ]
]

{ #category : #initialization }
ToAlbumGhostTextLayer >> initialize [

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
			         c frame horizontal alignLeft ];
		         beMultiLine;
		         alignCenter;
		         yourself.
	self addChild: label
]

{ #category : #accessing }
ToAlbumGhostTextLayer >> text: aBlText [

	label text: aBlText
]
