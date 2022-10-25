Class {
	#name : #ToAlbum,
	#superclass : #ToWidget,
	#traits : 'TOBlLayoutResizable + TToWidgetWithLayers',
	#classTraits : 'TOBlLayoutResizable classTrait + TToWidgetWithLayers classTrait',
	#instVars : [
		'editsFeedbackLayer',
		'ghostTextLayer',
		'innerElement'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new
]

{ #category : #initialization }
ToAlbum >> initialize [

	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	
	self innerElement: self defaultEditorElement
]

{ #category : #accessing }
ToAlbum >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToAlbum >> innerElement: anEditorElement [
	innerElement ifNotNil: [ 
		innerElement removeFromParent ].
	innerElement := anEditorElement.
	self addChild: anEditorElement
]

{ #category : #'api-layers' }
ToAlbum >> layerReferentElement [

		^ self innerElement
]

{ #category : #accessing }
ToAlbum >> mode [

	^ self innerElement mode
]

{ #category : #accessing }
ToAlbum >> mode: anEditabilityMode [

	self innerElement mode: anEditabilityMode 
]

{ #category : #'client - protocol' }
ToAlbum >> onModeChangedDo: aBlock [

	innerElement onModeChangedDo: aBlock
]

{ #category : #'client - protocol' }
ToAlbum >> onTextEditedDo: aBlock [

	self innerElement whenAnnouncement: AlbTextEdited do: aBlock
]

{ #category : #'client - protocol' }
ToAlbum >> onTextReplacedDo: aBlock [

	innerElement 
		whenTextReplacedDo: [ :announcement | aBlock cull: announcement text cull: announcement ]
]

{ #category : #accessing }
ToAlbum >> text [

	^ self innerElement text
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	self innerElement text: aBlText
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

	self innerElement withLineNumbers
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

	self innerElement withoutLineNumbers
]
