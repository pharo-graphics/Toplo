Class {
	#name : #ToAlbum,
	#superclass : #ToWidget,
	#traits : 'TOBlLayoutResizable + TToWidgetWithLayers',
	#classTraits : 'TOBlLayoutResizable classTrait + TToWidgetWithLayers classTrait',
	#instVars : [
		'editorElement',
		'editsFeedbackLayer',
		'ghostTextLayer'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new
		  dresser: AlbTextAreaDresser new;
		  yourself
]

{ #category : #accessing }
ToAlbum >> editorElement [

	^ editorElement
]

{ #category : #accessing }
ToAlbum >> editorElement: anEditorElement [
	editorElement ifNotNil: [ 
		editorElement removeFromParent ].
	editorElement := anEditorElement.
	self addChild: anEditorElement
]

{ #category : #initialization }
ToAlbum >> initialize [

	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self editorElement: self defaultEditorElement
]

{ #category : #'api-layers' }
ToAlbum >> layerReferentElement [

		^ self editorElement
]

{ #category : #accessing }
ToAlbum >> mode [

	^ self editorElement mode
]

{ #category : #accessing }
ToAlbum >> mode: anEditabilityMode [

	self editorElement mode: anEditabilityMode 
]

{ #category : #private }
ToAlbum >> resetEditorHistory [

	self editorElement editor history setUpToStart 
]

{ #category : #accessing }
ToAlbum >> text [

	^ self editorElement text
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	self editorElement text: aBlText
]

{ #category : #'client - protocol' }
ToAlbum >> whenModeChangedDo: aBlock [

	editorElement viewModel whenModeChangedDo: aBlock
]

{ #category : #'client - protocol' }
ToAlbum >> whenTextChangedDo: aBlock [

	editorElement viewModel whenTextChangedDo: aBlock
]

{ #category : #layers }
ToAlbum >> withEditsFeedbackFrom: anAlbumClient [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	self addLayer: editsFeedbackLayer from: anAlbumClient 
]

{ #category : #layers }
ToAlbum >> withGhostText: aText from: anAlbumClient [

	ghostTextLayer ifNotNil: [ ^ self ].
	ghostTextLayer := ToGhostTextLayer new text: aText.
	self addLayer: ghostTextLayer from: anAlbumClient 
]

{ #category : #initialization }
ToAlbum >> withLineNumbers [

	self editorElement withLineNumbers
]

{ #category : #layers }
ToAlbum >> withoutEditsFeedback [

	editsFeedbackLayer ifNil: [ ^ self ].
	self removeLayer: editsFeedbackLayer.
	editsFeedbackLayer := nil
]

{ #category : #layers }
ToAlbum >> withoutGhostText [ 

	ghostTextLayer ifNil: [ ^ self ].
	self removeLayer: ghostTextLayer.
	ghostTextLayer := nil
]

{ #category : #initialization }
ToAlbum >> withoutLineNumbers [

	self editorElement withoutLineNumbers
]
