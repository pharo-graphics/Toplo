Class {
	#name : #ToInlineWindowMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToInlineWindowMode >> arrangeWindow: aWindow onEvent: anEvent [

	| w |
	w := 0.
	manager element parentMenuDo: [ :pm |
		pm menuWindow collectedNodesDo: [ :node |
			w := w max: node width ] ].
	manager element parentMenuDo: [ :pm |
		pm menuWindow collectedNodesDo: [ :node | node width: w ] ]
]

{ #category : #testing }
ToInlineWindowMode >> isInline [ 

	^ true
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
