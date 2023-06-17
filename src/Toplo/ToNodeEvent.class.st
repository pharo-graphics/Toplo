Class {
	#name : #ToNodeEvent,
	#superclass : #BlEvent,
	#instVars : [
		'holder',
		'event'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToNodeEvent >> event [

	^ event
]

{ #category : #accessing }
ToNodeEvent >> event: anEvent [

	event := anEvent
]

{ #category : #accessing }
ToNodeEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToNodeEvent >> holder: anHolder [

	holder := anHolder
]
