Class {
	#name : 'ToInfiniteNodeSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'index'
	],
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'accessing' }
ToInfiniteNodeSelectedEvent >> index [

	^ index
]

{ #category : 'accessing' }
ToInfiniteNodeSelectedEvent >> index: anInteger [

	index := anInteger
]
