Class {
	#name : #ToInlineWindowMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToInlineWindowMode >> arrangeWindow: aWindow onEvent: anEvent [

	
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
