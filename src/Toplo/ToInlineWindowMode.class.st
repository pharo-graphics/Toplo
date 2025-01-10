Class {
	#name : #ToInlineWindowMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToInlineWindowMode >> arrangeWindow: aWindow onEvent: anEvent [

	| w |
	w := 0.
	aWindow popupWindowParentMenuDo: [ :pm |
		pm collectedNodesDo: [ :node |
			w := w max: node width ] ].
	aWindow popupWindowParentMenuDo: [ :pm |
		pm collectedNodesDo: [ :node | node width: w ] ]
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
