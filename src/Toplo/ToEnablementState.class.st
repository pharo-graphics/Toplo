Class {
	#name : 'ToEnablementState',
	#superclass : 'ToIntrinsicState',
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

{ #category : 'look event sending' }
ToEnablementState >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	super requestEnqueueFromElement: anElement inQueue: aStateQueue.
	" a requestNewSkin ** must ** be send here after the state enqueuing to ensure that the
	enablement state is the last intrinsic state stored in the element skinManager and that
	as a consequence, an IntialState is runned by the element skinStateQueue after all others intrinsic states"
	anElement requestNewSkin
]
