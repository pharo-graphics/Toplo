Class {
	#name : #ToMultiSelectBarNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectBarNodeHolder >> barElement [

	^  self listElement
]

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
ToMultiSelectBarNodeHolder >> sieve [

	^  self barElement sieve
]
