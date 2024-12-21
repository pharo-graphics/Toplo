Class {
	#name : #ToActionPlacement,
	#superclass : #ToWindowPlacement,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToActionPlacement >> action: aValuable [
	" aValuable take thewindow, the window manager element, the event and the anchor root as arguments "

	action := aValuable
]

{ #category : #api }
ToActionPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	action value: aManager value: anEvent 
]
