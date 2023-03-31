Class {
	#name : #ToAlbumPlaceholder,
	#superclass : #ToWidgetLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - attaching / detaching' }
ToAlbumPlaceholder >> attachTo: anEditorElement [ 

	super attachTo: anEditorElement.
	self checkText: anEditorElement text.
	" add/remove according to unaccepted text size"
	anEditorElement whenTextEditedDo: [ self checkText: anEditorElement text ].
	anEditorElement whenTextReplacedDo: [ self checkText: anEditorElement text ]
]

{ #category : #'api - attaching / detaching' }
ToAlbumPlaceholder >> checkText: aText [

	aText
		ifEmpty: [ label visibility: BlVisibility visible ]
		ifNotEmpty: [ label visibility: BlVisibility hidden ]
]

{ #category : #initialization }
ToAlbumPlaceholder >> defaultLabel [

	^ ToLabel new
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  beMultiLine;
		  in: [ :l | l layout alignCenter ];
		  in: [ :l | l innerElement layout alignCenter ];
		  yourself
]

{ #category : #initialization }
ToAlbumPlaceholder >> initialize [

	super initialize.
	self
		layout: BlFrameLayout new.
	label := self defaultLabel.
	self addChild: label.
	self preventMeAndChildrenMouseEvents.

]

{ #category : #accessing }
ToAlbumPlaceholder >> text: aBlText [

	label text: aBlText
]
