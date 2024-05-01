Class {
	#name : #ToCompositeElementBarNodeHolder,
	#superclass : #ToElementBarNodeHolder,
	#instVars : [
		'holders'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToCompositeElementBarNodeHolder >> holders [

	^ holders
]

{ #category : #accessing }
ToCompositeElementBarNodeHolder >> holders: anHolderArray [

	holders := anHolderArray
]

{ #category : #accessing }
ToCompositeElementBarNodeHolder >> nodesCount [ 

	| count |
	count := 0.
	self holders do: [ :holder |
		count := count + holder nodesCount ].
	^ count
]
