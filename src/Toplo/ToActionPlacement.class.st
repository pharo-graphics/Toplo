Class {
	#name : #ToActionPlacement,
	#superclass : #ToWindowPlacement,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #accessing }
ToActionPlacement >> action: aValuable [
	" aValuable takes the window and the event as arguments "

	action := aValuable
]

{ #category : #api }
ToActionPlacement >> positionWindow: aWindow onEvent: anEvent [

	action value: aWindow value: anEvent 
]
