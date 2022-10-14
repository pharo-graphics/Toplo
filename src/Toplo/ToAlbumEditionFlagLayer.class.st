Class {
	#name : #ToAlbumEditionFlagLayer,
	#superclass : #ToAlbumLayer,
	#instVars : [
		'editorListener',
		'editionFlag'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'api - attaching / detaching' }
ToAlbumEditionFlagLayer >> attachTo: anEditorElement [

	editorListener ifNotNil: [ ^ self ].
	super attachTo: anEditorElement.
	editorListener := self editorListener.
	anEditorElement editor addEventHandler: editorListener.

]

{ #category : #'api - attaching / detaching' }
ToAlbumEditionFlagLayer >> detach [

	referenceElement removeEventHandler: editorListener.
	editorListener := nil.
	super detach
]

{ #category : #'edition-flag' }
ToAlbumEditionFlagLayer >> editionFlag [

	| flag |
	flag := BlElement new
		        background: ((BlLinearGradientPaint direction: 1 @ 1)
				         start: 25 @ 0;
				         stops: { 
						         (0 -> Color orange).
						         (0.35 -> (Color orange alpha: 0.4)).
						         (0.45 -> (Color orange alpha: 0.1)).
						         (0.50 -> (Color orange alpha: 0.0)).
						         (1 -> Color transparent) });
		        size: 25 @ 25.
	flag constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	^ flag
]

{ #category : #'edition-flag' }
ToAlbumEditionFlagLayer >> editorListener [

	^ BlEventHandler
		  on: AlbTextEditorModifiedEvent
		  do: [ :anEvent | self showEditionFlag ]
]

{ #category : #'edition-flag' }
ToAlbumEditionFlagLayer >> hideEditionFlag [

	editionFlag ifNil: [ ^ self ].
	self removeChild: self editionFlag
]

{ #category : #initialization }
ToAlbumEditionFlagLayer >> initialize [ 
	super initialize.
	self layout: BlFrameLayout new.
	self background: Color transparent.
	
]

{ #category : #'edition-flag' }
ToAlbumEditionFlagLayer >> showEditionFlag [

	editionFlag ifNotNil: [ ^ self ].
	editionFlag := self editionFlag.
	self addChild: self editionFlag
]
