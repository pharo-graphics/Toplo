Class {
	#name : #ToItemBarNodeHolder,
	#superclass : #ToBarNodeHolder,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #accessing }
ToItemBarNodeHolder >> initializeNode [

	self dataItem storedConstraintsDo: [ :pd |
		pd constraintItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self node height: 0 ] ]
]
