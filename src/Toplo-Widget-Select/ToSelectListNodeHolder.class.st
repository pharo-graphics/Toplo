Class {
	#name : #ToSelectListNodeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'isGroup'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectListNodeHolder >> dataItem: aData [ 

	super dataItem: aData.
	self isGroup: self isUnselectable
]

{ #category : #initialization }
ToSelectListNodeHolder >> initialize [ 

	super initialize.
	isGroup := false
]

{ #category : #testing }
ToSelectListNodeHolder >> isGroup [

	^ isGroup
]

{ #category : #accessing }
ToSelectListNodeHolder >> isGroup: aBoolean [

	isGroup := aBoolean
]
