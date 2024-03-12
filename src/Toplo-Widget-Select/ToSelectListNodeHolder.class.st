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

	self isGroup: self isUnselectable.
	
	" must send to super ** after ** local initialization is done "
	super dataItem: aData.

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
