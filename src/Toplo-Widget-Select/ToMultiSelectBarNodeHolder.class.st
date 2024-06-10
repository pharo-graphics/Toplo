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
ToMultiSelectBarNodeHolder >> fakeDataItem [

	^  self selectElement nodeManager fakeDataItem
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
ToMultiSelectBarNodeHolder >> sieve [

	^  self barElement sieve
]
