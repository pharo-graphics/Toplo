Trait {
	#name : #TToWidgetWithLayers,
	#category : #'Toplo-Core'
}

{ #category : #'api-layers' }
TToWidgetWithLayers >> addLayer: aToWidgetLayer fromModel: anAlbumModel [

	aToWidgetLayer attachTo: self editorElement fromModel: anAlbumModel.
	self addChild: aToWidgetLayer
]

{ #category : #'api-layers' }
TToWidgetWithLayers >> removeLayer: aToWidgetLayer [

	aToWidgetLayer detach.
	self removeChild: aToWidgetLayer
]
