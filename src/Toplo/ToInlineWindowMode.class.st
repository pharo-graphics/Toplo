Class {
	#name : #ToInlineWindowMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToInlineWindowMode >> arrangeWindowOnEvent: anEvent [

]

{ #category : #testing }
ToInlineWindowMode >> isInline [ 

	^ true
]

{ #category : #'window handling' }
ToInlineWindowMode >> startWindow: aWindow [

	manager element addChild: aWindow.
	manager element requestNewSkin
]

{ #category : #'window handling' }
ToInlineWindowMode >> stopWindow: aWindow [

	aWindow removeFromParent.
	manager element requestNewSkin
]

{ #category : #accessing }
ToInlineWindowMode >> windowClass [ 

	^ manager inlineWindowClass 
]
