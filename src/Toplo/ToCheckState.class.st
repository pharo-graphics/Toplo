Class {
	#name : 'ToCheckState',
	#superclass : 'ToIntrinsicState',
	#instVars : [
		'checked'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToCheckState >> checked [

	^ checked
]

{ #category : 'accessing' }
ToCheckState >> checked: aBooleanOrIndeterminate [

	checked := aBooleanOrIndeterminate
]

{ #category : 'accessing' }
ToCheckState >> lookEventClass [

	^ self checked isSymbol
		  ifTrue: [ ToIndeterminateLookEvent ]
		  ifFalse: [
			  self checked
				  ifTrue: [ ToCheckedLookEvent ]
				  ifFalse: [ ToUncheckedLookEvent ] ]
]
