Class {
	#name : #ToWindowStarter,
	#superclass : #Object,
	#category : #'Toplo-Core-Window'
}

{ #category : #'private - layout' }
ToWindowStarter >> anchorElementExtentChangedEvent: anEvent fromManager: aManager [


]

{ #category : #'private - layout' }
ToWindowStarter >> anchorElementPositionChangedEvent: anEvent fromManager: aManager [


]

{ #category : #testing }
ToWindowStarter >> isForInlineWindow [

	^ false
]

{ #category : #'starting-stopping' }
ToWindowStarter >> startWindow: aWindow fromManager: aManager  onEvent: anEvent [

	self subclassResponsibility 
]

{ #category : #'starting-stopping' }
ToWindowStarter >> stopWindow: aWindow fromManager: aManager [

	self subclassResponsibility 
]
