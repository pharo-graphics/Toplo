Class {
	#name : #ToInfiniteNodeSelectedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'index'
	],
	#category : 'Toplo-Widget-List-infinite'
}

{ #category : #accessing }
ToInfiniteNodeSelectedEvent >> index [

	^ index
]

{ #category : #accessing }
ToInfiniteNodeSelectedEvent >> index: anInteger [

	index := anInteger
]
