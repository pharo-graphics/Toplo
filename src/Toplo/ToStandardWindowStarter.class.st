Class {
	#name : #ToStandardWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Core-Window'
}

{ #category : #'starting-stopping' }
ToStandardWindowStarter >> startWindow: aWindow fromManager: aManager [

	aManager anchorRoot addChild: aWindow.
	"aManager anchorElement requestNewSkin"
]

{ #category : #'starting-stopping' }
ToStandardWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent.
	"aManager anchorElement requestNewSkin"
]
