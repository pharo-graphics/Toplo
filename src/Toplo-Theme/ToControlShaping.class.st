Class {
	#name : 'ToControlShaping',
	#superclass : 'Object',
	#instVars : [
		'sizing'
	],
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'hook' }
ToControlShaping >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : 'accessing' }
ToControlShaping >> sizing [

	^ sizing
]

{ #category : 'accessing' }
ToControlShaping >> sizing: anObject [

	sizing := anObject
]
