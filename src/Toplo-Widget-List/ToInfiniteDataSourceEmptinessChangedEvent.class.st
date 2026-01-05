Class {
	#name : #ToInfiniteDataSourceEmptinessChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'isEmpty'
	],
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #accessing }
ToInfiniteDataSourceEmptinessChangedEvent >> isEmpty [

	^ isEmpty
]

{ #category : #accessing }
ToInfiniteDataSourceEmptinessChangedEvent >> isEmpty: aBoolean [

	isEmpty := aBoolean
]

{ #category : #sending }
ToInfiniteDataSourceEmptinessChangedEvent >> sendTo: anObject [ 

	anObject infiniteDataSourceEmptinessChangedEvent: self

	
]
