Class {
	#name : #ToEnablementState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'enabled'
	],
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToEnablementState >> enabled [

	^ enabled
]

{ #category : #accessing }
ToEnablementState >> enabled: aBoolean [

	enabled := aBoolean
]

{ #category : #accessing }
ToEnablementState >> lookEventClass [

	^ self enabled
		  ifTrue: [ ToEnabledLookEvent ]
		  ifFalse: [ ToDisabledLookEvent ]
]
