Class {
	#name : #ToAlbumGhostTextLayer,
	#superclass : #ToAlbumLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - attaching / detaching' }
ToAlbumGhostTextLayer >> attachTo: anEditorElement fromModel: anAlbumModel [

	super attachTo: anEditorElement fromModel: anAlbumModel.
	
	" add/remove according to unaccepted text size"
	anAlbumModel when: ToAlbumTextModified do: [ :announce | 
		announce text ifEmpty: [ label visibility: BlVisibility visible ] ifNotEmpty: [ BlVisibility gone ] ]
]

{ #category : #initialization }
ToAlbumGhostTextLayer >> initialize [

	| e |
	super initialize.
	"self layout: BlFrameLayout new."
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	label := ToLabel new
		         constraintsDo: [ :c | 
			         c frame vertical alignTop.
			         c frame horizontal alignRight ];
		         beMultiLine;
		         yourself.
	label := (BlElement new
		      background: Color red;
		      border: (BlBorder paint: Color lightGray width: 4))
		     size: 100 @ 100;
		     constraintsDo: [ :c | 
			     c frame horizontal alignRight.
			     c frame vertical alignTop ].
	self addChild: label
]

{ #category : #accessing }
ToAlbumGhostTextLayer >> text: aBlText [

	"label text: aBlText"
]
