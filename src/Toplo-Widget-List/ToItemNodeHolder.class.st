Class {
	#name : #ToItemNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-Core-Item'
}

{ #category : #accessing }
ToItemNodeHolder >> dataItem: aDataItem [

	super dataItem: aDataItem.
	aDataItem holder: self
]

{ #category : #accessing }
ToItemNodeHolder >> initializeNodeSelections [

	notifiedSelected := false.
	self dataItem itemConstraintsDo: [ :ic |
		ic constraintItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self node flagAsDisabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self nodeContainer height: 0 ] ]

]

{ #category : #removing }
ToItemNodeHolder >> removeNodeFromList [

	" redefined to use the item bar API "
	self listElement removeItem: self node item
]
