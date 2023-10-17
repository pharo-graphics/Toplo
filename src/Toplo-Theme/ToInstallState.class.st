Class {
	#name : 'ToInstallState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'skin state engine' }
ToInstallState >> addAsNextStateIn: aSkinStateEngine [

	super addAsNextStateIn: aSkinStateEngine.
	aSkinStateEngine addSkinState: ToInitialState new.
	aSkinStateEngine currentStates do: [ :s | aSkinStateEngine addSkinState: s ]
]

{ #category : 'testing' }
ToInstallState >> isPersistent [ 

	^ false
]

{ #category : 'look event sending' }
ToInstallState >> lookEventClass [

	^ ToInstallLookEvent
]
