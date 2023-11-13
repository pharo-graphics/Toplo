Class {
	#name : 'ToPersistentState',
	#superclass : 'ToElementState',
	#instVars : [
		'rawState'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToPersistentState >> rawState [

	^ rawState
]

{ #category : 'accessing' }
ToPersistentState >> rawState: anObject [

	rawState := anObject
]
