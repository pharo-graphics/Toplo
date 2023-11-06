Class {
	#name : 'ToUninstallState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToUninstallState >> incompatibleStateClasses [

	^ { ToElementState }
]

{ #category : 'testing' }
ToUninstallState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToUninstallState >> lookEventClass [

	^ ToUninstallLookEvent
]
