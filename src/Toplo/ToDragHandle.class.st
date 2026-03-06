Class {
	#name : #ToDragHandle,
	#superclass : #ToHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #'mouse processing' }
ToDragHandle >> dragBy: deltaFromInitialPosition [

	gripTarget position: initialPosition + deltaFromInitialPosition
]

{ #category : #accessing }
ToDragHandle >> handleCursor [

	^ Cursor webLink 
]
