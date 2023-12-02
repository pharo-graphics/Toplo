Class {
	#name : 'ToInfiniteNodeSelectedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'index'
	],
	#category : 'Toplo-Widget-List-Infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'Infinite'
}

{ #category : 'accessing' }
ToInfiniteNodeSelectedEvent >> index [

	^ index
]

{ #category : 'accessing' }
ToInfiniteNodeSelectedEvent >> index: anInteger [

	index := anInteger
]
