Class {
	#name : #ToGhostTextLayer,
	#superclass : #ToWidgetLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToGhostTextLayer >> attachTo: anEditorElement fromModel: anAlbumModel [

	super attachTo: anEditorElement fromModel: anAlbumModel.

	" add/remove according to unaccepted text size"
	anAlbumModel when: ToAlbumTextModified do: [ :announce | 
		announce text
			ifEmpty: [ label visibility: BlVisibility visible ]
			ifNotEmpty: [ label visibility: BlVisibility hidden ] ]
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
