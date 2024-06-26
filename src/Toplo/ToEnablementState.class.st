Class {
	#name : #ToEnablementState,
	#superclass : #ToSkinManagementState,
	#instVars : [
		'enabled'
	],
	#category : #'Toplo-Core-States'
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
ToEnablementState >> skinEventClass [

	^ self enabled
		  ifTrue: [ ToEnabledSkinEvent ]
		  ifFalse: [ ToDisabledSkinEvent ]
]
