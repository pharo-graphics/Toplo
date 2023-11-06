Class {
	#name : 'ToInstallState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'skin state engine' }
ToInstallState >> enqueueIn: anElement [

	Error signal: 'I can''t be queued directly. It is the element skin state queue responsibility in case of a skin change event.'
]

{ #category : 'testing' }
ToInstallState >> isPersistent [ 

	^ false
]

{ #category : 'look event sending' }
ToInstallState >> lookEventClass [

	^ ToInstallLookEvent
]
