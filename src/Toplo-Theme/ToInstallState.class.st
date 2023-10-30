Class {
	#name : 'ToInstallState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'skin state engine' }
ToInstallState >> enqueueIn: anElement [

	" do not send to super here. The state engine will react accordingly "
	anElement skinStateQueue switchToInstallState: self in: anElement
]

{ #category : 'testing' }
ToInstallState >> isPersistent [ 

	^ false
]

{ #category : 'look event sending' }
ToInstallState >> lookEventClass [

	^ ToInstallLookEvent
]
