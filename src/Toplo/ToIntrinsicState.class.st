Class {
	#name : 'ToIntrinsicState',
	#superclass : 'ToImplicitState',
	#instVars : [
		'rawState'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToIntrinsicState >> rawState [

	^ rawState
]

{ #category : 'accessing' }
ToIntrinsicState >> rawState: anObject [

	rawState := anObject
]
