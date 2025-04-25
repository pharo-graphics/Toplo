Class {
	#name : #ToItemNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToItemNodeHolder >> dataItem: aDataItem [

	super dataItem: aDataItem.
	aDataItem holder: self
]

{ #category : #accessing }
ToItemNodeHolder >> initializeNode [

	self dataItem itemConstraintsDo: [ :ic |
		ic constraintItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self node flagAsDisabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self node height: 0 ] ]

]
