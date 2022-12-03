Trait {
	#name : #TToWidgetWithLayers,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing layers' }
TToWidgetWithLayers >> addLayer: aToWidgetLayer [ 

	aToWidgetLayer attachTo: self layerReferentElement from: self.
	self addChild: aToWidgetLayer
]

{ #category : #'t - accessing layers' }
TToWidgetWithLayers >> layerReferentElement [

	^ self explicitRequirement
]

{ #category : #'t - accessing layers' }
TToWidgetWithLayers >> removeLayer: aToWidgetLayer [

	aToWidgetLayer detach.
	self removeChild: aToWidgetLayer
]
