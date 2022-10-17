Class {
	#name : #ToAlbum,
	#superclass : #ToWidget,
	#traits : 'TOBlLayoutResizable',
	#classTraits : 'TOBlLayoutResizable classTrait',
	#instVars : [
		'editorElement',
		'editionFlagLayer',
		'coverLayer'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'instance creation' }
ToAlbum class >> forPharoCode [

	^ self new forPharoCode
]

{ #category : #layers }
ToAlbum >> addLayer: anAlbumLayer [

	anAlbumLayer attachTo: self editorElement.
	self addChild: anAlbumLayer
]

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new dresser: AlbTextAreaDresser new
]

{ #category : #accessing }
ToAlbum >> editorElement [

	^ editorElement
]

{ #category : #accessing }
ToAlbum >> editorElement: anEditorElement [
	editorElement ifNotNil: [ editorElement removeFromParent ].
	editorElement := anEditorElement.
	self addChild: anEditorElement
]

{ #category : #initialization }
ToAlbum >> forPharoCode [

	self viewModel: AlbEditorPharoCodeModel new.
	self withEditionFlagLayer.
	self withCoverLayer 
]

{ #category : #initialization }
ToAlbum >> initialize [

	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self editorElement: self defaultEditorElement.
]

{ #category : #layers }
ToAlbum >> removeLayer: anAlbumLayer [

	anAlbumLayer detach.
	self removeChild: anAlbumLayer
]

{ #category : #'text - accessing' }
ToAlbum >> text [

	^ self editorElement viewModel text
]

{ #category : #'text - accessing' }
ToAlbum >> text: aBlText [

	self editorElement viewModel text: aBlText
]

{ #category : #accessing }
ToAlbum >> viewModel [

	^ self editorElement viewModel
]

{ #category : #accessing }
ToAlbum >> viewModel: aViewModel [

	self editorElement viewModel: aViewModel
]

{ #category : #layers }
ToAlbum >> withCoverLayer [

	coverLayer ifNotNil: [ ^ self ].
	coverLayer := ToAlbumCoverLayer new.
	self addLayer: coverLayer
]

{ #category : #layers }
ToAlbum >> withEditionFlagLayer [

	editionFlagLayer ifNotNil: [ ^ self ].
	editionFlagLayer := ToAlbumEditionFlagLayer new.
	self addLayer: editionFlagLayer
]

{ #category : #initialization }
ToAlbum >> withLineNumbers [

	self editorElement withLineNumbers
]

{ #category : #layers }
ToAlbum >> withoutCoverLayer [

	coverLayer ifNil: [ ^ self ].
	self removeLayer: coverLayer.
	coverLayer := nil
]

{ #category : #layers }
ToAlbum >> withoutEditionFlagLayer [

	editionFlagLayer ifNil: [ ^ self ].
	self removeLayer: editionFlagLayer.
	editionFlagLayer := nil
]

{ #category : #initialization }
ToAlbum >> withoutLineNumbers [

	self editorElement withoutLineNumbers
]
