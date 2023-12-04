Class {
	#name : 'ToEnablementState',
	#superclass : 'ToSkinManagementState',
	#instVars : [
		'enabled'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToEnablementState >> enabled [

	^ enabled
]

{ #category : 'accessing' }
ToEnablementState >> enabled: aBoolean [

	enabled := aBoolean
]

{ #category : 'accessing' }
ToEnablementState >> lookEventClass [

	^ self enabled
		  ifTrue: [ ToEnabledLookEvent ]
		  ifFalse: [ ToDisabledLookEvent ]
]
