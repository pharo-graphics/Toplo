Class {
	#name : #ToMultiSelectCompositeInnerNodeHolder,
	#superclass : #ToSelectAbstractInnerNodeHolder,
	#instVars : [
		'holders'
	],
	#category : #'Toplo-Widget-Select-InnerNode'
}

{ #category : #accessing }
ToMultiSelectCompositeInnerNodeHolder >> holders [

	^ holders
]

{ #category : #accessing }
ToMultiSelectCompositeInnerNodeHolder >> holders: anHolderArray [

	holders := anHolderArray
]

{ #category : #accessing }
ToMultiSelectCompositeInnerNodeHolder >> nodesCount [ 

	| count |
	count := 0.
	self holders do: [ :holder |
		count := count + holder nodesCount ].
	^ count
]
