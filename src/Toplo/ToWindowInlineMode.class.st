Class {
	#name : #ToWindowInlineMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToWindowInlineMode >> arrangeWindowOnEvent: anEvent [

]

{ #category : #testing }
ToWindowInlineMode >> isInline [ 

	^ true
]

{ #category : #'window handling' }
ToWindowInlineMode >> showWindow: aWindow [

	manager element addChild: aWindow
]

{ #category : #accessing }
ToWindowInlineMode >> windowClass [ 

	^ manager inlineWindowClass 
]
