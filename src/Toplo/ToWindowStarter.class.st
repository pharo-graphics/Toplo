Class {
	#name : #ToWindowStarter,
	#superclass : #Object,
	#category : #'Toplo-Core-Window'
}

{ #category : #testing }
ToWindowStarter >> isInline [

	^ false
]

{ #category : #'starting-stopping' }
ToWindowStarter >> startWindow: aWindow fromManager: aManager [

	self subclassResponsibility 
]

{ #category : #'starting-stopping' }
ToWindowStarter >> stopWindow: aWindow fromManager: aManager [

	self subclassResponsibility 
]

{ #category : #accessing }
ToWindowStarter >> windowClassFromManager: aManager [

	^ aManager popupWindowClass 
]
