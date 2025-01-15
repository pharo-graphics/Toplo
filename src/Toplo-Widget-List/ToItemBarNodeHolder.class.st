Class {
	#name : #ToItemBarNodeHolder,
	#superclass : #ToBarNodeHolder,
	#instVars : [
		'itemConstraints'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #accessing }
ToItemBarNodeHolder >> dataItem: aDataItem [

	| infiniteConstraints |
	super dataItem: aDataItem.
	itemConstraints := aDataItem ensuredItemConstraints.
	infiniteConstraints := aDataItem constraints infinite.
	infiniteConstraints holder: self
]

{ #category : #accessing }
ToItemBarNodeHolder >> initializeNode [

	self dataItem itemConstraintsDo: [ :ic |
		ic constraintItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self node height: 0 ] ]
]
