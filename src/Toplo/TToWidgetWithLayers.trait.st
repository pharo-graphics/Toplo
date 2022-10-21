Trait {
	#name : #TToWidgetWithLayers,
	#category : #'Toplo-Core'
}

{ #category : #'api-layers' }
TToWidgetWithLayers >> addLayer: aToWidgetLayer from: anAlbumClient [

	aToWidgetLayer attachTo: self layerReferentElement from: anAlbumClient.
	self addChild: aToWidgetLayer
]

{ #category : #'as yet unclassified' }
TToWidgetWithLayers >> layerReferentElement [

		^ self explicitRequirement
]

{ #category : #'api-layers' }
TToWidgetWithLayers >> removeLayer: aToWidgetLayer [

	aToWidgetLayer detach.
	self removeChild: aToWidgetLayer
]
