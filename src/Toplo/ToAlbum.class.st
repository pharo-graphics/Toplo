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
	editorElement ifNotNil: [ editorElement removeFromParent ].
	editorElement := anEditorElement.
	self addChild: anEditorElement
]

{ #category : #initialization }
ToAlbum >> initialize [

	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self editorElement: self defaultEditorElement.
]

{ #category : #accessing }
ToAlbum >> mode [

	^ self viewModel mode
]

{ #category : #accessing }
ToAlbum >> mode: anEditabilityMode [

	self viewModel mode: anEditabilityMode 
]

{ #category : #accessing }
ToAlbum >> text [

	^ self viewModel text
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	self viewModel text: aBlText
]

{ #category : #accessing }
ToAlbum >> viewModel [

	^ self editorElement viewModel
]

{ #category : #accessing }
ToAlbum >> viewModel: aViewModel [

	self editorElement viewModel: aViewModel
]

{ #category : #'client - protocol' }
ToAlbum >> whenActionRequired: anActionRequiredAnnouncement [

	anActionRequiredAnnouncement value: self
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
ToAlbum >> withEditsFeedbackFromModel: anAlbumModel [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	self addLayer: editsFeedbackLayer fromModel: anAlbumModel 
]

{ #category : #layers }
ToAlbum >> withGhostText: aText fromModel: anAlbumModel [

	ghostTextLayer ifNotNil: [ ^ self ].
	ghostTextLayer := ToGhostTextLayer new text: aText.
	self addLayer: ghostTextLayer fromModel: anAlbumModel 
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
