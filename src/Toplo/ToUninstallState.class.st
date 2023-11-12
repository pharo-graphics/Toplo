Class {
	#name : #ToUninstallState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToUninstallState >> incompatibleStateClasses [

	^ { ToElementState }
]

{ #category : #testing }
ToUninstallState >> isPersistent [ 

	^ false
]

{ #category : #accessing }
ToUninstallState >> lookEventClass [

	^ ToUninstallLookEvent
]
