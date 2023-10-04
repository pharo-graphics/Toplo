Trait {
	#name : #TToElementWithLayers,
	#category : #'Toplo-Core'
}

{ #category : #'t - widget with layers - adding/removing' }
TToElementWithLayers >> addLayer: aToWidgetLayer [ 

	aToWidgetLayer attachTo: self layerReferentElement.
	self addChild: aToWidgetLayer
]

{ #category : #'t - widget with layers - accessing' }
TToElementWithLayers >> layerReferentElement [

	^ self explicitRequirement
]

{ #category : #'t - widget with layers - adding/removing' }
TToElementWithLayers >> removeLayer: aToWidgetLayer [

	aToWidgetLayer detach.
	self removeChild: aToWidgetLayer
]
