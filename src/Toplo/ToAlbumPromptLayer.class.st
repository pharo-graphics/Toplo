Class {
	#name : #ToAlbumPromptLayer,
	#superclass : #ToWidgetLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - attaching / detaching' }
ToAlbumPromptLayer >> attachTo: anEditorElement [ 

	super attachTo: anEditorElement.
	self checkText: anEditorElement text.
	" add/remove according to unaccepted text size"
	anEditorElement whenTextEditedDo: [ self checkText: anEditorElement text ].
	anEditorElement whenTextReplacedDo: [ self checkText: anEditorElement text ]
]

{ #category : #'api - attaching / detaching' }
ToAlbumPromptLayer >> checkText: aText [

	aText
		ifEmpty: [ label visibility: BlVisibility visible ]
		ifNotEmpty: [ label visibility: BlVisibility hidden ]
]

{ #category : #initialization }
ToAlbumPromptLayer >> defaultLabel [

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
ToAlbumPromptLayer >> initialize [

	super initialize.
	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	label := self defaultLabel.
	self addChild: label.
	self preventMeAndChildrenMouseEvents.

]

{ #category : #accessing }
ToAlbumPromptLayer >> text: aBlText [

	label text: aBlText
]
