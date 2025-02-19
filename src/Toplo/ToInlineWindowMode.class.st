Class {
	#name : #ToInlineWindowMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window'
}

{ #category : #testing }
ToInlineWindowMode >> isInline [ 

	^ true
]

{ #category : #'api - displaying' }
ToInlineWindowMode >> onMeasure: anExtentMeasurementSpec element: aWindow onEvent: anEvent [


]

{ #category : #'api - displaying' }
ToInlineWindowMode >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

]

{ #category : #'window handling' }
ToInlineWindowMode >> startWindow: aWindow [

	self element addChild: aWindow.
	self element requestNewSkin
]

{ #category : #'window handling' }
ToInlineWindowMode >> stopWindow: aWindow [

	aWindow removeFromParent.
	self element requestNewSkin
]

{ #category : #accessing }
ToInlineWindowMode >> windowClass [ 

	^ manager inlineWindowClass 
]
