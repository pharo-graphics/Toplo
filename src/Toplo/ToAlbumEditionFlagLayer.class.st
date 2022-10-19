Class {
	#name : #ToAlbumEditionFlagLayer,
	#superclass : #ToAlbumLayer,
	#instVars : [
		'editionFlag'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'api - attaching / detaching' }
ToAlbumEditionFlagLayer >> attachTo: anEditorElement fromModel: anAlbumModel [

	super attachTo: anEditorElement fromModel: anAlbumModel.
	anAlbumModel whenEditStateChangedDo: [ :state | 
		state
			ifTrue: [ self showEditionFlag ]
			ifFalse: [ self hideEditionFlag ] ]
]

{ #category : #'api - attaching / detaching' }
ToAlbumEditionFlagLayer >> detach [

	referenceElement viewModel unsubscribe: self.
	super detach
]

{ #category : #'edition-flag' }
ToAlbumEditionFlagLayer >> hideEditionFlag [

	editionFlag ifNil: [ ^ self ].
	self removeChild: editionFlag.
	editionFlag := nil
]

{ #category : #initialization }
ToAlbumEditionFlagLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self background: Color transparent
]

{ #category : #'edition-flag' }
ToAlbumEditionFlagLayer >> newEditionFlag [

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
ToAlbumEditionFlagLayer >> showEditionFlag [

	editionFlag ifNotNil: [ ^ self ].
	editionFlag := self newEditionFlag.
	self addChild: editionFlag 
]
