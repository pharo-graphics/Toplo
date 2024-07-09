Class {
	#name : #ToMultiSelectBarNodeHolder,
	#superclass : #ToBarNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> dataAccessor [

	^ self sieve originalData
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> selectElement [

	^  self barElement selectElement
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> selecter [

	^  self selectElement selecter
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> selectionModel [

	^ self selectElement selectionModel
]

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> sieve [

	^  self barElement sieve
]
