Class {
	#name : #ToStandardWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Core-Window'
}

{ #category : #'starting-stopping' }
ToStandardWindowStarter >> startWindow: aWindow fromManager: aManager [

	aManager anchorRoot addChild: aWindow
]

{ #category : #'starting-stopping' }
ToStandardWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent
]
