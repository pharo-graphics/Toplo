Class {
	#name : 'ToUninstallState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
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
