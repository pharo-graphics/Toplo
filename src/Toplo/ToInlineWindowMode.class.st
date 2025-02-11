Class {
	#name : #ToInlineWindowMode,
	#superclass : #ToWindowMode,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #testing }
ToInlineWindowMode >> isInline [ 

	^ true
]

{ #category : #'api - displaying' }
ToInlineWindowMode >> measureWindow: aWindow onEvent: anEvent [


]

{ #category : #'api - displaying' }
ToInlineWindowMode >> positionWindow: aWindow onEvent: anEvent [

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
