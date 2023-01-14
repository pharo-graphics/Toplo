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
ToAlbumGhostTextLayer >> defaultLabel [

	^ ToLabel new
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  beMultiLine;
		  in: [ :l | l layout alignCenter ];
		  in: [ :l | l innerElement layout alignCenter ];
		  elevation: (BlRelativeElevation elevation: -1000);
		  yourself
]

{ #category : #initialization }
ToAlbumGhostTextLayer >> initialize [

	super initialize.
	self preventMeAndChildrenMouseEvents.
	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	label := self defaultLabel.
	self addChild: label
]

{ #category : #accessing }
ToAlbumGhostTextLayer >> text: aBlText [

	label text: aBlText
]
