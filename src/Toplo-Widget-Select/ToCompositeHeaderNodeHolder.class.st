Class {
	#name : #ToCompositeHeaderNodeHolder,
	#superclass : #ToSelectHeaderNodeHolder,
	#instVars : [
		'holders'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToCompositeHeaderNodeHolder >> holders [

	^ holders
]

{ #category : #accessing }
ToCompositeHeaderNodeHolder >> holders: anHolderArray [

	holders := anHolderArray
]

{ #category : #accessing }
ToCompositeHeaderNodeHolder >> nodesCount [ 

	| count |
	count := 0.
	self holders do: [ :holder |
		count := count + holder nodesCount ].
	^ count
]
