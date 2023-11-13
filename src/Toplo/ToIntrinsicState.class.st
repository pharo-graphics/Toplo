Class {
	#name : 'ToIntrinsicState',
	#superclass : 'ToElementState',
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
