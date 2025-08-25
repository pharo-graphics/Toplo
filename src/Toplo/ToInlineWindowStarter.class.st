Class {
	#name : #ToInlineWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Core-Window'
}

{ #category : #testing }
ToInlineWindowStarter >> isForInlineWindow [

	^ true
]

{ #category : #'starting-stopping' }
ToInlineWindowStarter >> startWindow: aWindow fromManager: aManager [

	aManager anchorElement addChild: aWindow.
	aManager anchorElement requestNewSkin
]

{ #category : #'starting-stopping' }
ToInlineWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent.
	aManager anchorElement requestNewSkin
]

{ #category : #accessing }
ToInlineWindowStarter >> windowClassFromManager: aManager [

	^ aManager inlineWindowClass 
]
