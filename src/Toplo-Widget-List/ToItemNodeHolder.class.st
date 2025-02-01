Class {
	#name : #ToItemNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToItemNodeHolder >> dataItem: aDataItem [

	| infiniteConstraints |
	super dataItem: aDataItem.
	infiniteConstraints := aDataItem constraints infinite.
	infiniteConstraints holder: self
]

{ #category : #accessing }
ToItemNodeHolder >> initializeNode [

	self dataItem itemConstraintsDo: [ :ic |
		ic constraintItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self node flagAsDisabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self node height: 0 ] ]

]
