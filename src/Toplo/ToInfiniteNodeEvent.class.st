Class {
	#name : #ToInfiniteNodeEvent,
	#superclass : #BlEvent,
	#instVars : [
		'holder'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToInfiniteNodeEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToInfiniteNodeEvent >> holder: aNodeHolder [

	holder := aNodeHolder
]
