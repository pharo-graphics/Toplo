Trait {
	#name : #TToWidgetWithLayers,
	#category : #'Toplo-Core'
}

{ #category : #'t - widget with layers - adding/removing' }
TToWidgetWithLayers >> addLayer: aToWidgetLayer [ 

	aToWidgetLayer attachTo: self layerReferentElement.
	self addChild: aToWidgetLayer
]

{ #category : #'t - widget with layers - accessing' }
TToWidgetWithLayers >> layerReferentElement [

	^ self explicitRequirement
]

{ #category : #'t - widget with layers - adding/removing' }
TToWidgetWithLayers >> removeLayer: aToWidgetLayer [

	aToWidgetLayer detach.
	self removeChild: aToWidgetLayer
]
