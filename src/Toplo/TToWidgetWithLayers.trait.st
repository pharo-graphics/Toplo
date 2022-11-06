Trait {
	#name : #TToWidgetWithLayers,
	#category : #'Toplo-Core'
}

{ #category : #'api-layers' }
TToWidgetWithLayers >> addLayer: aToWidgetLayer [ 

	aToWidgetLayer attachTo: self layerReferentElement from: self viewModel.
	self addChild: aToWidgetLayer
]

{ #category : #'api-layers' }
TToWidgetWithLayers >> layerReferentElement [

		^ self explicitRequirement
]

{ #category : #'api-layers' }
TToWidgetWithLayers >> removeLayer: aToWidgetLayer [

	aToWidgetLayer detach.
	self removeChild: aToWidgetLayer
]
